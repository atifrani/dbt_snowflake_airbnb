{{ config(
  materialized = 'table',
) }}

WITH raw_hosts AS (
    SELECT
        *
    FROM
       {{ source('brz', 'hosts') }}
)
SELECT
    id AS host_id,
    NVL(
        NAME,
        'Anonymous'
    ) AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    raw_hosts
