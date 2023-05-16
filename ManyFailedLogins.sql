As a seasoned developer with deep knowledge of PostgreSQL, you will code a set of independent SQL scripts, reading from the following table
binnacle (
	id int4 NOT NULL,
	sistema varchar(255) NULL DEFAULT NULL::character varying,
	usuario int4 NULL,
	id_votacion int4 NULL,
	modulo varchar(255) NULL DEFAULT NULL::character varying,
	evento varchar(255) NULL DEFAULT NULL::character varying,
	ip_publica varchar(255) NULL DEFAULT NULL::character varying,
	"json" json NULL,
	fecha_hora timestamp(0) NULL DEFAULT NULL::timestamp without time zone,
	CONSTRAINT binnacle_pkey PRIMARY KEY (id)
);
the id is a Postgresql sequence named binnacle_id_seq.

and the table 
voting (
	id int4 NOT NULL,
	user_id int4 NULL,
	state_id int4 NOT NULL,
	order_type_point_id int4 NULL,
	"name" varchar(255) NOT NULL,
	description varchar(255) NULL DEFAULT NULL::character varying,
	date_start timestamp(0) NOT NULL,
	date_end timestamp(0) NOT NULL,
	date_end_census timestamp(0) NOT NULL,
	logo varchar(255) NULL,
	public_key text NULL,
	deleted_at timestamp(0) NULL DEFAULT NULL::timestamp without time zone,
	is_private bool NULL DEFAULT false,
	custom_url varchar(20) NULL DEFAULT NULL::character varying,
	is_large_ballot bool NULL DEFAULT false,
	access_type json NOT NULL DEFAULT '[]'::json,
	validation_type int4 NOT NULL DEFAULT 1,
	CONSTRAINT voting_pkey PRIMARY KEY (id)
);

A strong relationship exists between binnacle and voting tables exists defined by voting.id = binnacle.id_votacion.

get time slices of 5 minutes since yesterday at noon. For each time slice, get from binnacle the ip_public, "too_many_failed_logins" as event, count(*)  grouped by id_votacion, ip_publica when binnacle.evento like 'Cliente_Fallo_Login_%' and binnacle.fecha_hora  >=  5 minutes before now and voting.state_id >= 4 and voting.date_end >= yesterday. Extract only the results with count(*) > 5

Ask me for any additional information you need to provide the best code.
