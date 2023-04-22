
DO $$ 
DECLARE
    detection_time TIMESTAMP;
    id_votacion INT;
    ip_publica VARCHAR(255);
    evento VARCHAR(255);
    ini TIMESTAMP;
    fin TIMESTAMP;
    number_records INT;
BEGIN
    detection_time := NOW();

    FOR id_votacion, ip_publica, evento, ini, fin, number_records IN
        SELECT 
            b.id_votacion,
            b.ip_publica,
            b.evento,
            min(b.fecha_hora) as ini,
            max(b.fecha_hora) as fin,
            count(*) as number_records
        FROM 
            binnacle b
        WHERE 
            b.fecha_hora > '2023-04-03 17:00:00'::timestamp
            AND b.evento LIKE 'Cliente_Fallo_Login_%'
        GROUP BY 
            b.id_votacion, b.ip_publica, b.evento, date_trunc('hour', b.fecha_hora) + INTERVAL '10 min' * floor(extract('minute' FROM b.fecha_hora) / 10)
        HAVING 
            count(*) >= 20
    LOOP
        -- Perform any required actions with the results here
        RAISE NOTICE 'id_votacion: %, ip_publica: %, evento: %, ini: %, fin: %, number_records: %', id_votacion, ip_publica, evento, ini, fin, number_records;
    END LOOP;
END $$;
