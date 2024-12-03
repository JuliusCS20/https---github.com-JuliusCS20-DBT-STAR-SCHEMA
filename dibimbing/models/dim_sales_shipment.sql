{{
  config(
    materialized='table'
  )
}}
With t_data AS (
  SELECT DISTINCT
    status AS status,
    `Courier Status` AS courier_status,
    date AS date
  FROM
    {{ source('bronze', 'amazon_sale_report') }}
)
SELECT {{ dbt_utils.generate_surrogate_key([
        'status', 'courier_status', 'date'
      ]) }} AS sales_shipment_id, *
FROM t_data