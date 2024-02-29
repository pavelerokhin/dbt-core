{% snapshot dimension_1_created_snapshot %}
{{
    config(
      target_database='datawarehouse',
      target_schema='snapshots',
      strategy='timestamp',
      unique_key='product_id',
      updated_at='updated_at',
      created_at='created_at',
    )
}}

SELECT *
FROM
  {{ source('datawarehouse','dimension') }}

{% endsnapshot %}
