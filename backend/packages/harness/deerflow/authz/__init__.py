"""Pluggable fine-grained authorization (resource-level RBAC and beyond)."""

from SynapseAI.authz.adapter import GuardrailAuthorizationAdapter
from SynapseAI.authz.enforcement import filter_tools_by_authorization
from SynapseAI.authz.principal import build_principal_from_context, normalize_authz_attributes
from SynapseAI.authz.provider import AuthorizationProvider, AuthzDecision, AuthzReason, AuthzRequest, Principal
from SynapseAI.authz.rbac import RbacAuthorizationProvider
from SynapseAI.authz.runtime import resolve_authorization_provider
from SynapseAI.authz.tool_filter import apply_tool_authorization

__all__ = [
    "AuthzDecision",
    "AuthzReason",
    "AuthzRequest",
    "AuthorizationProvider",
    "GuardrailAuthorizationAdapter",
    "Principal",
    "RbacAuthorizationProvider",
    "apply_tool_authorization",
    "build_principal_from_context",
    "filter_tools_by_authorization",
    "normalize_authz_attributes",
    "resolve_authorization_provider",
]
