SELECT 
    b.id_votacion,
    b.ip_publica,
    'to_fast' AS event,
    COUNT(*) 
FROM 
    binnacle b
JOIN 
    voting v ON b.id_votacion = v.id
WHERE 
    b.evento = 'ingreso_papeleta' 
    AND b.fecha_hora >= (CURRENT_TIMESTAMP - INTERVAL '5 minutes') 
    AND v.state_id >= 4 
    AND v.date_end >= (CURRENT_DATE - INTERVAL '1 day')
GROUP BY 
    b.id_votacion, 
    b.ip_publica
HAVING 
    COUNT(*) > 10;

