{{ config(
    materialized="incremental",
    unique_key="id",
    indexes=[
        { "columns": ["product_id"], "unique": True },
        { "columns": ["updated_at", "created_at"] }
    ]
)}}

SELECT DISTINCT ON (p.product_id)
    p.product_id,
    p.product_name,
    p.category,
    p.updated_at,
    p.created_at
FROM {{ source('datawarehouse', 'dimension') }} p
