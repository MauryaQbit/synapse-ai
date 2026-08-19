"""Feedback persistence — ORM and SQL repository."""

from SynapseAI.persistence.feedback.model import FeedbackRow
from SynapseAI.persistence.feedback.sql import FeedbackRepository

__all__ = ["FeedbackRepository", "FeedbackRow"]
