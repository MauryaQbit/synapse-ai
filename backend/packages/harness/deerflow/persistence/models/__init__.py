"""ORM model registration entry point.

Importing this module ensures all ORM models are registered with
``Base.metadata`` so Alembic autogenerate detects every table.

The actual ORM classes have moved to entity-specific subpackages:
- ``SynapseAI.persistence.thread_meta``
- ``SynapseAI.persistence.run``
- ``SynapseAI.persistence.feedback``
- ``SynapseAI.persistence.user``

``RunEventRow`` remains in ``SynapseAI.persistence.models.run_event`` because
its storage implementation lives in ``SynapseAI.runtime.events.store.db`` and
there is no matching entity directory.
"""

from SynapseAI.persistence.agents.model import AgentRow
from SynapseAI.persistence.channel_connections.model import (
    ChannelConnectionRow,
    ChannelConversationRow,
    ChannelCredentialRow,
    ChannelOAuthStateRow,
)
from SynapseAI.persistence.feedback.model import FeedbackRow
from SynapseAI.persistence.mcp_tasks.model import McpTaskRow
from SynapseAI.persistence.models.run_event import RunEventRow
from SynapseAI.persistence.run.model import RunRow
from SynapseAI.persistence.scheduled_task_runs.model import ScheduledTaskRunRow
from SynapseAI.persistence.scheduled_tasks.model import ScheduledTaskRow
from SynapseAI.persistence.thread_meta.model import ThreadMetaRow
from SynapseAI.persistence.user.model import UserRow
from SynapseAI.persistence.webhook_delivery.model import WebhookDeliveryRow

__all__ = [
    "AgentRow",
    "ChannelConnectionRow",
    "ChannelConversationRow",
    "ChannelCredentialRow",
    "ChannelOAuthStateRow",
    "FeedbackRow",
    "McpTaskRow",
    "RunEventRow",
    "RunRow",
    "ScheduledTaskRow",
    "ScheduledTaskRunRow",
    "ThreadMetaRow",
    "UserRow",
    "WebhookDeliveryRow",
]
