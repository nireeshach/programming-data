"""empty message

Revision ID: 9f17337d4c32
Revises: 
Create Date: 2018-08-03 11:06:35.986114

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '9f17337d4c32'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('datacatalog',
    sa.Column('key', sa.String(length=50), nullable=False),
    sa.Column('main_data_source_key', sa.Text(), nullable=True),
    sa.Column('field', sa.Text(), nullable=True),
    sa.Column('entity', sa.Text(), nullable=True),
    sa.Column('normalize_type', sa.Text(), nullable=True),
    sa.PrimaryKeyConstraint('key')
    )
    op.create_table('datasource',
    sa.Column('key', sa.String(length=50), nullable=False),
    sa.Column('name', sa.String(length=50), nullable=True),
    sa.Column('remarks', sa.String(length=50), nullable=True),
    sa.PrimaryKeyConstraint('key')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('datasource')
    op.drop_table('datacatalog')
    # ### end Alembic commands ###
