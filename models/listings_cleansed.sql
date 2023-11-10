{{ config(
  materialized = 'table',
) }}

WITH raw_listings AS (
        SELECT * FROM {{ source('brz', 'listings') }}
)
SELECT 
   id AS listing_id,
   listing_url,
   name AS listing_name,
   room_type,
   CASE
    WHEN minimum_nights = 0 THEN 1
    ELSE minimum_nights
   END AS minimum_nights,
   host_id,
   REPLACE( price, '$' ) :: NUMBER( 10, 2) AS price,
   created_at,
   updated_at
FROM raw_listings
