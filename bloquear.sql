INSERT INTO public.ip_bloqueadas (id, ip_address_ini, ip_address_fin, reason, is_active, created_at, updated_at)
VALUES (DEFAULT, '123.123.123.001', '123.123.123.255', 'no_reason', true, NOW(), NOW());
