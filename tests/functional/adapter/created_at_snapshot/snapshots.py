SNAPSHOT_TIMESTAMP_CREATED_AT_SQL = """
{{% snapshot snapshot_created_at %}
{{
    config(
      target_database=database,
      target_schema=schema,
      unique_key='product_id',
      strategy='timestamp',
      updated_at='updated_at',
      created_at='created_at'
    )
}}

SELECT *
FROM
  select * from {{ ref('dimension') }}
{% endsnapshot %}
"""


SNAPSHOT_TIMESTAMP_NO_CREATED_AT_SQL = """
{{% snapshot snapshot_no_created_at %}
{{
    config(
      target_database=database,
      target_schema=schema,
      unique_key='product_id',
      strategy='timestamp',
      updated_at='updated_at'
    )
}}

SELECT *
FROM
  select * from {{ ref('dimension') }}
{% endsnapshot %}
"""
