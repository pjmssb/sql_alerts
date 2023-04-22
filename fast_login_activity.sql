/*
Alta Velocidad
*/

WITH time_slices AS (
    SELECT generate_series(
        date_trunc('hour', (SELECT max(fecha_hora) FROM binnacle) - '360 minutes'::interval),
        (SELECT max(fecha_hora) FROM binnacle),
        '10 minutes'::interval
    ) AS slice_start,
    generate_series(
        date_trunc('hour', (SELECT max(fecha_hora) FROM binnacle) - '360 minutes'::interval) + '10 minutes'::interval,
        (SELECT max(fecha_hora) FROM binnacle),
        '10 minutes'::interval
    ) AS slice_end
)
SELECT 
    current_timestamp AS detection_time,
    id_votacion,
    ip_publica,
    min(fecha_hora) AS ini,
    max(fecha_hora) AS fin,
    count(*) AS number_records
FROM binnacle, time_slices
WHERE fecha_hora BETWEEN time_slices.slice_start AND time_slices.slice_end
AND id_votacion = binnacle.id_votacion
AND ip_publica = binnacle.ip_publica
GROUP BY id_votacion, ip_publica, time_slices.slice_start
HAVING count(*) >= 10; --100;


/* 
Muchos login de la misma IP

*/
