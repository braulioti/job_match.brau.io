"""Add validated column to user table

Revision ID: 002_add_validated_to_user
Revises: 001_create_user_table
Create Date: 2015-12-22 00:00:00.000000

"""
from alembic import op
import sqlalchemy as sa

# revision identifiers, used by Alembic.
revision = '002_add_validated_to_user'
down_revision = '001_create_user_table'
branch_labels = None
depends_on = None


def upgrade() -> None:
    """
    Add validated and hash_validated columns to user table after hash column
    """
    op.add_column(
        'user',
        sa.Column(
            'validated',
            sa.Boolean(),
            nullable=False,
            server_default=sa.text('false'),
            comment='User validation status'
        )
    )
    op.add_column(
        'user',
        sa.Column(
            'hash_validated',
            sa.String(length=36),
            nullable=True,
            unique=True,
            comment='UUID v4 hash for validation'
        )
    )
    op.create_index('idx_user_hash_validated', 'user', ['hash_validated'], unique=True)


def downgrade() -> None:
    """
    Remove validated and hash_validated columns from user table
    """
    op.drop_index('idx_user_hash_validated', table_name='user')
    op.drop_column('user', 'hash_validated')
    op.drop_column('user', 'validated')

