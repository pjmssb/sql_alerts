SELECT 
    current_timestamp as detection_time,
    id_votacion,
    ip_publica,
    date_trunc('hour', fecha_hora) + 
        (date_part('minute', fecha_hora)::int / 30) * interval '30 min' as time_slice,
    min(fecha_hora) as ini,
    max(fecha_hora) as fin,
    count(*) as number_records
FROM 
    binnacle
WHERE 
    fecha_hora > '2023-04-03 17:00:00'
GROUP BY 
    id_votacion,
    ip_publica,
    date_trunc('hour', fecha_hora) + 
        (date_part('minute', fecha_hora)::int / 30) * interval '30 min'
HAVING 
    count(DISTINCT usuario) > 5;
