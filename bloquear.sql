select setval('ip_bloqueadas_id_seq', (select max(id) from ip_bloqueadas));

INSERT INTO public.ip_bloqueadas (
  id,   
  ip_address_ini, 
  ip_address_fin, 
  reason, 
  is_active, 
  created_at, 
  updated_at, 
  voting_id, 
  rejection_count
) VALUES (
  nextval('ip_bloqueadas_id_seq'),
  '172.121.255.0', 
  '172.121.255.255', 
  'SM', 
  true, 
  now(), 
  now(), 
  null, 
  0
);
