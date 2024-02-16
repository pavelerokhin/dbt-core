{{ config(
    materialized="incremental",
    unique_key="transaction_id",
    indexes=[
        { "columns": ["transaction_id"], "unique": True },
    ]
)}}

SELECT
    s.transaction_id,
    s.product_id,
    s.quantity,
    s.total_amount,
    s.sale_date
FROM {{ source('datawarehouse', 'fact') }} s
