{{
  config(
    materialized='table'
  )
}}
With t_data AS (
  SELECT DISTINCT
    `Sales Channel ` AS sales_channel,
    currency AS currency
  FROM
    {{ source('bronze', 'amazon_sale_report') }}
)
SELECT {{ dbt_utils.generate_surrogate_key([
        'sales_channel', 'currency'
      ]) }} AS sales_channel_id, *
FROM t_data