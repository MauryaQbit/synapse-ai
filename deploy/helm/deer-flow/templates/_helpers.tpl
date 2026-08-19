{{/*
Common helpers for the SynapseAI chart.
*/}}

{{- define "synapse-ai.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "synapse-ai.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "synapse-ai.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "synapse-ai.labels" -}}
helm.sh/chart: {{ include "synapse-ai.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "synapse-ai.selectorLabels" -}}
app.kubernetes.io/name: {{ include "synapse-ai.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "synapse-ai.namespace" -}}
{{- default .Release.Namespace .Values.namespace -}}
{{- end -}}

{{- define "synapse-ai.imagePullSecrets" -}}
{{- with .Values.image.pullSecrets }}
imagePullSecrets:
{{- toYaml . | nindent 0 }}
{{- end }}
{{- end -}}

{{/* Fully-qualified image refs for the three SynapseAI images.
     When `image.registry` is empty, omit the prefix so the ref is
     `synapse-ai-gateway:latest` (local-image mode, imagePullPolicy: Never). */}}
{{- define "synapse-ai.gatewayImage" -}}
{{- if .Values.image.registry -}}{{- printf "%s/%s:%s" .Values.image.registry .Values.image.gatewayImage .Values.image.tag -}}
{{- else -}}{{- printf "%s:%s" .Values.image.gatewayImage .Values.image.tag -}}{{- end -}}
{{- end -}}

{{- define "synapse-ai.frontendImage" -}}
{{- if .Values.image.registry -}}{{- printf "%s/%s:%s" .Values.image.registry .Values.image.frontendImage .Values.image.tag -}}
{{- else -}}{{- printf "%s:%s" .Values.image.frontendImage .Values.image.tag -}}{{- end -}}
{{- end -}}

{{- define "synapse-ai.provisionerImage" -}}
{{- if .Values.image.registry -}}{{- printf "%s/%s:%s" .Values.image.registry .Values.image.provisionerImage .Values.image.tag -}}
{{- else -}}{{- printf "%s:%s" .Values.image.provisionerImage .Values.image.tag -}}{{- end -}}
{{- end -}}

{{- define "synapse-ai.nginxImage" -}}
{{- printf "%s:%s" .Values.nginx.image.repository .Values.nginx.image.tag -}}
{{- end -}}

{{/* PVC name for the .synapse-ai home directory. */}}
{{- define "synapse-ai.homePVC" -}}
{{- printf "%s-home" (include "synapse-ai.fullname" .) -}}
{{- end -}}

{{/* Name of the Secret holding provider/channel keys. */}}
{{- define "synapse-ai.providerSecret" -}}
{{- if .Values.existingSecret -}}{{- .Values.existingSecret -}}
{{- else -}}{{- printf "%s-provider" (include "synapse-ai.fullname" .) -}}{{- end -}}
{{- end -}}

{{/* Name of the Secret holding generated app secrets (auth token, better-auth). */}}
{{- define "synapse-ai.appSecret" -}}
{{- printf "%s-app" (include "synapse-ai.fullname" .) -}}
{{- end -}}

{{/* Name of the postgres StatefulSet/Service. */}}
{{- define "synapse-ai.postgresFullname" -}}
{{- printf "%s-postgres" (include "synapse-ai.fullname" .) -}}
{{- end -}}

{{/* Name of the Secret holding DATABASE_URL (and, in bundled mode, the
     postgres superuser password). Resolution order:
       1. postgresql.external.existingSecret (user-managed, key=database-url)
       2. postgresql.existingSecret          (user-managed, bundled image)
       3. chart-managed secret `<release>-postgres`
     Only #3 is created by this chart; #1/#2 must exist already. */}}
{{- define "synapse-ai.databaseUrlSecret" -}}
{{- if .Values.postgresql.external.existingSecret -}}{{- .Values.postgresql.external.existingSecret -}}
{{- else if .Values.postgresql.existingSecret -}}{{- .Values.postgresql.existingSecret -}}
{{- else -}}{{- include "synapse-ai.postgresFullname" . -}}{{- end -}}
{{- end -}}

{{/* Name of the redis StatefulSet/Service. */}}
{{- define "synapse-ai.redisFullname" -}}
{{- printf "%s-redis" (include "synapse-ai.fullname" .) -}}
{{- end -}}

{{/* Name of the Secret holding the redis stream-bridge URL (key `redis-url`,
     plus `redis-password` in bundled mode when a password is set). Resolution:
       1. redis.external.existingSecret (user-managed, key=redis-url)
       2. redis.existingSecret          (user-managed, bundled image)
       3. chart-managed secret `<release>-redis`
     Only #3 is created by this chart; #1/#2 must exist already. */}}
{{- define "synapse-ai.redisUrlSecret" -}}
{{- if .Values.redis.external.existingSecret -}}{{- .Values.redis.external.existingSecret -}}
{{- else if .Values.redis.existingSecret -}}{{- .Values.redis.existingSecret -}}
{{- else -}}{{- include "synapse-ai.redisFullname" . -}}{{- end -}}
{{- end -}}

{{/* Whether any redis stream-bridge backend is configured (bundled StatefulSet,
     external URL, or a user-managed Secret). Drives the env injection in the
     gateway deployment. */}}
{{- define "synapse-ai.redisConfigured" -}}
{{- or .Values.redis.enabled .Values.redis.external.redisUrl .Values.redis.external.existingSecret .Values.redis.existingSecret -}}
{{- end -}}

{{/* SHA256 checksums of the ConfigMaps. Mount these as pod-template
     annotations: ConfigMaps mounted via subPath do NOT receive live updates,
     so a `helm upgrade` that only changes a ConfigMap would leave pods on stale
     config. A checksum annotation makes any content change alter the pod spec,
     which triggers a rolling restart. */}}
{{- define "synapse-ai.configChecksum" -}}
{{- include (print $.Template.BasePath "/configmap-config.yaml") . | sha256sum -}}
{{- end -}}

{{- define "synapse-ai.extensionsChecksum" -}}
{{- include (print $.Template.BasePath "/configmap-extensions.yaml") . | sha256sum -}}
{{- end -}}

{{- define "synapse-ai.nginxChecksum" -}}
{{- include (print $.Template.BasePath "/configmap-nginx.yaml") . | sha256sum -}}
{{- end -}}

{{/* Percent-encode a string for safe interpolation into a URL userinfo
     (password) segment of a DSN. Sprig lacks urlqueryescape, and
     regexReplaceAllLiteral treats `replacement` as a regex template so chars
     like `[`, `]`, `?` break it - so we chain plain `replace` calls instead.
     `%` is encoded first to avoid double-encoding the percent signs emitted
     for the other characters. Covers the URL-special chars a managed-DB
     password might contain (`@ : / # ? % [ ]` and space). */}}
{{- define "synapse-ai.urlEscape" -}}
{{- $s := . -}}
{{- $s = replace "%" "%25" $s -}}
{{- $s = replace "@" "%40" $s -}}
{{- $s = replace ":" "%3A" $s -}}
{{- $s = replace "/" "%2F" $s -}}
{{- $s = replace "#" "%23" $s -}}
{{- $s = replace "?" "%3F" $s -}}
{{- $s = replace "[" "%5B" $s -}}
{{- $s = replace "]" "%5D" $s -}}
{{- $s = replace " " "%20" $s -}}
{{- $s -}}
{{- end -}}
