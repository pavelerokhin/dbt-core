{% snapshot dimension_2_no_created_snapshot %}
{{
    config(
      target_database='datawarehouse',
      target_schema='snapshots',
      strategy='timestamp',
      unique_key='product_id',
      updated_at='updated_at',
    )
}}

SELECT *
FROM
  {{ source('datawarehouse','dimension') }}
WHERE product_name = 'iron'
{% endsnapshot %}
