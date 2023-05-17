SELECT 
    b.id_votacion,
    b.ip_publica,
    'too_many_failed_logins' AS event,
    COUNT(*) 
FROM 
    binnacle b
JOIN 
    voting v ON b.id_votacion = v.id
WHERE 
    b.evento LIKE 'Cliente_Fallo_Login_%' 
    AND b.fecha_hora >= (CURRENT_TIMESTAMP - INTERVAL '5 minutes') 
    AND v.state_id >= 4 
    AND v.date_end >= (CURRENT_DATE - INTERVAL '1 day')
GROUP BY 
    b.id_votacion, 
    b.ip_publica
HAVING 
    COUNT(*) > 5;

-- Obtener el análisis para los periodos de 5 minutos desde ayer  
WITH time_slices AS (
    SELECT generate_series(
        DATE_TRUNC('day', CURRENT_DATE - INTERVAL '1 day') + INTERVAL '12 hour',
        CURRENT_TIMESTAMP,
        INTERVAL '5 minute'
    ) AS slice
)
SELECT 
    b.id_votacion,
    b.ip_publica,
    'too_many_failed_logins' AS event,
    COUNT(*)
FROM 
    time_slices ts
JOIN 
    binnacle b ON b.fecha_hora >= ts.slice AND b.fecha_hora < ts.slice + INTERVAL '5 minutes'
JOIN 
    voting v ON b.id_votacion = v.id
WHERE 
    b.evento LIKE 'Cliente_Fallo_Login_%' 
    AND v.state_id >= 4 
    AND v.date_end >= (CURRENT_DATE - INTERVAL '1 day')
GROUP BY 
    ts.slice, 
    b.id_votacion, 
    b.ip_publica
HAVING 
    COUNT(*) > 0;
