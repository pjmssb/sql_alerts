WITH ip_counts AS (
    SELECT
        usuario,
        id_votacion,
        date_trunc('hour', fecha_hora) + INTERVAL '30 min' * floor(extract(minute from fecha_hora) / 30) AS time_slice,
        COUNT(DISTINCT ip_publica) AS ip_count
    FROM
        binnacle
    WHERE
        fecha_hora > '2023-04-03 17:00:00'
    GROUP BY
        usuario, id_votacion, time_slice
),
filtered_users AS (
    SELECT
        usuario,
        id_votacion
    FROM
        ip_counts
    WHERE
        ip_count > 5
    GROUP BY
        usuario, id_votacion
)
SELECT
    NOW() AS detection_time,
    f.id_votacion,
    f.usuario,
    MIN(b.fecha_hora) AS ini,
    MAX(b.fecha_hora) AS fin,
    COUNT(*) AS number_records
FROM
    binnacle AS b
JOIN
    filtered_users AS f ON b.usuario = f.usuario AND b.id_votacion = f.id_votacion
WHERE
    b.fecha_hora > '2023-04-03 17:00:00'
GROUP BY
    f.usuario, f.id_votacion;
