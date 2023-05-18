SELECT 
    b.id_votacion, 
    b.ip_publica, 
    'many_users' as event, 
    COUNT(DISTINCT b.usuario) as count
FROM 
    binnacle b
JOIN 
    voting v ON v.id = b.id_votacion
WHERE 
    b.evento = 'ingreso_papeleta' 
    AND b.fecha_hora >= (NOW() - INTERVAL '5 minutes') 
    AND v.state_id >= 4
GROUP BY 
    b.id_votacion, 
    b.ip_publica
HAVING 
    COUNT(DISTINCT b.usuario) > 4;
