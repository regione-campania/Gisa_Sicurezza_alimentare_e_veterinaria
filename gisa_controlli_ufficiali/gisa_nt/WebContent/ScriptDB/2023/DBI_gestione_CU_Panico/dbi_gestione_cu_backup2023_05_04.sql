PGDMP     +    .                {           gisa    15.1    15.1 @    Y0           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            Z0           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            [0           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            \0           1262    191901    gisa    DATABASE     p   CREATE DATABASE gisa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE gisa;
                postgres    false                        2615    398109    dbi_gestione_cu    SCHEMA        CREATE SCHEMA dbi_gestione_cu;
    DROP SCHEMA dbi_gestione_cu;
                postgres    false            u           1255    417560    asl_is_valid(integer)    FUNCTION     �   CREATE FUNCTION dbi_gestione_cu.asl_is_valid(_site_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN

if(_site_id >= 201 AND _site_id <= 207)THEN
	return true; 
ELSE
	return false;
END IF; 

END
$$;
 >   DROP FUNCTION dbi_gestione_cu.asl_is_valid(_site_id integer);
       dbi_gestione_cu          postgres    false    26                       1255    418063    date_is_valid(date, date, date)    FUNCTION     A  CREATE FUNCTION dbi_gestione_cu.date_is_valid(_data_fine_controllo date, _data_inizio_controllo date, _entered date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE 
anno_controllo text;

BEGIN

if(_data_fine_controllo < _data_inizio_controllo)THEN
	return false; 
ELSE
	return true;
END IF; 

if(_data_inizio_controllo > _entered)THEN
	return false;
ELSE 
	return true;
END IF; 

anno_controllo := (select split_part(cast(_data_inizio_controllo as text), '-', 1));

if(cast(anno_controllo as integer) <> 2023)THEN 
	return false;
ELSE
	return true; 
END IF; 

END
$$;
 t   DROP FUNCTION dbi_gestione_cu.date_is_valid(_data_fine_controllo date, _data_inizio_controllo date, _entered date);
       dbi_gestione_cu          postgres    false    26            �           1255    418099 #   date_is_valid_ncp(date, date, date)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.date_is_valid_ncp(_data_fine_controllo date, _data_inizio_controllo date, _entered date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE 
anno_controllo text;

BEGIN

if(_data_fine_controllo < _data_inizio_controllo)THEN
	return false; 
ELSE
	return true;
END IF; 

if(_data_inizio_controllo > _entered)THEN
	return false;
ELSE 
	return true;
END IF; 

END
$$;
 x   DROP FUNCTION dbi_gestione_cu.date_is_valid_ncp(_data_fine_controllo date, _data_inizio_controllo date, _entered date);
       dbi_gestione_cu          postgres    false    26            }           1255    417923    date_null(date)    FUNCTION     �   CREATE FUNCTION dbi_gestione_cu.date_null(valore date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

 BEGIN

	if(valore is not null)THEN 
		return true;
	END IF;

return false;
END
$$;
 6   DROP FUNCTION dbi_gestione_cu.date_null(valore date);
       dbi_gestione_cu          postgres    false    26            �           1255    418173    entered_ext_is_valid(integer)    FUNCTION     $  CREATE FUNCTION dbi_gestione_cu.entered_ext_is_valid(_enteredby integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE 

validatore_entered integer;

BEGIN

select count (user_id) from access_ext where user_id = _enteredby AND in_access = true AND role_id in (select role_id  from role_permission_ext  where permission_id  = 307 and role_add = true and role_view = true and role_edit = true) into validatore_entered;
raise info '%s', validatore_entered;
if(validatore_entered > 0)THEN
	return true; 
ELSE
	return false;
END IF; 

END
$$;
 H   DROP FUNCTION dbi_gestione_cu.entered_ext_is_valid(_enteredby integer);
       dbi_gestione_cu          postgres    false    26            �           1255    418170    entered_is_valid(integer)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.entered_is_valid(_enteredby integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE 

validatore_entered integer;

BEGIN

validatore_entered := (select count (user_id) from access where user_id = enteredby AND in_access = true AND role_id in (select role_id  from role_permission  where permission_id  = 307 and role_add = true and role_view = true and role_edit = true));
if(validatore_entered > 0)THEN
	return true; 
ELSE
	return false;
END IF; 

END
$$;
 D   DROP FUNCTION dbi_gestione_cu.entered_is_valid(_enteredby integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443013 "   estrazione_linee_attivita(integer)    FUNCTION     >  CREATE FUNCTION dbi_gestione_cu.estrazione_linee_attivita(id_stabilimento integer) RETURNS TABLE(codice integer, descrizione text)
    LANGUAGE plpgsql
    AS $$
BEGIN	

return query
select id_linea, path_attivita_completo from ricerche_anagrafiche_old_materializzata where riferimento_id = id_stabilimento;

END 
$$;
 R   DROP FUNCTION dbi_gestione_cu.estrazione_linee_attivita(id_stabilimento integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443008 #   estrazione_motivi(integer, integer)    FUNCTION     )  CREATE FUNCTION dbi_gestione_cu.estrazione_motivi(tipo_controllo integer, anno_del_controllo integer) RETURNS TABLE(codice integer, descrizione character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 

_enabled boolean;

BEGIN
_enabled := true;
if(anno_del_controllo < 2023)THEN
	_enabled := false;
END IF;
if(tipo_controllo = 1)THEN
	return query 
	select code, description from lookup_tipo_ispezione 
	where anno = anno_del_controllo AND enabled = _enabled; 
END IF;
if(tipo_controllo = 2)THEN 
		return query
		select code, description from lookup_piano_monitoraggio
		where anno = anno_del_controllo AND enabled = _enabled;

END IF; 

if(tipo_controllo < 1 OR tipo_controllo > 2)THEN 
	RAISE EXCEPTION 'Il tipo controllo puo essere solo 1 per il piano monitoraggio e 2 per l"attivita';
END IF;

END
$$;
 e   DROP FUNCTION dbi_gestione_cu.estrazione_motivi(tipo_controllo integer, anno_del_controllo integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443011     estrazione_motivi_audit(integer)    FUNCTION     U  CREATE FUNCTION dbi_gestione_cu.estrazione_motivi_audit(anno_del_controllo integer) RETURNS TABLE(codice integer, descrizione character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
_enabled boolean;
BEGIN
_enabled := true;
if(anno_del_controllo < 2023)THEN
_enabled := false;
END IF;

	return query
 	select f.code, f.description from dpat_piano_attivita_new as d
	left join dpat_indicatore_new as c on d.id = c.id_piano_attivita 
	left join lookup_tipo_ispezione as f on c.id = f.code
	where d.tipo_attivita= 'ATTIVITA-AUDIT'AND f.anno = anno_del_controllo AND f.enabled = _enabled;
END 
$$;
 S   DROP FUNCTION dbi_gestione_cu.estrazione_motivi_audit(anno_del_controllo integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443182 $   estrazione_nucleo_ispettivo(integer)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.estrazione_nucleo_ispettivo(_id_struttura integer) RETURNS TABLE(codice integer, descrizione character varying, ruolo character varying, cognome character varying, nome character varying, id_struttura integer, struttura character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN	

if(_id_struttura is null)THEN
	return query 
	select a.user_id, a.username, r.role, c.namelast, c.namefirst, d.id_struttura, d.descrizione
	from access as a
	left join role as r on r.role_id = a.role_id
	left join contact as c on a.contact_id = c.contact_id	
	left join dpat_strumento_calcolo_nominativi as d on d.id_anagrafica_nominativo = a.user_id
	where r.enabled and r.in_nucleo_ispettivo = true and r.role_id in (3373,3368,3367,3369,3370,3366,3365,3375);
ELSE 
	return query
	select a.user_id, a.username, r.role, c.namelast, c.namefirst, d.id_struttura, d.descrizione
	from access as a
	left join contact as c on  a.contact_id = c.contact_id
	left join role as r on a.role_id = r.role_id 
	left join dpat_strumento_calcolo_nominativi as d on d.id_anagrafica_nominativo = a.user_id
	where a.in_nucleo_ispettivo= true AND d.id_struttura = _id_struttura;
END IF;

END 
$$;
 R   DROP FUNCTION dbi_gestione_cu.estrazione_nucleo_ispettivo(_id_struttura integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443186 !   estrazione_nucleo_ispettivo_ext()    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.estrazione_nucleo_ispettivo_ext() RETURNS TABLE(user_id integer, username character varying, ruolo character varying, cognome character varying, nome character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN	

return query
select a.user_id, a.username, r.role, c.namelast, c.namefirst 
from access_ext as a
left join role_ext as r on r.role_id = a.role_id
left join contact_ext as c on c.contact_id = a.contact_id
where a.in_nucleo_ispettivo = true;

END 
$$;
 A   DROP FUNCTION dbi_gestione_cu.estrazione_nucleo_ispettivo_ext();
       dbi_gestione_cu          postgres    false    26            �           1255    442997 "   estrazione_oggetto_del_controllo()    FUNCTION       CREATE FUNCTION dbi_gestione_cu.estrazione_oggetto_del_controllo() RETURNS TABLE(codice integer, descrizione character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN	
	
	return query
	select code, description from lookup_ispezione where enabled = true;
	
END
$$;
 B   DROP FUNCTION dbi_gestione_cu.estrazione_oggetto_del_controllo();
       dbi_gestione_cu          postgres    false    26            �           1255    443362 )   estrazione_per_conto_di(integer, integer)    FUNCTION       CREATE FUNCTION dbi_gestione_cu.estrazione_per_conto_di(_site_id integer, anno_del_controllo integer) RETURNS TABLE(codice integer, asl integer, struttura_complessa character varying, struttura_semplice character varying)
    LANGUAGE plpgsql
    AS $$

BEGIN

if(_site_id = 14)THEN
	return query
	select d.id,d.id_asl, d.descrizione_padre, d.descrizione_struttura from dpat_strutture_asl as d 
	where d.id_asl = _site_id and d.data_scadenza is null and d.disabilitato is false;
END IF;

if(anno_del_controllo < 2023)THEN
	return query
	select d.id, d.id_asl, d.descrizione_padre, d.descrizione_struttura from dpat_strutture_asl as d 
	where d.id_asl = _site_id AND d.anno = anno_del_controllo and d.livello = 3 and d.data_scadenza is null and d.disabilitato is false;
ELSE
	return query 
	select d.id, d.id_asl, d.descrizione_padre, d.descrizione_struttura from dpat_strutture_asl as d
	where d.id_asl = _site_id AND d.anno = anno_del_controllo and d.data_scadenza is null and d.disabilitato is false and d.livello = 3;
END IF;

END 
$$;
 e   DROP FUNCTION dbi_gestione_cu.estrazione_per_conto_di(_site_id integer, anno_del_controllo integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443967 /   gestione_tabella_log(integer, integer, integer)    FUNCTION     �)  CREATE FUNCTION dbi_gestione_cu.gestione_tabella_log(_ticketid integer, gestione integer, _provvedimenti_prescrittivi integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
motivo_log json;
oggetto_log json;
nucleo_log json;
linea_log json;
piano_log json; 
log_finale json;
i integer; 
id_tipo integer;
motivo json;
piano json;
BEGIN 

	if(_provvedimenti_prescrittivi = 3)THEN
		id_tipo := (select min(id) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND enabled = true AND tipoispezione <> -1); 
		oggetto_log := (select json_agg(ispezione) oggetto_del_controllo from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND ispezione <> -1);
		nucleo_log :=(select json_agg(id_componente) from cu_nucleo where id_controllo_ufficiale = _ticketid AND enabled = true);
		linea_log := (select json_agg(id_linea_attivita)from linee_attivita_controlli_ufficiali where id_controllo_ufficiale = _ticketid AND trashed_date is null);
		motivo_log := ('{ "IdAttivita": '||(select (tipoispezione) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND tipoispezione <> -1 AND enabled = true AND id = id_tipo)::text||',  "IdPerContoDi": '||(select (id_unita_operativa) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND id_unita_operativa <> -1 AND enabled = true AND id = id_tipo)::text||'}');
		motivo := ('['||motivo_log||']');
		i := 1;
		while(motivo_log is not null)LOOP
			motivo_log := ('{ "IdAttivita": '||(select (tipoispezione) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND tipoispezione <> -1 AND enabled = true AND id = (id_tipo + i))::text||',  "IdPerContoDi": '||(select (id_unita_operativa) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND id_unita_operativa <> -1 AND enabled = true AND id = (id_tipo + i))::text||'}');
			if(motivo_log is not null)THEN
				motivo := (motivo::jsonb || motivo_log::jsonb);
			END IF;
			i := i + 1;
		END LOOP;	
		log_finale :=  ('{ "Note": "' ||(select problem from ticket where ticketid = _ticketid)::text || '", "DataInizioControllo": "' ||(select assigned_date from ticket where ticketid = _ticketid)::text || '", "DataFineControllo": "' ||(select data_fine_controllo from ticket where ticketid = _ticketid)::text || '", "OggettoDelControllo": '||oggetto_log||', "Motivi": '||motivo||', "NucleoIspettivo": '||nucleo_log||', "LineaAttivita": '||linea_log||' }');	
	END IF; 
	
	if(_provvedimenti_prescrittivi = 4)THEN
		id_tipo := (select min(id) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND enabled = true AND tipoispezione <> -1); 
		oggetto_log := (select json_agg(ispezione) oggetto_del_controllo from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND ispezione <> -1);
		nucleo_log :=(select json_agg(id_componente) from cu_nucleo where id_controllo_ufficiale = _ticketid AND enabled = true);
		linea_log := (select id_linea_attivita from linee_attivita_controlli_ufficiali where id_controllo_ufficiale = _ticketid AND trashed_date is null);

		i := 1;
		motivo_log := ('{ "IdAttivita": '||(select (tipoispezione) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND tipoispezione <> -1 AND enabled = true AND id = id_tipo)::text||',  "IdPerContoDi": '||(select (id_unita_operativa) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND tipoispezione <> -1 AND tipoispezione <> 89  AND enabled = true AND id = id_tipo)::text||'}');
		motivo := ('['||motivo_log||']');
		raise info 'motivo log: %', motivo_log;
		while(motivo_log is not null)LOOP
			motivo_log := ('{ "IdAttivita": '||(select (tipoispezione) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND tipoispezione <> -1 AND enabled = true AND id = (id_tipo + i))::text||',  "IdPerContoDi": '||(select (id_unita_operativa) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND tipoispezione <> -1 AND tipoispezione <> 89 AND enabled = true AND id = (id_tipo + i))::text||'}');
			if(motivo_log is not null)THEN
				motivo := (motivo::jsonb || motivo_log::jsonb);
				raise info 'motivo : %', motivo;
			END IF;
			i := i + 1;
		END LOOP;	
		
		i := i - 1;
		piano_log := ('{ "IdPiano": '||(select (pianomonitoraggio) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND pianomonitoraggio <> -1 AND enabled = true AND id = (id_tipo + i))::text||',  "IdPerContoDi": '||(select (id_unita_operativa) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND id_unita_operativa <> -1 AND enabled = true AND id = (id_tipo + i))::text||'}');
		piano := ('['||piano_log||']');
		raise info 'piano Log: %', piano;
		raise info 'i :%', i;
		
		while(piano_log is not null)LOOP
			i := i + 1;
			piano_log := ('{ "IdPiano": '||(select (pianomonitoraggio) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND pianomonitoraggio <> -1 AND enabled = true AND id = (id_tipo + i))::text||',  "IdPerContoDi": '||(select (id_unita_operativa) from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND id_unita_operativa <> -1 AND enabled = true AND id = (id_tipo + i))::text||'}');
			if(piano_log is not null)THEN
				piano := (piano::jsonb || piano_log::jsonb);
				raise info 'piano: %', piano;
			END IF;
		END LOOP;	
		 raise info '%', motivo;
		if(piano is not null AND motivo is not null)THEN
			log_finale :=  ('{ "Note": "' ||(select problem from ticket where ticketid = _ticketid)::text || '", "DataInizioControllo": "' ||(select assigned_date from ticket where ticketid = _ticketid)::text || '", "DataFineControllo": "' ||(select data_fine_controllo from ticket where ticketid = _ticketid)::text || '", "OggettoDelControllo": '||oggetto_log||', "Attivita": '||motivo||', "Piano": '||piano||', "NucleoIspettivo": '||nucleo_log||', "LineaAttivita": '||linea_log||' }');	
		END IF;
		if(piano is not null AND motivo is null)THEN
			log_finale :=  ('{ "Note": "' ||(select problem from ticket where ticketid = _ticketid)::text || '", "DataInizioControllo": "' ||(select assigned_date from ticket where ticketid = _ticketid)::text || '", "DataFineControllo": "' ||(select data_fine_controllo from ticket where ticketid = _ticketid)::text || '", "OggettoDelControllo": '||oggetto_log||', "Piano": '||piano||', "NucleoIspettivo": '||nucleo_log||', "LineaAttivita": '||linea_log||' }');	
		END IF;
		if(piano is null AND motivo is not null)THEN
			log_finale :=  ('{ "Note": "' ||(select problem from ticket where ticketid = _ticketid)::text || '", "DataInizioControllo": "' ||(select assigned_date from ticket where ticketid = _ticketid)::text || '", "DataFineControllo": "' ||(select data_fine_controllo from ticket where ticketid = _ticketid)::text || '", "OggettoDelControllo": '||oggetto_log||', "Attivita": '||motivo||', "NucleoIspettivo": '||nucleo_log||', "LineaAttivita": '||linea_log||' }');	
		END IF;
	END IF;
	
	if(_provvedimenti_prescrittivi = 1)THEN
		oggetto_log := (select json_agg(ispezione) oggetto_del_controllo from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND ispezione <> -1);
		nucleo_log :=(select json_agg(id_componente) from cu_nucleo where id_controllo_ufficiale = _ticketid AND enabled = true);
		linea_log := (select id_linea_attivita from linee_attivita_controlli_ufficiali where id_controllo_ufficiale = _ticketid AND trashed_date is null);
		log_finale :=  ('{ "Note": "' ||(select problem from ticket where ticketid = _ticketid)::text || '", "DataInizioControllo": "' ||(select assigned_date from ticket where ticketid = _ticketid)::text || '", "DataFineControllo": "' ||(select data_fine_controllo from ticket where ticketid = _ticketid)::text || '", "OggettoDelControllo": '||oggetto_log||', "NucleoIspettivo": '||nucleo_log||', "LineaAttivita": '||linea_log||' }');	
	END IF; 
	
	if(_provvedimenti_prescrittivi = 26)THEN
		nucleo_log :=(select json_agg(id_componente) from cu_nucleo where id_controllo_ufficiale = _ticketid AND enabled = true);
		linea_log := (select id_linea_attivita from linee_attivita_controlli_ufficiali where id_controllo_ufficiale = _ticketid AND trashed_date is null);
		motivo_log := (select json_agg(id_unita_operativa) from unita_operative_controllo where id_controllo = _ticketid);
		log_finale :=  ('{ "Note": "' ||(select problem from ticket where ticketid = _ticketid)::text || '", "DataInizioControllo": "' ||(select assigned_date from ticket where ticketid = _ticketid)::text || '", "DataFineControllo": "' ||(select data_fine_controllo from ticket where ticketid = _ticketid)::text || '", "PerContoDi": '||motivo_log||', "NucleoIspettivo": '||nucleo_log||', "LineaAttivita": '||linea_log||' }');	
	END IF; 
	
	if(_provvedimenti_prescrittivi = 2)THEN
		nucleo_log :=(select json_agg(id_componente) from cu_nucleo where id_controllo_ufficiale = _ticketid AND enabled = true);
		linea_log := (select id_linea_attivita from linee_attivita_controlli_ufficiali where id_controllo_ufficiale = _ticketid AND trashed_date is null);
		motivo_log := (select json_agg(id_unita_operativa) from unita_operative_controllo where id_controllo = _ticketid);
		oggetto_log := (select json_agg(ispezione) oggetto_del_controllo from tipocontrolloufficialeimprese where idcontrollo = _ticketid AND ispezione <> -1);
		log_finale :=  ('{ "Note": "' ||(select problem from ticket where ticketid = _ticketid)::text || '", "DataInizioControllo": "' ||(select assigned_date from ticket where ticketid = _ticketid)::text || '", "DataFineControllo": "' ||(select data_fine_controllo from ticket where ticketid = _ticketid)::text || '", "OggettoDelControllo": '||oggetto_log||', "PerContoDi": '||motivo_log||', "NucleoIspettivo": '||nucleo_log||', "LineaAttivita": '||linea_log||' }');	
	END IF; 
	
	if(_provvedimenti_prescrittivi = 5)THEN
		nucleo_log :=(select json_agg(id_componente) from cu_nucleo where id_controllo_ufficiale = _ticketid AND enabled = true);
		motivo_log := (select json_agg(id_unita_operativa) from unita_operative_controllo where id_controllo = _ticketid);
		log_finale :=  ('{ "Note": "' ||(select problem from ticket where ticketid = _ticketid)::text || '", "DataInizioControllo": "' ||(select assigned_date from ticket where ticketid = _ticketid)::text || '", "DataFineControllo": "' ||(select data_fine_controllo from ticket where ticketid = _ticketid)::text || '", "PerContoDi": '||motivo_log||', "NucleoIspettivo": '||nucleo_log||' }');	
	END IF;
		
	
	
	
	
		

if(gestione = 1)THEN
--Popolo la tabella di log preupdate
	insert into dbi_gestione_cu.log_table(id_controllo, pre_controllo)
		VALUES (_ticketid, log_finale);
END IF; 
if(gestione = 2)THEN 
	update dbi_gestione_cu.log_table set post_controllo = log_finale, data_modifica = now() where id_controllo = _ticketid;
END IF;

END 
$$;
 ~   DROP FUNCTION dbi_gestione_cu.gestione_tabella_log(_ticketid integer, gestione integer, _provvedimenti_prescrittivi integer);
       dbi_gestione_cu          postgres    false    26            �           1255    418431 O   get_cu_audit(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.get_cu_audit(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone) RETURNS TABLE(riferimento_id_nome_tab text, ragione_sociale text, linea_attivita text, id_controllo integer, data_inizio_controllo timestamp without time zone, data_fine_controllo timestamp without time zone, stato_controllo text, descrizione_motivo_padre character varying, descrizione_motivo_figlio text, struttura_complessa text, struttura_semplice text, per_conto_di_completo text, oggetto_del_controllo text, descrizione_macrocategoria text, ruolo text, nome text, cognome text)
    LANGUAGE plpgsql
    AS $$

DECLARE

_riferimento_id integer;
_riferimento_id_nome_tab text;

BEGIN

_riferimento_id := (select riferimento_id from  digemon.get_controlli_audit(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket);
_riferimento_id_nome_tab :=  (select riferimento_nome_tab from digemon.get_controlli_audit(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket); 

return query
SELECT DISTINCT 
k.riferimento_id_nome_tab, k.ragione_sociale, 
t.linea_attivita,
c.id_controllo, c.data_inizio_controllo, c.data_fine_controllo, c.stato_controllo,
 m.descrizione_motivo_padre, m.descrizione_motivo_figlio, p.struttura_complessa, p.struttura_semplice, p.per_conto_di_completo, a.oggetto_del_controllo, a.descrizione_macrocategoria, 
n.ruolo, n.cognome, n.nome
from digemon.get_controlli_audit(null, _data_1, _data_2, false)as c
left join digemon.get_controlli_audit_oggetto_del_controllo_2020(_data_1, _data_2) as a on c.id_controllo = a.id_controllo
left join digemon.get_controlli_audit_motivi_2020(_data_1, _data_2) as m on c.id_controllo = m.id_controllo
left join digemon.get_controlli_audit_percontodi_2020(_data_1, _data_2) as p on c.id_controllo = p.id_controllo
left join digemon.get_controlli_nucleoispettivo(_data_1, _data_2) as n on c.id_controllo=n.id_controllo
left join digemon.dbi_get_all_stabilimenti_('1900-01-01 00:00:00', _data_2) as k on c.riferimento_id = k.riferimento_id AND c.riferimento_nome_tab = k.riferimento_id_nome_tab
left join public.get_linee_attivita(_riferimento_id, _riferimento_id_nome_tab, false, _ticket) as t on c.riferimento_id = t.riferimento_id
where c.id_controllo = _ticket;
END 
$$;
 �   DROP FUNCTION dbi_gestione_cu.get_cu_audit(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone);
       dbi_gestione_cu          postgres    false    26            �           1255    418434 \   get_cu_ispezione_semplice(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     \	  CREATE FUNCTION dbi_gestione_cu.get_cu_ispezione_semplice(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone) RETURNS TABLE(riferimento_id_nome_tab text, ragione_sociale text, linea_attivita text, id_controllo integer, data_inizio_controllo timestamp without time zone, data_fine_controllo timestamp without time zone, stato_controllo text, descrizione_motivo_padre character varying, descrizione_motivo_figlio text, oggetto_del_controllo text, descrizione_macrocategoria text, struttura_complessa character varying, struttura_semplice character varying, per_conto_di_completo character varying, ruolo text, nome text, cognome text)
    LANGUAGE plpgsql
    AS $$

DECLARE
_riferimento_id integer;
_riferimento_id_nome_tab text;

BEGIN

_riferimento_id := (select riferimento_id from  digemon.get_controlli_ispezioni_semplici(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket);
_riferimento_id_nome_tab :=  (select riferimento_nome_tab from digemon.get_controlli_ispezioni_semplici(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket); 

return query
SELECT distinct
k.riferimento_id_nome_tab, k.ragione_sociale, t.linea_attivita,
c.id_controllo, c.data_inizio_controllo, c.data_fine_controllo, c.stato_controllo,
m.descrizione_motivo_padre, m.descrizione_motivo_figlio,
o.oggetto_del_controllo, o.descrizione_macrocategoria,
d.struttura_complessa, d.struttura_semplice, d.per_conto_di_completo,
a.ruolo, a.nome, a.cognome
FROM digemon.get_controlli_ispezioni_semplici(null, _data_1, _data_2, false) as c
left join digemon.get_controlli_ispezioni_semplici_motivi(_data_1, _data_2)as m on c.id_controllo=m.id_controllo
left join digemon.get_controlli_ispezioni_semplici_oggetto_del_controllo(_data_1, _data_2) as o on o.id_controllo=c.id_controllo
left join digemon.get_controlli_ispezioni_semplici_percontodi(_data_1, _data_2) as d on c.id_controllo=d.id_controllo
left join digemon.get_controlli_nucleoispettivo(_data_1, _data_2) as a on c.id_controllo=a.id_controllo
left join digemon.dbi_get_all_stabilimenti_('1900-01-01 00:00:00', _data_2) as k on c.riferimento_id = k.riferimento_id AND c.riferimento_nome_tab = k.riferimento_id_nome_tab
left join public.get_linee_attivita(_riferimento_id, _riferimento_id_nome_tab, false, _ticket) as t on c.riferimento_id = t.riferimento_id
where c.id_controllo = _ticket;

END 
$$;
 �   DROP FUNCTION dbi_gestione_cu.get_cu_ispezione_semplice(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone);
       dbi_gestione_cu          postgres    false    26            �           1255    442965 `   get_cu_ispezione_semplice_ext(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     3  CREATE FUNCTION dbi_gestione_cu.get_cu_ispezione_semplice_ext(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone) RETURNS TABLE(riferimento_id_nome_tab text, ragione_sociale text, linea_attivita text, id_controllo integer, data_inizio_controllo timestamp without time zone, data_fine_controllo timestamp without time zone, stato_controllo text, oggetto_del_controllo text, descrizione_macrocategoria text, ruolo text, nome text, cognome text)
    LANGUAGE plpgsql
    AS $$

DECLARE
_riferimento_id integer;
_riferimento_id_nome_tab text;
BEGIN

_riferimento_id := (select riferimento_id from  dbi_gestione_cu.ncp_get_controllo_base(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket);
_riferimento_id_nome_tab :=  (select riferimento_nome_tab from dbi_gestione_cu.ncp_get_controllo_base(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket); 

return query
SELECT distinct
k.riferimento_id_nome_tab, k.ragione_sociale, t.linea_attivita,
c.id_controllo, c.data_inizio_controllo, c.data_fine_controllo, c.stato_controllo,
o.oggetto_del_controllo, o.descrizione_macrocategoria,
a.ruolo, a.nome, a.cognome
FROM digemon.get_controlli_ispezioni_semplici(null, _data_1, _data_2, false) as c
left join digemon.get_controlli_ispezioni_semplici_oggetto_del_controllo(_data_1, _data_2) as o on o.id_controllo=c.id_controllo
left join digemon.get_controlli_nucleoispettivo(_data_1, _data_2) as a on c.id_controllo=a.id_controllo
left join digemon.dbi_get_all_stabilimenti_('1900-01-01 00:00:00', _data_2) as k on c.riferimento_id = k.riferimento_id AND c.riferimento_nome_tab = k.riferimento_id_nome_tab
left join public.get_linee_attivita(_riferimento_id, _riferimento_id_nome_tab, false, _ticket) as t on c.riferimento_id = t.riferimento_id
where c.id_controllo = _ticket;

END 
$$;
 �   DROP FUNCTION dbi_gestione_cu.get_cu_ispezione_semplice_ext(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone);
       dbi_gestione_cu          postgres    false    26            �           1255    418433 Y   get_cu_ispezioni_carni(integer, timestamp without time zone, timestamp without time zone)    FUNCTION     T  CREATE FUNCTION dbi_gestione_cu.get_cu_ispezioni_carni(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone) RETURNS TABLE(riferimento_id_nome_tab text, ragione_sociale text, linea_sottoposta text, id_controllo integer, data_inizio_controllo timestamp without time zone, data_fine_controllo timestamp without time zone, stato_controllo text, struttura_complessa text, struttura_semplice text, per_conto_di_completo text, ruolo text, nome text, cognome text)
    LANGUAGE plpgsql
    AS $$

DECLARE

_riferimento_id integer;
_riferimento_id_nome_tab text;

BEGIN

_riferimento_id := (select riferimento_id from  digemon.get_controlli_ispezioni_carni(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket);
_riferimento_id_nome_tab :=  (select riferimento_nome_tab from digemon.get_controlli_ispezioni_carni(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket); 

return query
SELECT DISTINCT 
k.riferimento_id_nome_tab, k.ragione_sociale, t.linea_attivita,
       c.id_controllo, c.data_inizio_controllo, c.data_fine_controllo, c.stato_controllo,
       a.struttura_complessa, a.struttura_semplice, a.per_conto_di_completo,
       m.ruolo, m.nome, m.cognome
from digemon.get_controlli_ispezioni_carni(null, _data_1, _data_2, false)as c
left join digemon.get_controlli_audit_sorv_percontodi(_data_1, _data_2, 26) as a on c.id_controllo = a.id_controllo
left join digemon.get_controlli_nucleoispettivo(_data_1, _data_2) as m on c.id_controllo=m.id_controllo
left join digemon.dbi_get_all_stabilimenti_('1900-01-01 00:00:00', _data_2) as k on c.riferimento_id = k.riferimento_id AND c.riferimento_nome_tab = k.riferimento_id_nome_tab
left join public.get_linee_attivita(_riferimento_id, _riferimento_id_nome_tab, false, _ticket) as t on c.riferimento_id = t.riferimento_id
where c.id_controllo=  _ticket;

END 
$$;
 �   DROP FUNCTION dbi_gestione_cu.get_cu_ispezioni_carni(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone);
       dbi_gestione_cu          postgres    false    26            �           1255    418430 M   get_cu_ncp(integer, timestamp without time zone, timestamp without time zone)    FUNCTION       CREATE FUNCTION dbi_gestione_cu.get_cu_ncp(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone) RETURNS TABLE(riferimento_id_nome_tab text, ragione_sociale text, linea_attivita text, id_controllo integer, data_inizio_controllo timestamp without time zone, data_fine_controllo timestamp without time zone, stato_controllo text, oggetto_del_controllo text, descrizione_macrocategoria text, struttura_complessa text, struttura_semplice text, per_conto_di_completo text, ruolo text, nome text, cognome text)
    LANGUAGE plpgsql
    AS $$

DECLARE
_riferimento_id integer;
_riferimento_id_nome_tab text;
BEGIN

_riferimento_id := (select riferimento_id from  dbi_gestione_cu.ncp_get_controllo_base(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket);
_riferimento_id_nome_tab :=  (select riferimento_nome_tab from dbi_gestione_cu.ncp_get_controllo_base(null, _data_1, _data_2, false) as c where c.id_controllo = _ticket); 
return query
SELECT distinct
k.riferimento_id_nome_tab, k.ragione_sociale,
t.linea_attivita,
c.id_controllo, c.data_inizio_controllo, c.data_fine_controllo, c.stato_controllo,
o.oggetto_del_controllo, o.descrizione_macrocategoria,
d.struttura_complessa, d.struttura_semplice, d.per_conto_di_completo,
a.ruolo, a.nome, a.cognome
FROM dbi_gestione_cu.ncp_get_controllo_base(null, _data_1, _data_2, false) as c
left join dbi_gestione_cu.ncp_get_oggetto_del_controllo(_data_1, _data_2) as o on o.id_controllo=c.id_controllo
left join digemon.get_controlli_audit_sorv_percontodi(_data_1, _data_2, 2) as d on c.id_controllo = d.id_controllo
left join digemon.get_controlli_nucleoispettivo(_data_1, _data_2) as a on c.id_controllo=a.id_controllo
left join digemon.dbi_get_all_stabilimenti_('1900-01-01 00:00:00', _data_2) as k on c.riferimento_id = k.riferimento_id AND c.riferimento_nome_tab = k.riferimento_id_nome_tab
left join public.get_linee_attivita(_riferimento_id, _riferimento_id_nome_tab, false, _ticket) as t on c.riferimento_id = t.riferimento_id
where c.id_controllo = _ticket;

END 
$$;
 �   DROP FUNCTION dbi_gestione_cu.get_cu_ncp(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone);
       dbi_gestione_cu          postgres    false    26            �           1255    418378 ]   get_cu_sorveglianza_aperta(integer, timestamp without time zone, timestamp without time zone)    FUNCTION       CREATE FUNCTION dbi_gestione_cu.get_cu_sorveglianza_aperta(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone) RETURNS TABLE(riferimento_id_nome_tab text, ragione_sociale text, id_controllo integer, data_inizio_controllo timestamp without time zone, data_fine_controllo timestamp without time zone, stato_controllo text, struttura_complessa text, struttura_semplice text, per_conto_di_completo text, ruolo text, nome text, cognome text)
    LANGUAGE plpgsql
    AS $$

DECLARE

BEGIN
return query
SELECT DISTINCT 
k.riferimento_id_nome_tab, k.ragione_sociale,
       c.id_controllo, c.data_inizio_controllo, c.data_fine_controllo, c.stato_controllo,
       a.struttura_complessa, a.struttura_semplice, a.per_conto_di_completo,
       m.ruolo, m.nome, m.cognome
from digemon.get_controlli_sorveglianze(null, _data_1, _data_2, false)as c
left join digemon.get_controlli_audit_sorv_percontodi(_data_1, _data_2, 5) as a on c.id_controllo = a.id_controllo
left join digemon.get_controlli_nucleoispettivo(_data_1, _data_2) as m on c.id_controllo=m.id_controllo
left join digemon.dbi_get_all_stabilimenti_('1900-01-01 00:00:00', _data_2) as k on c.riferimento_id = k.riferimento_id AND c.riferimento_nome_tab = k.riferimento_id_nome_tab
where c.id_controllo=  _ticket;

END 
$$;
 �   DROP FUNCTION dbi_gestione_cu.get_cu_sorveglianza_aperta(_ticket integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone);
       dbi_gestione_cu          postgres    false    26            �           1255    444396    helper_function(integer)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.helper_function(tecnica integer) RETURNS TABLE(insert text, update text)
    LANGUAGE plpgsql
    AS $$
BEGIN 
if(tecnica = 4)THEN
return query
select h.insert, h.update from dbi_gestione_cu.helper_table as h where h._provvedimenti_prescrittivi= tecnica; 
END IF;
if(tecnica = 3)THEN
return query 
select h.insert, h.update from dbi_gestione_cu.helper_table as h where h._provvedimenti_prescrittivi = tecnica;
END IF;

END 
$$;
 @   DROP FUNCTION dbi_gestione_cu.helper_function(tecnica integer);
       dbi_gestione_cu          postgres    false    26            ~           1255    417930 l   insert_cu_audit(text, date, integer, date, integer, integer, integer, text, text, public.hstore, text, text)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.insert_cu_audit(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _tipoispezione text, _ispezione text, _id_unita_operativa public.hstore, _id_componente text, _id_linea_attivita text) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_ticketid integer;
_entered date;
_modified date;
_status_id integer;
_tipologia integer;
_provvedimenti_prescrittivi integer ;
_id_controllo_ufficiale text; 
_tipo_audit integer;
_bpi integer;
_haccp integer;
_audit_tipo integer;
_oggetto_audit integer;
_enabled boolean;
_id_lookup_condizionalita integer;
 i integer;
 motivo text;
 motivo_p text;
 motivo_k text;
 oggetto text;
 attivita_split text;
 nucleo text;
 validatore_percontodi boolean;
 validatore_linea boolean;
 msg1 text;
 tipo_stabilimento text;
 _codice_linea text; 
 chiavi_hstore text ARRAY;
BEGIN

 msg := '';
_entered:= now();
_modified:= now();
_status_id := 1;
_tipologia := 3;
_provvedimenti_prescrittivi := 3;
_tipo_audit := -1;
_bpi := -1;
_haccp := -1;
_audit_tipo := -1;
_oggetto_audit := -1;
_enabled := true;
_id_lookup_condizionalita := -1;
tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);
chiavi_hstore := (akeys(_id_unita_operativa));
if(_problem is null)THEN 
_problem := '';
END IF;
--Eseguo il controllo di tutti i campi del cu tranne del per conto di e della linea i quali controlli vengono chiamati ciclicamente
msg := (select * from dbi_gestione_cu.verifica_campi_cu_insert(_assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _enteredby, _modifiedby, _tipoispezione, null::text, _ispezione, _entered, _id_componente, _id_linea_attivita, _provvedimenti_prescrittivi, tipo_stabilimento, chiavi_hstore));

-- se tutti i controlli sono andati a buon fine, posso procedere a inserire il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then
			-- genero id cu
			_ticketid := (select max(ticketid)+1 from ticket where ticketid < 10000000);

			_id_controllo_ufficiale = _ticketid;

			insert into ticket(problem, ticketid, entered, enteredby, modified, modifiedby, assigned_date, status_id, site_id, tipologia, provvedimenti_prescrittivi, id_controllo_ufficiale, data_fine_controllo, id_stabilimento)
			VALUES(_problem, _ticketid, _entered, _enteredby, _modified, _modifiedby, _assigned_date, _status_id, _site_id, _tipologia, _provvedimenti_prescrittivi, _id_controllo_ufficiale, _data_fine_controllo,  _id_stabilimento);

			-- aggiorno il riferimento all'anagrafica se necessario
			if(tipo_stabilimento = 'organization')THEN
					update  ticket
					set id_stabilimento = 0, org_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'sintesis_stabilimento')THEN
					update ticket
					set id_stabilimento = 0, alt_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'apicoltura_imprese')THEN
					update ticket
					set id_stabilimento = 0, id_apiario = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			-- aggiungo i motivi
			i := 1; 
			motivo := (select split_part(_tipoispezione, '-', i));
			motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
			motivo_k := (select split_part(_id_unita_operativa -> 'ispezione', '-', i));
			while(motivo is not null AND motivo <> '') LOOP 
				i := i+ 1;	
				if(motivo = motivo_k)THEN
					motivo_k := (select split_part(motivo_p, '-', 2));
					validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo_k, _assigned_date, _site_id));
					if(validatore_percontodi = false)THEN 
						msg := ' KO PER CONTO DI NON VALIDO ';
						msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
						return concat(msg, msg1);
					END IF;
					insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
						VALUES(_ticketid, _tipo_audit, _bpi, _haccp, cast(motivo as integer), -1, -1, _audit_tipo, cast(motivo_k as integer), _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);
				ELSE 
					msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
					msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
					return concat(msg, msg1);
				END IF;
				motivo := (select split_part(_tipoispezione, '-', i));
				motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
				motivo_k := (select split_part(motivo_p, '-', 1));
				if(motivo <> motivo_k)THEN
					msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
					msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
					return concat(msg, msg1);
				END IF;
			END LOOP;

			-- aggiungo gli oggetti dell'audit
			i := 1;
			oggetto := (select split_part(_ispezione, '-', i));
			while(oggetto is not null AND oggetto <> '') LOOP
				i := i+1;
				insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
				VALUES(_ticketid, _tipo_audit, _bpi, _haccp, -1, -1, cast(oggetto as integer), _audit_tipo, -1, _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);

				oggetto := (select split_part(_ispezione, '-', i));
			END LOOP;

			--Inserimento del nucleo ispettivo
			i := 1;
			nucleo := (select split_part(_id_componente, '-', i));
			while(nucleo is not null AND nucleo <> '') LOOP
				i:= i + 1; 
				insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
				VALUES(_ticketid, cast(nucleo as integer), _enabled);
				nucleo := (select split_part(_id_componente, '-', i));
			END LOOP;

			--Inserimento delle linee attivita che possono essere multiple
			i :=1;
			attivita_split := (select split_part(_id_linea_attivita, '-', i));
			if(attivita_split = '')THEN 
				return false;
			END IF;
			while(attivita_split is not null AND attivita_split <> '') LOOP
				i := i+1;
				validatore_linea := (select * from dbi_gestione_cu.linea_attivita_is_valid(cast(attivita_split as integer), tipo_stabilimento, _id_stabilimento));
				if(validatore_linea = true)THEN
					_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = cast(attivita_split as integer));
					insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, riferimento_nome_tab, entered, entered_by, codice_linea)
						VALUES(_ticketid , cast(attivita_split as integer), cast(tipo_stabilimento as character varying), _entered, _enteredby, _codice_linea);
				ELSE 
					msg := 'KO LINEA ATTIVITA SOTTOPOSTA A CONTROLLO ';
					msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
					return concat(msg, msg1);
				END IF;
				attivita_split := (select split_part(_id_linea_attivita, '-', i));
			END LOOP;

	msg := concat('ok: ', _ticketid);
END IF;

RETURN msg;

END 
$$;
 :  DROP FUNCTION dbi_gestione_cu.insert_cu_audit(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _tipoispezione text, _ispezione text, _id_unita_operativa public.hstore, _id_componente text, _id_linea_attivita text);
       dbi_gestione_cu          postgres    false    26            �           1255    418302 �   insert_cu_ispezione_semplice(text, date, integer, date, integer, integer, integer, text, text, text, public.hstore, text, integer)    FUNCTION     W#  CREATE FUNCTION dbi_gestione_cu.insert_cu_ispezione_semplice(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _tipoispezione text, _pianomonitoraggio text, _ispezione text, _id_unita_operativa public.hstore, _id_componente text, _id_linea_attivita integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_ticketid integer;
_entered date ;
_modified date;
_status_id integer;
_tipologia integer;
_provvedimenti_prescrittivi integer ;
_id_controllo_ufficiale text; 
_tipo_audit integer;
_bpi integer;
_haccp integer;
_audit_tipo integer;
_oggetto_audit integer;
_enabled boolean;
_id_lookup_condizionalita integer;
 i integer;
 motivo text;
 motivo_p text;
 motivo_k text;
 nucleo text;
 oggetto text;
 validatore_percontodi boolean;
 tipo_stabilimento text;
 msg1 text;
 _codice_linea text;
 chiavi_hstore text ARRAY;

 
 
 

BEGIN

msg ='';
_entered:= now();
_modified:= now();
_status_id := 1; --Indica il controllo aperto
_tipologia := 3;
_provvedimenti_prescrittivi := 4; --Indica il tipo di controllo ufficiale
_tipo_audit := -1;
_bpi := -1;
_haccp := -1;
_audit_tipo := -1;
_oggetto_audit := -1;
_enabled := true;
_id_lookup_condizionalita := -1;
tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);
chiavi_hstore := (akeys(_id_unita_operativa));

if(_problem is null)THEN
	_problem = '';
END IF;

--Eseguo il controllo di tutti i campi del cu tranne del per conto di poiche il controllo viene chiamato ciclicamente 
msg := (select * from dbi_gestione_cu.verifica_campi_cu_insert(_assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _enteredby, _modifiedby, _tipoispezione, _pianomonitoraggio, _ispezione, _entered, _id_componente, cast(_id_linea_attivita as text), _provvedimenti_prescrittivi, tipo_stabilimento, chiavi_hstore));

-- se tutti i controlli sono andati a buon fine, posso procedere a inserire il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then
			-- genero id cu
			_ticketid := (select max(ticketid)+1 from ticket where ticketid < 10000000);
			raise info '%s', _ticketid;

			_id_controllo_ufficiale = _ticketid;
	
			insert into ticket(problem, ticketid, entered, enteredby, modified, modifiedby, assigned_date, status_id, site_id, tipologia, provvedimenti_prescrittivi, id_controllo_ufficiale, data_fine_controllo, id_stabilimento)
			VALUES(_problem, _ticketid, _entered, _enteredby, _modified, _modifiedby, _assigned_date, _status_id, _site_id, _tipologia, _provvedimenti_prescrittivi, _id_controllo_ufficiale, _data_fine_controllo,  _id_stabilimento);

			-- aggiorno il riferimento all'anagrafica se necessario
			if(tipo_stabilimento = 'organization')THEN
					update  ticket
					set id_stabilimento = 0, org_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'sintesis_stabilimento')THEN
					update ticket
					set id_stabilimento = 0, alt_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'apicoltura_imprese')THEN
					update ticket
					set id_stabilimento = 0, id_apiario = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

--Casistica in cui tipoispezione sia popolato, per inserire uno o piu motivi al nostro controllo ufficiale

	i := 1; 
	motivo := (select split_part(_tipoispezione, '-', i));
	motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
	motivo_k := (select split_part(_id_unita_operativa -> 'ispezione', '-', i));
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		if(motivo = motivo_k)THEN
			motivo_k := (select split_part(motivo_p, '-', 2));
			if(motivo_p <> '' AND motivo_k = '')THEN 
				msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
				msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
				return concat(msg, msg1);
			END IF;
			validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo_k, _assigned_date, _site_id));
			if(validatore_percontodi = false)THEN 
				msg := ' KO PER CONTO DI NON VALIDO ';
				msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
				return concat(msg, msg1);
			END IF;
			insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
			VALUES(_ticketid, _tipo_audit, _bpi, _haccp, cast(motivo as integer), -1, -1, _audit_tipo, cast(motivo_k as integer), _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);
		ELSE
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;
		motivo := (select split_part(_tipoispezione, '-', i));
		motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
		motivo_k := (select split_part(motivo_p, '-', 1));
		if(motivo <> motivo_k)THEN
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;
	END LOOP;

--Casistica in cui pianomonitoraggio sia popolato, per inserire uno o piu motivi al nostro controllo ufficial
	i := 1; 
	motivo := (select split_part(_pianomonitoraggio, '-', i));
	motivo_p := (select split_part(_id_unita_operativa -> 'piano', '/', i));
	motivo_k := (select split_part(_id_unita_operativa -> 'piano', '-', i));
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		if(motivo = motivo_k)THEN
			motivo_k := (select split_part(motivo_p, '-', 2));
			if(motivo_p <> '' AND motivo_k = '')THEN 
				msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
				msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
				return concat(msg, msg1);
			END IF;
			validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo_k, _assigned_date, _site_id));
			if(validatore_percontodi = false)THEN 
				msg := ' KO PER CONTO DI NON VALIDO ';
				msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
				return concat(msg, msg1);
			END IF;
			insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
			VALUES(_ticketid, _tipo_audit, _bpi, _haccp, 89, cast(motivo as integer), -1, _audit_tipo, cast(motivo_k as integer), _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);
		ELSE 
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;
		motivo := (select split_part(_pianomonitoraggio, '-', i));
		motivo_p := (select split_part(_id_unita_operativa -> 'piano', '/', i));
		motivo_k := (select split_part(motivo_p, '-', 1));
		if(motivo <> motivo_k)THEN
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;
	END LOOP;

--Inserimento di uno o piu oggetti sottoposti al controllo
	i := 1;
	oggetto := (select split_part(_ispezione, '-', i));
	while(oggetto is not null AND oggetto <> '') LOOP
		i := i+1;
		insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
		VALUES(_ticketid, _tipo_audit, _bpi, _haccp, -1, -1, cast(oggetto as integer), _audit_tipo, -1, _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);
		oggetto := (select split_part(_ispezione, '-', i));
	END LOOP;

--Inserimento del nucleo ispettivo
i := 1;
nucleo := (select split_part(_id_componente, '-', i));
while(nucleo is not null AND nucleo <> '') LOOP
	i:= i + 1; 
	insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
	VALUES(_ticketid, cast(nucleo as integer), _enabled);
	nucleo := (select split_part(_id_componente, '-', i));
END LOOP;

--Inserimento linea attivita

	_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = _id_linea_attivita);
	insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, riferimento_nome_tab, entered, entered_by, codice_linea)
		VALUES(_ticketid , _id_linea_attivita, cast(tipo_stabilimento as character varying), _entered, _enteredby, _codice_linea);
msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
 c  DROP FUNCTION dbi_gestione_cu.insert_cu_ispezione_semplice(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _tipoispezione text, _pianomonitoraggio text, _ispezione text, _id_unita_operativa public.hstore, _id_componente text, _id_linea_attivita integer);
       dbi_gestione_cu          postgres    false    26            �           1255    418367 k   insert_cu_ispezione_semplice_ext(text, date, integer, date, integer, integer, integer, text, text, integer)    FUNCTION     _  CREATE FUNCTION dbi_gestione_cu.insert_cu_ispezione_semplice_ext(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _ispezione text, _id_componente text, _id_linea_attivita integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_ticketid integer;
_entered date;
_modified date;
_status_id integer;
_tipologia integer;
_provvedimenti_prescrittivi integer ;
_id_controllo_ufficiale text; 
 i integer;
 motivo text;
 nucleo text;
 oggetto text;
_tipo_audit integer;
_bpi integer;
_haccp integer;
_audit_tipo integer;
_oggetto_audit integer;
_enabled boolean;
_id_lookup_condizionalita integer;
 tipo_stabilimento text;
 msg1 text;
 _codice_linea text;

 
BEGIN

msg := '';
_entered:= now();
_modified:= now();
_status_id := 1;
_tipologia := 3;
_provvedimenti_prescrittivi := 4;
_enabled := true;
_tipo_audit := -1;
_bpi := -1;
_haccp := -1;
_audit_tipo := -1;
_oggetto_audit := -1;
_id_lookup_condizionalita := -1;

tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);

if(_problem is null)THEN
	_problem := '';
END IF;
--Eseguo il controllo di tutti i campi del cu
msg := (select * from dbi_gestione_cu.verifica_campi_cu_insert(_assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _enteredby, _modifiedby, null::text, null::text, _ispezione, _entered, _id_componente, cast(_id_linea_attivita as text), 1, tipo_stabilimento, null::text[]));

-- se tutti i controlli sono andati a buon fine, posso procedere a inserire il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then
			-- genero id cu
			_ticketid := (select max(ticketid)+1 from ticket where ticketid > 10000000);
			raise info '%s', _ticketid;

			_id_controllo_ufficiale = _ticketid;
	
			insert into ticket(problem, ticketid, entered, enteredby, modified, modifiedby, assigned_date, status_id, site_id, tipologia, provvedimenti_prescrittivi, id_controllo_ufficiale, data_fine_controllo, id_stabilimento)
			VALUES(_problem, _ticketid, _entered, _enteredby, _modified, _modifiedby, _assigned_date, _status_id, _site_id, _tipologia, _provvedimenti_prescrittivi, _id_controllo_ufficiale, _data_fine_controllo,  _id_stabilimento);

			-- aggiorno il riferimento all'anagrafica se necessario
			if(tipo_stabilimento = 'organization')THEN
					update  ticket
					set id_stabilimento = 0, org_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'sintesis_stabilimento')THEN
					update ticket
					set id_stabilimento = 0, alt_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'apicoltura_imprese')THEN
					update ticket
					set id_stabilimento = 0, id_apiario = _id_stabilimento
					where ticketid = _ticketid;
			END IF;
--Inserimento di uno o piu oggetti sottoposti al controllo
	i := 1;
	oggetto := (select split_part(_ispezione, '-', i));
	while(oggetto is not null AND oggetto <> '') LOOP
		i := i+1;
		insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
		VALUES(_ticketid, _tipo_audit, _bpi, _haccp, -1, -1, cast(oggetto as integer), _audit_tipo, -1, _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);
		oggetto := (select split_part(_ispezione, '-', i));
	END LOOP;

--Inserimento del nucleo ispettivo
i := 1;
nucleo := (select split_part(_id_componente, '-', i));
while(nucleo is not null AND nucleo <> '') LOOP
	i:= i + 1; 
	insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
	VALUES(_ticketid, cast(nucleo as integer), _enabled);
	nucleo := (select split_part(_id_componente, '-', i));
END LOOP;

--Inserimento linea attivita

	_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = _id_linea_attivita);
	insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, riferimento_nome_tab, entered, entered_by, codice_linea)
		VALUES(_ticketid , _id_linea_attivita, cast(tipo_stabilimento as character varying), _entered, _enteredby, _codice_linea);

msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
   DROP FUNCTION dbi_gestione_cu.insert_cu_ispezione_semplice_ext(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _ispezione text, _id_componente text, _id_linea_attivita integer);
       dbi_gestione_cu          postgres    false    26            �           1255    418409 d   insert_cu_ispezioni_carni(text, date, integer, date, integer, integer, integer, text, text, integer)    FUNCTION     !  CREATE FUNCTION dbi_gestione_cu.insert_cu_ispezioni_carni(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _id_unita_operativa text, _id_componente text, _id_linea_attivita integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_ticketid integer;
_entered date;
_modified date;
_status_id integer;
_tipologia integer;
_provvedimenti_prescrittivi integer ;
_id_controllo_ufficiale text; 
 i integer;
 motivo text;
 nucleo text;
 _enabled boolean;
 validatore_percontodi boolean;
 tipo_stabilimento text;
 msg1 text;
 _codice_linea text;

 
BEGIN

msg = '';
_entered:= now();
_modified:= now();
_status_id := 1;
_tipologia := 3;
_provvedimenti_prescrittivi := 26;
_enabled := true;

tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);

if(_problem is null)THEN
	_problem := '';
END IF; 

--Eseguo il controllo di tutti i campi del cu tranne del per conto di che viene eseguito ciclicamente in seguito
msg := (select * from dbi_gestione_cu.verifica_campi_cu_insert(_assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _enteredby, _modifiedby, _id_unita_operativa, null::text, null::text, _entered, _id_componente, cast(_id_linea_attivita as text), _provvedimenti_prescrittivi, tipo_stabilimento, null::text[]));

raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then
			-- genero id cu
			_ticketid := (select max(ticketid)+1 from ticket where ticketid < 10000000);

			_id_controllo_ufficiale = _ticketid;

			insert into ticket(problem, ticketid, entered, enteredby, modified, modifiedby, assigned_date, status_id, site_id, tipologia, provvedimenti_prescrittivi, id_controllo_ufficiale, data_fine_controllo, id_stabilimento)
			VALUES(_problem, _ticketid, _entered, _enteredby, _modified, _modifiedby, _assigned_date, _status_id, _site_id, _tipologia, _provvedimenti_prescrittivi, _id_controllo_ufficiale, _data_fine_controllo,  _id_stabilimento);

			-- aggiorno il riferimento all'anagrafica se necessario
			if(tipo_stabilimento = 'organization')THEN
					update  ticket
					set id_stabilimento = 0, org_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'sintesis_stabilimento')THEN
					update ticket
					set id_stabilimento = 0, alt_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'apicoltura_imprese')THEN
					update ticket
					set id_stabilimento = 0, id_apiario = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

--Inserimento per conto di 
	i := 1;
	motivo := (select split_part(_id_unita_operativa, '-', i));
	if(motivo = '')THEN
		msg := ' KO PER CONTO DI NON VALIDO ';
		msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
		return concat(msg, msg1);
	END IF;
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo, _assigned_date, _site_id));
		if(validatore_percontodi = false)THEN 
			msg := ' KO PER CONTO DI NON VALIDO ';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;
		insert into unita_operative_controllo(id_controllo, id_unita_operativa)
		VALUES (_ticketid, cast(motivo as integer));
		motivo := (select split_part(_id_unita_operativa, '-', i));
	END LOOP;

--Inserimento del nucleo ispettivo
	i := 1;
	nucleo := (select split_part(_id_componente, '-', i));
	while(nucleo is not null AND nucleo <> '') LOOP
		i:= i + 1; 
		insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
		VALUES(_ticketid, cast(nucleo as integer), _enabled);
		nucleo := (select split_part(_id_componente, '-', i));
	END LOOP;
	
	--Inserimento linea attivita

	_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = _id_linea_attivita);
	insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, riferimento_nome_tab, entered, entered_by, codice_linea)
		VALUES(_ticketid , _id_linea_attivita, cast(tipo_stabilimento as character varying), _entered, _enteredby, _codice_linea);

msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
   DROP FUNCTION dbi_gestione_cu.insert_cu_ispezioni_carni(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _id_unita_operativa text, _id_componente text, _id_linea_attivita integer);
       dbi_gestione_cu          postgres    false    26            �           1255    418421 ^   insert_cu_ncp(text, date, integer, date, integer, integer, integer, text, text, text, integer)    FUNCTION     y  CREATE FUNCTION dbi_gestione_cu.insert_cu_ncp(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _ispezione text, _id_unita_operativa text, _id_componente text, _id_linea_attivita integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_ticketid integer;
_entered date ;
_modified date;
_status_id integer;
_tipologia integer;
_provvedimenti_prescrittivi integer ;
_id_controllo_ufficiale text; 
_tipo_audit integer;
_bpi integer;
_haccp integer;
_audit_tipo integer;
_oggetto_audit integer;
_enabled boolean;
_id_lookup_condizionalita integer;
 i integer;
 motivo text;
 motivo_p text;
 motivo_k text;
 nucleo text;
 oggetto text;
 tipo_stabilimento text;
 msg1 text;
 validatore_percontodi boolean;
 _codice_linea text;
 

BEGIN

msg ='';
_entered:= now();
_modified:= now();
_status_id := 1; --Indica il controllo aperto
_tipologia := 3;
_provvedimenti_prescrittivi := 2; --Indica il tipo di controllo ufficiale
_tipo_audit := -1;
_bpi := -1;
_haccp := -1;
_audit_tipo := -1;
_oggetto_audit := -1;
_enabled := true;
_id_lookup_condizionalita := -1;
tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);

if(_problem is null)THEN
	_problem := '';
END IF;

--Eseguo il controllo di tutti i campi del cu tranne del per conto di che viene eseguito ciclicamente in seguito
msg := (select * from dbi_gestione_cu.verifica_campi_cu_insert(_assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _enteredby, _modifiedby, _id_unita_operativa, null::text, _ispezione, _entered, _id_componente, cast(_id_linea_attivita as text), _provvedimenti_prescrittivi, tipo_stabilimento, null::text[]));

-- se tutti i controlli sono andati a buon fine, posso procedere a inserire il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then
			-- genero id cu
			_ticketid := (select max(ticketid)+1 from ticket where ticketid < 10000000);
			raise info '%s', _ticketid;

			_id_controllo_ufficiale = _ticketid;
	
			insert into ticket(problem, ticketid, entered, enteredby, modified, modifiedby, assigned_date, status_id, site_id, tipologia, provvedimenti_prescrittivi, id_controllo_ufficiale, data_fine_controllo, id_stabilimento)
			VALUES(_problem, _ticketid, _entered, _enteredby, _modified, _modifiedby, _assigned_date, _status_id, _site_id, _tipologia, _provvedimenti_prescrittivi, _id_controllo_ufficiale, _data_fine_controllo,  _id_stabilimento);

			-- aggiorno il riferimento all'anagrafica se necessario
			if(tipo_stabilimento = 'organization')THEN
					update  ticket
					set id_stabilimento = 0, org_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'sintesis_stabilimento')THEN
					update ticket
					set id_stabilimento = 0, alt_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'apicoltura_imprese')THEN
					update ticket
					set id_stabilimento = 0, id_apiario = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

--Inserimento oggetto del controllo
	i := 1;
	oggetto := (select split_part(_ispezione, '-', i));
	while(oggetto is not null AND oggetto <> '') LOOP
		i := i+1;
		insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
		VALUES(_ticketid, _tipo_audit, _bpi, _haccp, -1, -1, cast(oggetto as integer), _audit_tipo, -1, _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);
		oggetto := (select split_part(_ispezione, '-', i));
	END LOOP;
	
--Inserimento per conto di 
	i := 1;
	motivo := (select split_part(_id_unita_operativa, '-', i));
	if(motivo = '')THEN
		msg := ' KO PER CONTO DI NON VALIDO ';
		msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
		return concat(msg, msg1);
	END IF;
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo, _assigned_date, _site_id));
		if(validatore_percontodi = false)THEN 
			msg := ' KO PER CONTO DI NON VALIDO ';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;
		insert into unita_operative_controllo(id_controllo, id_unita_operativa)
		VALUES (_ticketid, cast(motivo as integer));
		motivo := (select split_part(_id_unita_operativa, '-', i));
	END LOOP;

--Inserimento del nucleo ispettivo
i := 1;
nucleo := (select split_part(_id_componente, '-', i));
while(nucleo is not null AND nucleo <> '') LOOP
	i:= i + 1; 
	insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
	VALUES(_ticketid, cast(nucleo as integer), _enabled);
	nucleo := (select split_part(_id_componente, '-', i));
END LOOP;

--Inserimento linea attivita

	_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = _id_linea_attivita);
	insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, riferimento_nome_tab, entered, entered_by, codice_linea)
		VALUES(_ticketid , _id_linea_attivita, cast(tipo_stabilimento as character varying), _entered, _enteredby, _codice_linea);

msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
   DROP FUNCTION dbi_gestione_cu.insert_cu_ncp(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _ispezione text, _id_unita_operativa text, _id_componente text, _id_linea_attivita integer);
       dbi_gestione_cu          postgres    false    26            �           1255    418104 _   insert_cu_sorveglianza_aperta(text, date, integer, date, integer, integer, integer, text, text)    FUNCTION     0  CREATE FUNCTION dbi_gestione_cu.insert_cu_sorveglianza_aperta(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _id_unita_operativa text, _id_componente text) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_ticketid integer;
_entered date;
_modified date ;
_status_id integer;
_tipologia integer;
_provvedimenti_prescrittivi integer ;
_id_controllo_ufficiale text; 
 i integer;
 motivo text;
 nucleo text;
 _enabled boolean; 
 validatore_percontodi boolean;
 tipo_stabilimento text;
 msg1 text;  
 
BEGIN

msg = '';
_entered:= now();
_modified:= now();
_status_id := 1; --Indica che il controllo è aperto
_tipologia := 3;
_provvedimenti_prescrittivi := 5; --Indica il tipo di controllo ufficiale
_enabled := true;
tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);

if(_problem is null)THEN
	_problem := '';
END IF; 
--Eseguo il controllo di tutti i campi del cu tranne del per conto di 
msg := (select * from dbi_gestione_cu.verifica_campi_cu_insert(_assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _enteredby, _modifiedby, _id_unita_operativa, null::text, null::text, _entered, _id_componente, null::text, _provvedimenti_prescrittivi, null::text, null::text[]));

raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then
			-- genero id cu
			_ticketid := (select max(ticketid)+1 from ticket where ticketid < 10000000);

			_id_controllo_ufficiale = _ticketid;

			insert into ticket(problem, ticketid, entered, enteredby, modified, modifiedby, assigned_date, status_id, site_id, tipologia, provvedimenti_prescrittivi, id_controllo_ufficiale, data_fine_controllo, id_stabilimento)
			VALUES(_problem, _ticketid, _entered, _enteredby, _modified, _modifiedby, _assigned_date, _status_id, _site_id, _tipologia, _provvedimenti_prescrittivi, _id_controllo_ufficiale, _data_fine_controllo,  _id_stabilimento);

			-- aggiorno il riferimento all'anagrafica se necessario
			if(tipo_stabilimento = 'organization')THEN
					update  ticket
					set id_stabilimento = 0, org_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'sintesis_stabilimento')THEN
					update ticket
					set id_stabilimento = 0, alt_id = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

			if(tipo_stabilimento = 'apicoltura_imprese')THEN
					update ticket
					set id_stabilimento = 0, id_apiario = _id_stabilimento
					where ticketid = _ticketid;
			END IF;

--Inserimento per conto di 
	i := 1;
	motivo := (select split_part(_id_unita_operativa, '-', i));
	if(motivo = '')THEN
		msg := ' KO PER CONTO DI NON VALIDO ';
		msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
		return concat(msg, msg1);
	END IF;
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo, _assigned_date, _site_id));
		if(validatore_percontodi = false)THEN 
			msg := ' KO PER CONTO DI NON VALIDO ';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;
		insert into unita_operative_controllo(id_controllo, id_unita_operativa)
		VALUES (_ticketid, cast(motivo as integer));
		motivo := (select split_part(_id_unita_operativa, '-', i));
	END LOOP;

--Inserimento del nucleo ispettivo
	i := 1;
	nucleo := (select split_part(_id_componente, '-', i));
	while(nucleo is not null AND nucleo <> '') LOOP
		i:= i + 1; 
		insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
		VALUES(_ticketid, cast(nucleo as integer), _enabled);
		nucleo := (select split_part(_id_componente, '-', i));
	END LOOP;

msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
    DROP FUNCTION dbi_gestione_cu.insert_cu_sorveglianza_aperta(_problem text, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _id_unita_operativa text, _id_componente text);
       dbi_gestione_cu          postgres    false    26            {           1255    417920    integer_null(integer)    FUNCTION     �   CREATE FUNCTION dbi_gestione_cu.integer_null(valore integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

 BEGIN

raise info '%s', valore;
	if(valore is not null AND valore > 0)THEN 
		return true;
	END IF;

return false;
END
$$;
 <   DROP FUNCTION dbi_gestione_cu.integer_null(valore integer);
       dbi_gestione_cu          postgres    false    26            z           1255    417857 /   linea_attivita_is_valid(integer, text, integer)    FUNCTION        CREATE FUNCTION dbi_gestione_cu.linea_attivita_is_valid(_id_linea_attivita integer, _riferimento_id_nome_tab text, _riferimento_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE 
 validatore integer;
 attivita_sottoposta text;
 i integer;
 
 BEGIN

 validatore := (select count(id) from public.get_linee_attivita(_riferimento_id, _riferimento_id_nome_tab, false, -1) where id = _id_linea_attivita AND trashed_date is null);
 if(validatore>0)THEN
 	return true;
 END IF;
 
return false;
END
$$;
 �   DROP FUNCTION dbi_gestione_cu.linea_attivita_is_valid(_id_linea_attivita integer, _riferimento_id_nome_tab text, _riferimento_id integer);
       dbi_gestione_cu          postgres    false    26            v           1255    417679 !   match_asl_valid(integer, integer)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.match_asl_valid(_riferimento_id integer, _site_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE 
	asl_stabilimento integer;
	struttura integer;
BEGIN

asl_stabilimento := (select asl_rif from ricerche_anagrafiche_old_materializzata where riferimento_id = _riferimento_id LIMIT 1);
if(asl_stabilimento = _site_id)THEN 
	return true;
END IF; 
return false; 

END
$$;
 Z   DROP FUNCTION dbi_gestione_cu.match_asl_valid(_riferimento_id integer, _site_id integer);
       dbi_gestione_cu          postgres    false    26            w           1255    417683 !   motivo_audit_is_valid(text, date)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.motivo_audit_is_valid(_motivo_audit text, _data_inizio date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE
validatore integer;
anno_del_controllo integer;
motivo text;
i integer;

BEGIN

anno_del_controllo := (select split_part(cast(_data_inizio as text), '-', 1));
i := 1;
motivo := (select split_part(_motivo_audit, '-', i));
if(motivo = '')THEN	
	return false;
END IF;
while(motivo <> '')LOOP
	validatore := (select count (f.code) from dpat_piano_attivita_new as d
		left join dpat_indicatore_new as c on d.id = c.id_piano_attivita 
		left join lookup_tipo_ispezione as f on c.id = f.code
		where d.tipo_attivita= 'ATTIVITA-AUDIT'AND f.anno = cast(anno_del_controllo as integer) AND f.enabled = true AND f.code = cast(motivo as integer));
	if(validatore<1)THEN 
		return false; 
	END IF; 
	i := i+1;
	motivo := (select split_part(_motivo_audit, '-', i));

END LOOP;	
return true; 

END
$$;
 \   DROP FUNCTION dbi_gestione_cu.motivo_audit_is_valid(_motivo_audit text, _data_inizio date);
       dbi_gestione_cu          postgres    false    26            x           1255    417687    motivo_is_valid(text, date)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.motivo_is_valid(_motivo_ispezione text, _data_inizio date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE
validatore integer;
anno_del_controllo integer;
motivo text;
i integer;

BEGIN

anno_del_controllo := (select split_part(cast(_data_inizio as text), '-', 1));
i := 1;
motivo := (select split_part(_motivo_ispezione, '-', i));
if(motivo = '')THEN
	return false;
END IF;

while(motivo <> '')LOOP
	validatore := (select count (code) from lookup_tipo_ispezione where anno = cast(anno_del_controllo as integer) AND enabled = true AND code = cast(motivo as integer));
	if(validatore<1)THEN 
		return false; 
	END IF; 
	i := i+1; 
	motivo := (select split_part(_motivo_ispezione, '-', i));

END LOOP;	
return true; 

END
$$;
 Z   DROP FUNCTION dbi_gestione_cu.motivo_is_valid(_motivo_ispezione text, _data_inizio date);
       dbi_gestione_cu          postgres    false    26            �           1255    418417 b   ncp_get_controllo_base(integer, timestamp without time zone, timestamp without time zone, boolean)    FUNCTION     	  CREATE FUNCTION dbi_gestione_cu.ncp_get_controllo_base(_asl integer DEFAULT NULL::integer, _data_1 timestamp without time zone DEFAULT '1900-01-01 00:00:00'::timestamp without time zone, _data_2 timestamp without time zone DEFAULT NULL::timestamp without time zone, _solo_chiusi boolean DEFAULT true) RETURNS TABLE(id_controllo integer, data_inserimento timestamp without time zone, data_inizio_controllo timestamp without time zone, data_chiusura_controllo timestamp without time zone, data_fine_controllo timestamp without time zone, id_stato_controllo integer, stato_controllo text, id_asl integer, asl character varying, riferimento_id integer, riferimento_nome_tab text, congruo_supervisione text, supervisionato_in_data timestamp without time zone, supervisionato_da integer, supervisione_note text, note text, id_tecnica_cu integer, targa_matricola text, punteggio integer, utente_inserimento text)
    LANGUAGE plpgsql
    AS $$

DECLARE

BEGIN

FOR  	id_controllo, 
	data_inserimento, 
	Data_Inizio_Controllo ,
	Data_Chiusura_Controllo,
	data_fine_controllo,
	id_stato_controllo,
	stato_controllo,
	id_asl,
	asl,
	riferimento_id,
	riferimento_nome_tab,
	congruo_supervisione,
	supervisionato_in_data, 
	supervisionato_da,
	supervisione_note, 
	note,
	id_tecnica_cu,
	targa_matricola,
	punteggio,
	utente_inserimento
in
        select t.ticketid as id_controllo,
	t.entered as data_inserimento,
	t.assigned_date as Data_Inizio_Controllo,
	t.closed as Data_Chiusura_Controllo,
	t.data_fine_controllo,
	t.status_id as id_stato_controllo,
	case when t.status_id = 1 then 'aperto'
          when t.status_id = 2 then 'chiuso'
          when t.status_id = 3 then 'riaperto'
	end as stato_controllo,
	l.code as id_asl_cu,
	l.description as asl_cu,
	case when t.alt_id > 0 then t.alt_id  
        when t.id_stabilimento > 0 then t.id_stabilimento  
        when t.id_apiario > 0 then t.id_apiario 
        when t.org_id > 0 then t.org_id end as riferimento_id,
       case when t.alt_id > 0 then (select return_nome_tabella from gestione_id_alternativo(t.alt_id,-1)) 
       when t.id_stabilimento > 0 then 'opu_stabilimento'  
       when t.id_apiario > 0 then 'apicoltura_imprese'
       when t.org_id > 0 then 'organization' end as riferimento_nome_tab,
	 CASE
                    WHEN t.supervisione_flag_congruo THEN 'SI'::text
                    WHEN t.supervisione_flag_congruo = false THEN 'NO'::text
                    ELSE 'N.D.'::text
                END AS congruo_supervisione,
        t.supervisionato_in_data, 
	t.supervisionato_da,
	t.supervisione_note, 
	t.problem as note,
	t.provvedimenti_prescrittivi,     
	lf.valore_campo as targa_matricola,
	t.punteggio,
	upper(concat_ws(' ',c.namefirst, c.namelast)) as utente_inserimento
from ticket t
left join access_ ac on ac.user_id = t.enteredby 
left join contact_ c on c.contact_id = ac.contact_id
left join lookup_site_id l on l.code  = t.site_id
left join linee_mobili_fields_value lf on lf.id = t.id_targa
where provvedimenti_prescrittivi = 2 and tipologia = 3 and t.trashed_date is null 
 and ( _asl is null or t.site_id = _asl )
 and t.assigned_date  between coalesce (_data_1,'1900-01-01') and coalesce (_data_2,now())
 and ( /*_solo_chiusi */ _solo_chiusi is false or t.closed is not null)
    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
  
 END;
$$;
 �   DROP FUNCTION dbi_gestione_cu.ncp_get_controllo_base(_asl integer, _data_1 timestamp without time zone, _data_2 timestamp without time zone, _solo_chiusi boolean);
       dbi_gestione_cu          postgres    false    26            �           1255    418418 W   ncp_get_oggetto_del_controllo(timestamp without time zone, timestamp without time zone)    FUNCTION     O  CREATE FUNCTION dbi_gestione_cu.ncp_get_oggetto_del_controllo(_data_1 timestamp without time zone DEFAULT '1900-01-01 00:00:00'::timestamp without time zone, _data_2 timestamp without time zone DEFAULT NULL::timestamp without time zone) RETURNS TABLE(id_controllo integer, id_oggetto_del_controllo integer, oggetto_del_controllo text, id_macrocategoria integer, descrizione_macrocategoria text)
    LANGUAGE plpgsql
    AS $$

DECLARE
BEGIN
for   
	id_controllo,
	id_oggetto_del_controllo,
	oggetto_del_controllo,
	id_macrocategoria,
	descrizione_macrocategoria
in select
	distinct t.ticketid as id_controllo,
	li.code as id_oggetto_del_controllo,
	case when (li.description::text) ilike 'altro' then concat_ws('-',concat(li.description,':'),t.note_altro,t.ispezioni_desc1, t.ispezioni_desc2,  
	t.ispezioni_desc3, t.ispezioni_desc4,t.ispezioni_desc5, t.ispezioni_desc6, t.ispezioni_desc7,t.ispezioni_desc8)
        else (li.description::text) 
        end as oggetto_del_controllo,
	lim.code,
	lim.description
	from ticket t
	left join tipocontrolloufficialeimprese tcu on tcu.idcontrollo = t.ticketid
	left join lookup_ispezione li on li.code=tcu.ispezione 
	left join lookup_ispezione_macrocategorie lim on lim.code = li.level 
							and (case when (lim.description is not null or lim.description <> '') then lim.enabled end) 
where 
	t.provvedimenti_prescrittivi = 2 and t.tipologia = 3 
	and t.trashed_date is null and tcu.ispezione > 0 
        and t.assigned_date  between coalesce (_data_1,'1900-01-01') and coalesce (_data_2,now()) 
  
  LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
  
 END;
$$;
 �   DROP FUNCTION dbi_gestione_cu.ncp_get_oggetto_del_controllo(_data_1 timestamp without time zone, _data_2 timestamp without time zone);
       dbi_gestione_cu          postgres    false    26            �           1255    443203 $   nucleo_is_valid(text, date, integer)    FUNCTION     \  CREATE FUNCTION dbi_gestione_cu.nucleo_is_valid(_id_componente text, anno_del_controllo date, _id_asl integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE 
nucleo text;
i integer;
validatore integer;
_anno text;
_role integer;
_id_gruppo integer;
conta_personale_asl integer;

BEGIN 
	
	i := 1;
	nucleo := (select split_part(_id_componente, '-', i));
	if(nucleo = '')THEN
		return false;
	END IF;
	_anno := (select split_part(cast(anno_del_controllo as text), '-', 1));
	raise info '%s', _anno; 
	while(nucleo <> '')LOOP
		
		_role := (select role_id from access where user_id = cast(nucleo as integer));
		conta_personale_asl :=(select count(*) from public.dpat_get_nominativi(_id_asl, cast(_anno as integer), null::text,null::integer,null::text,null::integer,null::text) d where d.id_qualifica = _role);
		_id_gruppo := (select id_gruppo from rel_gruppo_ruoli where id_ruolo = _role and id_gruppo = 11 );
		
		if(_id_gruppo = 11 AND conta_personale_asl > 0)THEN 		
			validatore := (select count (id_anagrafica_nominativo) from dpat_strumento_calcolo_nominativi where id_anagrafica_nominativo = cast(nucleo as integer) AND disabilitato = false AND trashed_date is null AND anno = cast(_anno as integer));
			if(validatore < 1)THEN
				return false;
			END IF;
		END IF; 
		
		if(_id_gruppo is null AND conta_personale_asl = 0)THEN 
			validatore :=(select count (user_id) from access where role_id = _role and username not ilike '%_cni%');
			if(validatore < 1)THEN
				return false;
			END IF;
		END IF;
		
		i := i + 1;
		nucleo := (select split_part(_id_componente, '-', i));
	END LOOP;
return true; 

END 
$$;
 n   DROP FUNCTION dbi_gestione_cu.nucleo_is_valid(_id_componente text, anno_del_controllo date, _id_asl integer);
       dbi_gestione_cu          postgres    false    26            �           1255    418127    nucleo_is_valid_ext(text)    FUNCTION     `  CREATE FUNCTION dbi_gestione_cu.nucleo_is_valid_ext(_id_componente text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE 
nucleo text;
i integer;
validatore integer;

BEGIN 

	i := 1;
	nucleo := (select split_part(_id_componente, '-', i));
	if(nucleo = '')THEN
		return false;
	END IF;
	
	while(nucleo <> '')LOOP
		validatore := (select count (user_id) from access_ext where user_id = cast(nucleo as integer) AND in_nucleo_ispettivo = true);
		if(validatore < 1)THEN
			return false;
		END IF;
		i := i + 1;
		nucleo := (select split_part(_id_componente, '-', i));
	END LOOP;
return true; 

END 
$$;
 H   DROP FUNCTION dbi_gestione_cu.nucleo_is_valid_ext(_id_componente text);
       dbi_gestione_cu          postgres    false    26            t           1255    417534    oggetto_is_valid(text)    FUNCTION     ~  CREATE FUNCTION dbi_gestione_cu.oggetto_is_valid(_oggetto_del_controllo text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE 
oggetto text;
i integer;
validatore integer;
risultato boolean;

BEGIN 
	
	i := 1;
	oggetto := (select split_part(_oggetto_del_controllo, '-',i));
	if(oggetto = '')THEN
		return false;
	END IF;
	while(oggetto <> '')LOOP
		validatore := (select count(code) from lookup_ispezione where code = cast(oggetto as integer) AND enabled = true);
		if(validatore < 1)THEN
			return false; 
		END IF; 
		i := i+1;
		oggetto := (select split_part(_oggetto_del_controllo, '-', i));
	END LOOP;

return true;
END 
$$;
 M   DROP FUNCTION dbi_gestione_cu.oggetto_is_valid(_oggetto_del_controllo text);
       dbi_gestione_cu          postgres    false    26            s           1255    417525 *   per_conto_di_is_valid(text, date, integer)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.per_conto_di_is_valid(percontodi text, _data_inizio date, _site_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE 

validatore integer;
anno_del_controllo text;
polo_didattico integer;

BEGIN 
polo_didattico := (select id_asl from dpat_strutture_asl where id = cast(percontodi as integer));
anno_del_controllo := (select split_part(cast(_data_inizio as text), '-', 1));

if(polo_didattico = 14)THEN 
	validatore := (select count (id) from dpat_strutture_asl where id = cast(percontodi as integer) AND anno = cast(anno_del_controllo as integer) AND data_scadenza is null AND disabilitato is false);
	if (validatore > 0)THEN
		return true;
	END IF;
END IF;

validatore := (select count(id) from dpat_strutture_asl where id = cast(percontodi as integer) AND id_asl = _site_id AND anno = cast(anno_del_controllo as integer) AND data_scadenza is null AND disabilitato is false);
if (validatore > 0) THEN
	return true;
END IF; 	

return false; 

END 
$$;
 k   DROP FUNCTION dbi_gestione_cu.per_conto_di_is_valid(percontodi text, _data_inizio date, _site_id integer);
       dbi_gestione_cu          postgres    false    26            y           1255    417688 &   pianomonitoraggio_is_valid(text, date)    FUNCTION       CREATE FUNCTION dbi_gestione_cu.pianomonitoraggio_is_valid(_piano_monitoraggio text, _data_inizio date) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

DECLARE
validatore integer;
anno_del_controllo integer;
motivo text;
i integer;

BEGIN
anno_del_controllo := (select split_part(cast(_data_inizio as text), '-', 1));
i := 1;
motivo := (select split_part(_piano_monitoraggio, '-', i));
if(motivo = '')THEN
	return false;
END IF; 

while(motivo <> '')LOOP
	validatore := (select count (code) from lookup_piano_monitoraggio where anno = cast(anno_del_controllo as integer) AND enabled = true AND code = cast(motivo as integer));
	if(validatore<1)THEN 
		return false; 
	END IF; 
	i := i+1;
	motivo := (select split_part(_piano_monitoraggio, '-', i));
END LOOP;	
return true; 

END
$$;
 g   DROP FUNCTION dbi_gestione_cu.pianomonitoraggio_is_valid(_piano_monitoraggio text, _data_inizio date);
       dbi_gestione_cu          postgres    false    26            r           1255    417511    rollback_dbi(integer)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.rollback_dbi(_ticketid integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

DECLARE 
elimina integer;
msg text;

BEGIN 

elimina := (select count(id_controllo_ufficiale) from linee_attivita_controlli_ufficiali where id_controllo_ufficiale = _ticketid);
if (elimina>0) THEN 
	delete from linee_attivita_controlli_ufficiali where id_controllo_ufficiale = _ticketid;
END IF;
elimina := (select count (id_controllo_ufficiale) from cu_nucleo where id_controllo_ufficiale = _ticketid);
if(elimina>0)THEN
	delete from  cu_nucleo where id_controllo_ufficiale = _ticketid; 
END IF; 
elimina := (select count (idcontrollo) from tipocontrolloufficialeimprese where idcontrollo= _ticketid);
if(elimina>0)THEN
	delete from tipocontrolloufficialeimprese where idcontrollo = _ticketid;
END IF;
elimina := (select count (ticketid) from ticket where ticketid = _ticketid);
if(elimina>0)THEN 
	delete from ticket where ticketid = _ticketid;
END IF;

msg := _ticketid;
return msg;
END 
$$;
 ?   DROP FUNCTION dbi_gestione_cu.rollback_dbi(_ticketid integer);
       dbi_gestione_cu          postgres    false    26            |           1255    417921    text_null(text)    FUNCTION     �   CREATE FUNCTION dbi_gestione_cu.text_null(valore text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$

 BEGIN
	
	
	if((length(trim(valore)) > 1) AND valore IS NOT NULL AND valore <> '-1')THEN 
		return true;
	END IF;
	
	

return false;
END
$$;
 6   DROP FUNCTION dbi_gestione_cu.text_null(valore text);
       dbi_gestione_cu          postgres    false    26            �           1255    443172 Z   update_cu_audit(integer, text, date, integer, date, text, text, public.hstore, text, text)    FUNCTION     �&  CREATE FUNCTION dbi_gestione_cu.update_cu_audit(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _ispezione text, _tipoispezione text, _id_unita_operativa public.hstore, _id_componente text, _id_linea_attivita text) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_modified date;
_enabled boolean;
_provvedimenti_prescrittivi integer;
 i integer;
 motivo text;
 motivo_p text;
 motivo_k text;
 nucleo text;
 oggetto text;
 msg1 text;
 validatore_percontodi boolean; 
 _tipo_audit integer;
_bpi integer;
_haccp integer;
_audit_tipo integer;
_oggetto_audit integer;
_id_lookup_condizionalita integer; 
_site_id integer;
data_inizio_controllo date;
tipo_stabilimento text;
_id_stabilimento integer;
id_settato boolean;
attivita_split text;
oggetto_precedente text;
_codice_linea text; 
chiavi_hstore text ARRAY;
hstore_check integer;

BEGIN

msg ='';
_modified:= now();
_tipo_audit := -1;
_bpi := -1;
_haccp := -1;
_audit_tipo := -1;
_oggetto_audit := -1;
_enabled := true;
_provvedimenti_prescrittivi := 3;
_id_lookup_condizionalita := -1;
_site_id := (select site_id from ticket where ticketid = _ticketid);
data_inizio_controllo := (select assigned_date from ticket where ticketid = _ticketid);
id_settato := false;
chiavi_hstore := (akeys(_id_unita_operativa));


--Stabilisco il tipo dello stabilimento
_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_stabilimento <> 0 AND id_stabilimento is not null AND id_stabilimento <> -1));
if(_id_stabilimento > 0  AND id_settato = false)THEN
	_id_stabilimento := (select id_stabilimento from ticket where ticketid=_ticketid);
	id_settato := true;
END IF;

if(id_settato = false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (alt_id <> 0 AND alt_id is not null AND alt_id <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select alt_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato = false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_apiario <> 0 AND id_apiario is not null AND id_apiario <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select id_apiario from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato = false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (org_id <> 0 AND org_id is not null AND org_id <> -1));
	if(_id_stabilimento > 0  AND id_settato = false)THEN
		_id_stabilimento := (select org_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);

--Eseguo il controllo di tutti i campi del cu tranne del per conto di e della linea i quali controlli vengono chiamati ciclicamente
msg := (select * from dbi_gestione_cu.verifica_campi_cu_update(_ticketid, _assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _modifiedby, _tipoispezione, null::text, _ispezione, _modified, _id_componente, _id_linea_attivita, _provvedimenti_prescrittivi, tipo_stabilimento, chiavi_hstore));

--Controllo se i perconto di sono validi
if(_tipoispezione <> '' AND _id_unita_operativa <> '' AND _tipoispezione is not null AND _id_unita_operativa is not null)THEN
	i := 1; 
	motivo := (select split_part(_tipoispezione, '-', i));
	motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
	motivo_k := (select split_part(_id_unita_operativa -> 'ispezione', '-', i));
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		if(motivo = motivo_k)THEN
			motivo_k := (select split_part(motivo_p, '-', 2));
			validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo_k, data_inizio_controllo, _site_id));
			if(validatore_percontodi = false)THEN 
				msg := ' KO PER CONTO DI NON VALIDO ';
				return msg;
			END IF;
		ELSE 
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			return msg;
		END IF;
		motivo := (select split_part(_tipoispezione, '-', i));
		motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
		motivo_k := (select split_part(motivo_p, '-', 1));
		if(motivo <> motivo_k)THEN
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;	
	END LOOP;
END IF;

-- se tutti i controlli sono andati a buon fine, posso procedere a modificare il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then

	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 1, _provvedimenti_prescrittivi);
	
	if(_problem <> '' AND _problem is not null)THEN 
		update ticket set problem = _problem, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Campo note modificato in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_assigned_date is not null)THEN
		update ticket set assigned_date = _assigned_date, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data inizio controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_data_fine_controllo is not null)THEN
		update ticket set data_fine_controllo = _data_fine_controllo, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data fine controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
			
			--Update del perconto di 
	if(_id_unita_operativa <> '' AND _tipoispezione <> '' AND _id_unita_operativa is not null AND _tipoispezione is not null)THEN 
		update tipocontrolloufficialeimprese set enabled = false, note_hd = 'Record modificato da dbi' where idcontrollo = _ticketid AND ispezione = -1;	
		i := 1; 
		motivo := (select split_part(_tipoispezione, '-', i));
		motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
		motivo_k := (select split_part(_id_unita_operativa -> 'ispezione', '-', i));
		while(motivo is not null AND motivo <> '') LOOP 
			i := i+ 1;	
			if(motivo = motivo_k)THEN
				motivo_k := (select split_part(motivo_p, '-', 2));
				insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
					VALUES(_ticketid, _tipo_audit, _bpi, _haccp, cast(motivo as integer), -1, -1, _audit_tipo, cast(motivo_k as integer), _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);
			END IF;			
			motivo := (select split_part(_tipoispezione, '-', i));
			motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
			motivo_k := (select split_part(motivo_p, '-', 1));
		END LOOP;
	END IF; 
	

--Update di uno o piu oggetti sottoposti al controllo
	if(_ispezione <> '' AND _ispezione is not null)THEN
		delete from tipocontrolloufficialeimprese where ispezione <> -1 AND idcontrollo = _ticketid;
		i := 1;
		oggetto := (select split_part(_ispezione, '-', i));
		while(oggetto is not null AND oggetto <> '') LOOP
			i := i+1;
			insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita, note_hd)
				VALUES(_ticketid, _tipo_audit, _bpi, _haccp, -1, -1, cast(oggetto as integer), _audit_tipo, -1, _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita, CONCAT('Modifica effettuata tramite DBI (valore precedente oggetto del controllo : ', oggetto_precedente, ')'));
			oggetto := (select split_part(_ispezione, '-', i));
		END LOOP;
	END IF; 

--Inserimento del nucleo ispettivo
	if(_id_componente <> '' AND _id_componente is not null)THEN
		update cu_nucleo set enabled = false, note_hd = 'Nucleo ispettivo modificato da dbi' where id_controllo_ufficiale = _ticketid;
		i := 1;
		nucleo := (select split_part(_id_componente, '-', i));
		while(nucleo is not null AND nucleo <> '') LOOP
			i:= i + 1; 
			insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
				VALUES(_ticketid, cast(nucleo as integer), _enabled);
			nucleo := (select split_part(_id_componente, '-', i));
		END LOOP;
	END IF;
	
	--Inserimento delle linee attivita che possono essere multiple
			if(_id_linea_attivita <> '' AND _id_linea_attivita is not null)THEN
				update linee_attivita_controlli_ufficiali set trashed_date = now (), note_internal_use_only = 'Linea di attivita sottoposta a controllo modificata da dbi', modified_by = _modifiedby, modified = _modified where id_controllo_ufficiale = _ticketid;
				i :=1;
				attivita_split := (select split_part(_id_linea_attivita, '-', i));
				while(attivita_split is not null AND attivita_split <> '') LOOP
					i := i+1;
					_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = cast(attivita_split as integer));
					insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, entered, entered_by, riferimento_nome_tab, codice_linea)
						VALUES(_ticketid , cast(attivita_split as integer), _modified, _modifiedby, tipo_stabilimento, _codice_linea);
					attivita_split := (select split_part(_id_linea_attivita, '-', i));
				END LOOP;
			END IF;
	
	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 2, _provvedimenti_prescrittivi);
	msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
   DROP FUNCTION dbi_gestione_cu.update_cu_audit(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _ispezione text, _tipoispezione text, _id_unita_operativa public.hstore, _id_componente text, _id_linea_attivita text);
       dbi_gestione_cu          postgres    false    26            �           1255    443229 p   update_cu_ispezione_semplice(integer, text, date, integer, date, text, text, text, public.hstore, text, integer)    FUNCTION     M3  CREATE FUNCTION dbi_gestione_cu.update_cu_ispezione_semplice(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _ispezione text, _tipoispezione text, _pianomonitoraggio text, _id_unita_operativa public.hstore, _id_componente text, _id_linea_attivita integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_modified date;
_enabled boolean;
 i integer;
 motivo text;
 motivo_p text;
 motivo_k text;
 nucleo text;
 oggetto text;
 msg1 text;
 _tipo_audit integer;
_bpi integer;
_haccp integer;
_audit_tipo integer;
_oggetto_audit integer;
_id_lookup_condizionalita integer; 
_site_id integer;
data_inizio_controllo date;
tipo_stabilimento text;
_id_stabilimento integer;
id_settato boolean;
attivita_split text;
oggetto_precedente text;
_codice_linea text; 
validatore_percontodi boolean;
_provvedimenti_prescrittivi integer;
chiavi_hstore text array;
BEGIN

msg ='';
_modified:= now();
_tipo_audit := -1;
_bpi := -1;
_haccp := -1;
_audit_tipo := -1;
_oggetto_audit := -1;
_enabled := true;
_id_lookup_condizionalita := -1;
_provvedimenti_prescrittivi = 4;
_site_id := (select site_id from ticket where ticketid = _ticketid);
data_inizio_controllo := (select assigned_date from ticket where ticketid = _ticketid);
id_settato := false;
chiavi_hstore := (akeys(_id_unita_operativa));

_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_stabilimento <> 0 AND id_stabilimento is not null AND id_stabilimento <> -1));
if(_id_stabilimento > 0 AND id_settato = false)THEN
	_id_stabilimento := (select id_stabilimento from ticket where ticketid=_ticketid);
	id_settato := true;
END IF;
if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (alt_id <> 0 AND alt_id is not null AND alt_id <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select alt_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_apiario <> 0 AND id_apiario is not null AND id_apiario <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select id_apiario from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (org_id <> 0 AND org_id is not null AND org_id <> -1));
	if(_id_stabilimento > 0  AND id_settato = false)THEN
		_id_stabilimento := (select org_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;
tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);

--Eseguo il controllo di tutti i campi del cu tranne del per conto di che viene validato al interno di un ciclo
msg := (select * from dbi_gestione_cu.verifica_campi_cu_update(_ticketid, _assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _modifiedby, _tipoispezione, _pianomonitoraggio, _ispezione, _modified, _id_componente, cast(_id_linea_attivita as text), _provvedimenti_prescrittivi, tipo_stabilimento, chiavi_hstore));

--Controllo se i perconto di sono validi
if(_tipoispezione <> '' AND _id_unita_operativa <> '' AND _tipoispezione is not null AND _id_unita_operativa is not null)THEN
	i := 1; 
	motivo := (select split_part(_tipoispezione, '-', i));
	motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
	motivo_k := (select split_part(_id_unita_operativa -> 'ispezione', '-', i));
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		if(motivo = motivo_k)THEN
			motivo_k := (select split_part(motivo_p, '-', 2));
			validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo_k, data_inizio_controllo, _site_id));
			if(validatore_percontodi = false)THEN 
				msg := ' KO PER CONTO DI NON VALIDO ';
				return msg;
			END IF;
		ELSE 
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			return msg;
		END IF;
		motivo := (select split_part(_tipoispezione, '-', i));
		motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
		motivo_k := (select split_part(motivo_p, '-', 1));
		if(motivo <> motivo_k)THEN
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;	
	END LOOP;
END IF;

--Controllo se i perconto di sono validi
if(_pianomonitoraggio <> '' AND _id_unita_operativa <> '' AND _pianomonitoraggio is not null AND _id_unita_operativa is not null)THEN
	i := 1; 
	motivo := (select split_part(_pianomonitoraggio, '-', i));
	motivo_p := (select split_part(_id_unita_operativa -> 'piano', '/', i));
	motivo_k := (select split_part(_id_unita_operativa -> 'piano', '-', i));
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		if(motivo = motivo_k)THEN
			motivo_k := (select split_part(motivo_p, '-', 2));
			validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo_k, data_inizio_controllo, _site_id));
			if(validatore_percontodi = false)THEN 
				msg := ' KO PER CONTO DI NON VALIDO ';
				return msg;
			END IF;
		ELSE
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			return msg;
		END IF;
		motivo := (select split_part(_pianomonitoraggio, '-', i));
		motivo_p := (select split_part(_id_unita_operativa -> 'piano', '/', i));
		motivo_k := (select split_part(motivo_p, '-', 1));
		if(motivo <> motivo_k)THEN
			msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
			msg1 := (select * from dbi_gestione_cu.rollback_dbi(_ticketid));
			return concat(msg, msg1);
		END IF;	
	END LOOP;
END IF;

-- se tutti i controlli sono andati a buon fine, posso procedere ad aggiornare il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then

	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 1, _provvedimenti_prescrittivi);
	
	if(_problem <> '')THEN 
		update ticket set problem = _problem, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Campo note modificato in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_assigned_date is not null)THEN
		update ticket set assigned_date = _assigned_date, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data inizio controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_data_fine_controllo is not null)THEN
		update ticket set data_fine_controllo = _data_fine_controllo, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data fine controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
			
	if(_id_unita_operativa <> '' AND _tipoispezione <> '' AND _id_unita_operativa is not null AND _tipoispezione is not null)THEN 
		update tipocontrolloufficialeimprese set enabled = false, note_hd = 'Record modificato da dbi' where idcontrollo = _ticketid AND ispezione = -1;	
	END IF;
	if(_id_unita_operativa <> '' AND _pianomonitoraggio <> '' AND _id_unita_operativa is not null AND _pianomonitoraggio is not null)THEN 
		update tipocontrolloufficialeimprese set enabled = false, note_hd = 'Record modificato da dbi' where idcontrollo = _ticketid AND ispezione = -1;	
	END IF; 
			--Update del perconto di e del attivita 
	if(_id_unita_operativa <> '' AND _tipoispezione <> ''AND _id_unita_operativa is not null AND _tipoispezione is not null)THEN 
			i := 1; 
			motivo := (select split_part(_tipoispezione, '-', i));
			motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
			motivo_k := (select split_part(_id_unita_operativa -> 'ispezione', '-', i));
			while(motivo is not null AND motivo <> '') LOOP 
				i := i+ 1;	
				if(motivo = motivo_k)THEN
					motivo_k := (select split_part(motivo_p, '-', 2));
					insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
						VALUES(_ticketid, _tipo_audit, _bpi, _haccp, cast(motivo as integer), -1, -1, _audit_tipo, cast(motivo_k as integer), _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);
				ELSE 
					msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
					return msg;
				END IF;
				motivo := (select split_part(_tipoispezione, '-', i));
				motivo_p := (select split_part(_id_unita_operativa -> 'ispezione', '/', i));
				motivo_k := (select split_part(motivo_p, '-', 1));
			END LOOP;
		END IF; 
	
			--Update del perconto di e del piano
	if(_id_unita_operativa <> '' AND _pianomonitoraggio <> ''  AND _id_unita_operativa is not null AND _pianomonitoraggio is not null)THEN 
			i := 1; 
			motivo := (select split_part(_pianomonitoraggio, '-', i));
			motivo_p := (select split_part(_id_unita_operativa -> 'piano', '/', i));
			motivo_k := (select split_part(_id_unita_operativa -> 'piano', '-', i));
			raise info 'motivo %s', motivo;
			raise info 'motivo k %s', motivo_k;
			while(motivo is not null AND motivo <> '') LOOP 
				i := i+ 1;	
				if(motivo = motivo_k)THEN
					motivo_k := (select split_part(motivo_p, '-', 2));
					insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita)
						VALUES(_ticketid, _tipo_audit, _bpi, _haccp, 89, cast(motivo as integer), -1, _audit_tipo, cast(motivo_k as integer), _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita);
				ELSE 
					msg := 'MOTIVI DEL HSTORE DISCORDANTI DAI MOTIVI ESPLICITATI NEL CAMPO TIPO ISPEZIONE';
					return msg;
				END IF;
				motivo := (select split_part(_pianomonitoraggio, '-', i));
				motivo_p := (select split_part(_id_unita_operativa -> 'piano', '/', i));
				motivo_k := (select split_part(motivo_p, '-', 1));
			END LOOP;
		END IF; 

--Update di uno o piu oggetti sottoposti al controllo
	if(_ispezione <> '' AND _ispezione is not null)THEN
		oggetto_precedente := (select string_agg(cast(ispezione as text), ' , ') oggetto_del_controllo from tipocontrolloufficialeimprese where idcontrollo = _ticketid);
		oggetto_precedente := (select BTRIM(oggetto_precedente, '-1'));
		delete from tipocontrolloufficialeimprese where ispezione <> -1 AND idcontrollo = _ticketid;
		i := 1;
		oggetto := (select split_part(_ispezione, '-', i));
		while(oggetto is not null AND oggetto <> '') LOOP
			i := i+1;
			insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita, note_hd)
				VALUES(_ticketid, _tipo_audit, _bpi, _haccp, -1, -1, cast(oggetto as integer), _audit_tipo, -1, _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita, CONCAT('Modifica effettuata tramite DBI (valore precedente oggetto del controllo : ', oggetto_precedente, ')'));
			oggetto := (select split_part(_ispezione, '-', i));
		END LOOP; 
	END IF; 

--Inserimento del nucleo ispettivo
	if(_id_componente <> '' AND _id_componente is not null)THEN
		update cu_nucleo set enabled = false, note_hd = 'Nucleo ispettivo modificato da dbi' where id_controllo_ufficiale = _ticketid;
		i := 1;
		nucleo := (select split_part(_id_componente, '-', i));
		while(nucleo is not null AND nucleo <> '') LOOP
			i:= i + 1; 
			insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
				VALUES(_ticketid, cast(nucleo as integer), _enabled);
			nucleo := (select split_part(_id_componente, '-', i));
		END LOOP;
	END IF;
	
	if(_id_linea_attivita is not null AND _id_linea_attivita <> -1)THEN
		update linee_attivita_controlli_ufficiali set trashed_date = now (), note_internal_use_only = 'Linea di attivita sottoposta a controllo modificata da dbi', modified_by = _modifiedby, modified = _modified where id_controllo_ufficiale = _ticketid;
		_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = _id_linea_attivita);
		insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, entered, entered_by, riferimento_nome_tab, codice_linea)
			VALUES(_ticketid , _id_linea_attivita, _modified, _modifiedby, tipo_stabilimento, _codice_linea);
	END IF; 				
			
	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 2, _provvedimenti_prescrittivi);
	msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
 6  DROP FUNCTION dbi_gestione_cu.update_cu_ispezione_semplice(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _ispezione text, _tipoispezione text, _pianomonitoraggio text, _id_unita_operativa public.hstore, _id_componente text, _id_linea_attivita integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443300 Y   update_cu_ispezione_semplice_ext(integer, text, date, integer, date, text, text, integer)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.update_cu_ispezione_semplice_ext(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _ispezione text, _id_componente text, _id_linea_attivita integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_modified date;
_enabled boolean;
 i integer;
 nucleo text;
 oggetto text;
 msg1 text;
 _tipo_audit integer;
_bpi integer;
_haccp integer;
_audit_tipo integer;
_oggetto_audit integer;
_id_lookup_condizionalita integer; 
_site_id integer;
data_inizio_controllo date;
tipo_stabilimento text;
_id_stabilimento integer;
id_settato boolean;
oggetto_precedente text;
_codice_linea text; 

BEGIN

msg ='';
_modified:= now();
_tipo_audit := -1;
_bpi := -1;
_haccp := -1;
_audit_tipo := -1;
_oggetto_audit := -1;
_enabled := true;
_id_lookup_condizionalita := -1;
_site_id := (select site_id from ticket where ticketid = _ticketid);
data_inizio_controllo := (select assigned_date from ticket where ticketid = _ticketid);
id_settato := false;

_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_stabilimento <> 0 AND id_stabilimento is not null AND id_stabilimento <> -1));
if(_id_stabilimento > 0 AND id_settato = false)THEN
	_id_stabilimento := (select id_stabilimento from ticket where ticketid=_ticketid);
	id_settato := true;
END IF;
if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (alt_id <> 0 AND alt_id is not null AND alt_id <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select alt_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_apiario <> 0 AND id_apiario is not null AND id_apiario <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select id_apiario from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (org_id <> 0 AND org_id is not null AND org_id <> -1));
	if(_id_stabilimento > 0  AND id_settato = false)THEN
		_id_stabilimento := (select org_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;
tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);

--Eseguo il controllo di tutti i campi del cu 
msg := (select * from dbi_gestione_cu.verifica_campi_cu_update(_ticketid, _assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _modifiedby, null::text, null::text, _ispezione, _modified, _id_componente, cast(_id_linea_attivita as text), 1, tipo_stabilimento, null::text[]));

-- se tutti i controlli sono andati a buon fine, posso procedere ad aggiornare il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then

	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 1, 1);
	if(_problem <> '')THEN 
		update ticket set problem = _problem, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Campo note modificato in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_assigned_date is not null)THEN
		update ticket set assigned_date = _assigned_date, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data inizio controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_data_fine_controllo is not null)THEN
		update ticket set data_fine_controllo = _data_fine_controllo, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data fine controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;

--Update di uno o piu oggetti sottoposti al controllo
	if(_ispezione <> '' AND _ispezione is not null)THEN
		
		oggetto_precedente := (select string_agg(cast(ispezione as text), ' , ') oggetto_del_controllo from tipocontrolloufficialeimprese where idcontrollo = _ticketid);
		oggetto_precedente := (select BTRIM(oggetto_precedente, '-1'));
		delete from tipocontrolloufficialeimprese where ispezione <> -1 AND idcontrollo = _ticketid;
		i := 1;
		oggetto := (select split_part(_ispezione, '-', i));
		while(oggetto is not null AND oggetto <> '') LOOP
			i := i+1;
			insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita, note_hd)
				VALUES(_ticketid, _tipo_audit, _bpi, _haccp, -1, -1, cast(oggetto as integer), _audit_tipo, -1, _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita, CONCAT('Modifica effettuata tramite DBI (valore precedente oggetto del controllo : ', oggetto_precedente, ')'));
			oggetto := (select split_part(_ispezione, '-', i));
		END LOOP;
	END IF; 

--Inserimento del nucleo ispettivo
	if(_id_componente <> '' AND _id_componente is not null)THEN
		update cu_nucleo set enabled = false, note_hd = 'Nucleo ispettivo modificato da dbi' where id_controllo_ufficiale = _ticketid;
		i := 1;
		nucleo := (select split_part(_id_componente, '-', i));
		while(nucleo is not null AND nucleo <> '') LOOP
			i:= i + 1; 
			insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
				VALUES(_ticketid, cast(nucleo as integer), _enabled);
			nucleo := (select split_part(_id_componente, '-', i));
		END LOOP;
	END IF;
	

	if(_id_linea_attivita is not null AND _id_linea_attivita <> -1)THEN
		update linee_attivita_controlli_ufficiali set trashed_date = now (), note_internal_use_only = 'Linea di attivita sottoposta a controllo modificata da dbi', modified_by = _modifiedby, modified = _modified where id_controllo_ufficiale = _ticketid;
		_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = _id_linea_attivita);
		insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, entered, entered_by, riferimento_nome_tab, codice_linea)
			VALUES(_ticketid , _id_linea_attivita, _modified, _modifiedby, tipo_stabilimento, _codice_linea);
	END IF;				
			
	
	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 2, 1);
	msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
 �   DROP FUNCTION dbi_gestione_cu.update_cu_ispezione_semplice_ext(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _ispezione text, _id_componente text, _id_linea_attivita integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443313 R   update_cu_ispezioni_carni(integer, text, date, integer, date, text, text, integer)    FUNCTION       CREATE FUNCTION dbi_gestione_cu.update_cu_ispezioni_carni(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _id_unita_operativa text, _id_componente text, _id_linea_attivita integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_modified date;
_enabled boolean;
 i integer;
 motivo text;
 nucleo text;
 msg1 text;
 validatore_percontodi boolean;
 _tipo_audit integer;
_bpi integer;
_haccp integer;
_audit_tipo integer;
_oggetto_audit integer;
_id_lookup_condizionalita integer; 
_site_id integer;
data_inizio_controllo date;
tipo_stabilimento text;
_id_stabilimento integer;
id_settato boolean;
_codice_linea text; 
perconto_di_precedente text;
_provvedimenti_prescrittivi integer;

BEGIN

msg ='';
_modified:= now();
_tipo_audit := -1;
_bpi := -1;
_haccp := -1;
_audit_tipo := -1;
_oggetto_audit := -1;
_enabled := true;
_id_lookup_condizionalita := -1;
_site_id := (select site_id from ticket where ticketid = _ticketid);
data_inizio_controllo := (select assigned_date from ticket where ticketid = _ticketid);
id_settato := false;
_provvedimenti_prescrittivi = 26;

_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_stabilimento <> 0 AND id_stabilimento is not null AND id_stabilimento <> -1));
if(_id_stabilimento > 0 AND id_settato = false)THEN
	_id_stabilimento := (select id_stabilimento from ticket where ticketid=_ticketid);
	id_settato := true;
END IF;
if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (alt_id <> 0 AND alt_id is not null AND alt_id <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select alt_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_apiario <> 0 AND id_apiario is not null AND id_apiario <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select id_apiario from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (org_id <> 0 AND org_id is not null AND org_id <> -1));
	if(_id_stabilimento > 0  AND id_settato = false)THEN
		_id_stabilimento := (select org_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;
tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);

--Eseguo il controllo di tutti i campi del cu 
msg := (select * from dbi_gestione_cu.verifica_campi_cu_update(_ticketid, _assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _modifiedby, _id_unita_operativa, null::text, null::text, _modified, _id_componente, cast(_id_linea_attivita as text), _provvedimenti_prescrittivi, tipo_stabilimento, null::text[]));

--Controllo se i perconto di sono validi
if( _id_unita_operativa <> '' AND _id_unita_operativa is not null)THEN
	i := 1; 
	motivo := (select split_part(_id_unita_operativa, '-', i));
	if(motivo = '')THEN
		msg := ' KO PER CONTO DI NON VALIDO ';
		return msg;
	END IF;		
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo, data_inizio_controllo, _site_id));
			if(validatore_percontodi = false)THEN 
				msg := ' KO PER CONTO DI NON VALIDO ';
				return msg;
			END IF;
		motivo := (select split_part(_id_unita_operativa, '-', i));
	END LOOP;
END IF;

-- se tutti i controlli sono andati a buon fine, posso procedere ad aggiornare il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then
	
	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 1, _provvedimenti_prescrittivi);
	
	if(_problem <> '' AND _problem is not null)THEN 
		update ticket set problem = _problem, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Campo note modificato in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_assigned_date is not null)THEN
		update ticket set assigned_date = _assigned_date, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data inizio controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_data_fine_controllo is not null)THEN
		update ticket set data_fine_controllo = _data_fine_controllo, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data fine controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	
			--Update del perconto di
	if(_id_unita_operativa <> '' AND _id_unita_operativa is not null)THEN 
		perconto_di_precedente := (select string_agg(cast(id_unita_operativa as text), ' , ') per_conto_di from unita_operative_controllo where id_controllo = _ticketid);
		delete from unita_operative_controllo where id_controllo = _ticketid;
		i := 1; 
		motivo := (select split_part(_id_unita_operativa, '-', i));			
		while(motivo is not null AND motivo <> '') LOOP 
			i := i+ 1;	
			insert into unita_operative_controllo(id_controllo, id_unita_operativa, note_internal_use_only_hd)
				VALUES(_ticketid, cast(motivo as integer), CONCAT('Modifica effettuata tramite DBI (valore precedente del per conto di: ', perconto_di_precedente, ')'));
			motivo := (select split_part(_id_unita_operativa, '-', i));
		END LOOP;
	END IF; 
	
--Inserimento del nucleo ispettivo
	if(_id_componente <> '' and _id_componente is not null)THEN
		update cu_nucleo set enabled = false, note_hd = 'Nucleo ispettivo modificato da dbi' where id_controllo_ufficiale = _ticketid;
		i := 1;
		nucleo := (select split_part(_id_componente, '-', i));
		while(nucleo is not null AND nucleo <> '') LOOP
			i:= i + 1; 
			insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
				VALUES(_ticketid, cast(nucleo as integer), _enabled);
			nucleo := (select split_part(_id_componente, '-', i));
		END LOOP;
	END IF;
	
--Update linea attivita
	if(_id_linea_attivita is not null AND _id_linea_attivita <> -1)THEN
		update linee_attivita_controlli_ufficiali set trashed_date = now (), note_internal_use_only = 'Linea di attivita sottoposta a controllo modificata da dbi', modified_by = _modifiedby, modified = _modified where id_controllo_ufficiale = _ticketid;
		_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = _id_linea_attivita);
		insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, entered, entered_by, riferimento_nome_tab, codice_linea)
			VALUES(_ticketid , _id_linea_attivita, _modified, _modifiedby, tipo_stabilimento, _codice_linea);
	END IF; 				
			
	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 2, _provvedimenti_prescrittivi);
	msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
 �   DROP FUNCTION dbi_gestione_cu.update_cu_ispezioni_carni(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _id_unita_operativa text, _id_componente text, _id_linea_attivita integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443358 L   update_cu_ncp(integer, text, date, integer, date, text, text, text, integer)    FUNCTION     }!  CREATE FUNCTION dbi_gestione_cu.update_cu_ncp(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _ispezione text, _id_unita_operativa text, _id_componente text, _id_linea_attivita integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_modified date;
_enabled boolean;
 i integer;
 motivo text;
 nucleo text;
 validatore_data boolean; 
 validatore_nucleo boolean; 
 msg1 text;
 validatore_text boolean;
 validatore_integer boolean;
 validatore_entered boolean;
 validatore_percontodi boolean;
 _tipo_audit integer;
_bpi integer;
_haccp integer;
_audit_tipo integer;
_oggetto_audit integer;
_id_lookup_condizionalita integer; 
_site_id integer;
data_inizio_controllo date;
tipo_stabilimento text;
_id_stabilimento integer;
id_settato boolean;
validatore_linea boolean;
_codice_linea text; 
perconto_di_precedente text;
oggetto_precedente text;
oggetto text;
validatore_oggetto boolean;
_provvedimenti_prescrittivi integer;
BEGIN

msg ='';
_modified:= now();
_tipo_audit := -1;
_bpi := -1;
_haccp := -1;
_audit_tipo := -1;
_oggetto_audit := -1;
_enabled := true;
_id_lookup_condizionalita := -1;
_site_id := (select site_id from ticket where ticketid = _ticketid);
data_inizio_controllo := (select assigned_date from ticket where ticketid = _ticketid);
id_settato := false;
_provvedimenti_prescrittivi = 2;

_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_stabilimento <> 0 AND id_stabilimento is not null AND id_stabilimento <> -1));
if(_id_stabilimento > 0 AND id_settato = false)THEN
	_id_stabilimento := (select id_stabilimento from ticket where ticketid=_ticketid);
	id_settato := true;
END IF;
if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (alt_id <> 0 AND alt_id is not null AND alt_id <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select alt_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (id_apiario <> 0 AND id_apiario is not null AND id_apiario <> -1));
	if(_id_stabilimento > 0 AND id_settato = false)THEN
		_id_stabilimento := (select id_apiario from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;

if(id_settato is false)THEN
	_id_stabilimento := (select count(ticketid) from ticket where ticketid = _ticketid AND (org_id <> 0 AND org_id is not null AND org_id <> -1));
	if(_id_stabilimento > 0  AND id_settato = false)THEN
		_id_stabilimento := (select org_id from ticket where ticketid=_ticketid);
		id_settato := true;
	END IF;
END IF;
tipo_stabilimento := (select DISTINCT riferimento_id_nome_tab from ricerche_anagrafiche_old_materializzata where riferimento_id = _id_stabilimento);

--Eseguo il controllo di tutti i campi del cu 
msg := (select * from dbi_gestione_cu.verifica_campi_cu_update(_ticketid, _assigned_date, _site_id, _data_fine_controllo, _id_stabilimento, _modifiedby, _id_unita_operativa, null::text, _ispezione, _modified, _id_componente, cast(_id_linea_attivita as text), _provvedimenti_prescrittivi, tipo_stabilimento, null::text[]));

--Controllo se i perconto di sono validi
if( _id_unita_operativa <> '' AND _id_unita_operativa is not null)THEN
	i := 1; 
	motivo := (select split_part(_id_unita_operativa, '-', i));
	if(motivo = '')THEN
		msg := ' KO PER CONTO DI NON VALIDO ';
		return msg;
	END IF;
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo, data_inizio_controllo, _site_id));
			if(validatore_percontodi = false)THEN 
				msg := ' KO PER CONTO DI NON VALIDO ';
				return msg;
			END IF;
		motivo := (select split_part(_id_unita_operativa, '-', i));
	END LOOP;
END IF;

-- se tutti i controlli sono andati a buon fine, posso procedere ad aggiornare il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then

	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 1, _provvedimenti_prescrittivi);
	
	if(_problem <> '')THEN 
		update ticket set problem = _problem, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Campo note modificato in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_assigned_date is not null)THEN
		update ticket set assigned_date = _assigned_date, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data inizio controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_data_fine_controllo is not null)THEN
		update ticket set data_fine_controllo = _data_fine_controllo, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data fine controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	
			--Update del perconto di
	if(_id_unita_operativa <> '' AND _id_unita_operativa is not null)THEN 
		perconto_di_precedente := (select string_agg(cast(id_unita_operativa as text), ' , ') per_conto_di from unita_operative_controllo where id_controllo = _ticketid);
		delete from unita_operative_controllo where id_controllo = _ticketid;
		i := 1; 
		motivo := (select split_part(_id_unita_operativa, '-', i));
		while(motivo is not null AND motivo <> '') LOOP 
			i := i+ 1;	
			insert into unita_operative_controllo(id_controllo, id_unita_operativa, note_internal_use_only_hd)
				VALUES(_ticketid, cast(motivo as integer), CONCAT('Modifica effettuata tramite DBI (valore precedente del per conto di: ', perconto_di_precedente, ')'));
			motivo := (select split_part(_id_unita_operativa, '-', i));
		END LOOP;
	END IF; 
	
	--Update di uno o piu oggetti sottoposti al controllo
	if(_ispezione <> '' AND _ispezione is not null)THEN
		oggetto_precedente := (select string_agg(cast(ispezione as text), ' , ') oggetto_del_controllo from tipocontrolloufficialeimprese where idcontrollo = _ticketid);
		oggetto_precedente := (select BTRIM(oggetto_precedente, '-1'));
		delete from tipocontrolloufficialeimprese where ispezione <> -1 AND idcontrollo = _ticketid;
		i := 1;
		oggetto := (select split_part(_ispezione, '-', i));
		while(oggetto is not null AND oggetto <> '') LOOP
			i := i+1;
			insert into tipocontrolloufficialeimprese(idcontrollo, tipo_audit, bpi, haccp, tipoispezione, pianomonitoraggio, ispezione, audit_tipo, id_unita_operativa, oggetto_audit, enabled, modified, modifiedby, id_lookup_condizionalita, note_hd)
				VALUES(_ticketid, _tipo_audit, _bpi, _haccp, -1, -1, cast(oggetto as integer), _audit_tipo, -1, _oggetto_audit, _enabled, _modified, _modifiedby, _id_lookup_condizionalita, CONCAT('Modifica effettuata tramite DBI (valore precedente oggetto del controllo : ', oggetto_precedente, ')'));
			oggetto := (select split_part(_ispezione, '-', i));
		END LOOP;
	END IF; 

--Inserimento del nucleo ispettivo
	if(_id_componente <> '' AND _id_componente is not null)THEN
		update cu_nucleo set enabled = false, note_hd = 'Nucleo ispettivo modificato da dbi' where id_controllo_ufficiale = _ticketid;
		i := 1;
		nucleo := (select split_part(_id_componente, '-', i));
		while(nucleo is not null AND nucleo <> '') LOOP
			i:= i + 1; 
			insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
				VALUES(_ticketid, cast(nucleo as integer), _enabled);
			nucleo := (select split_part(_id_componente, '-', i));
		END LOOP;
	END IF;
	
--Update linea attivita
	if(_id_linea_attivita is not null AND _id_linea_attivita <> -1)THEN
		update linee_attivita_controlli_ufficiali set trashed_date = now (), note_internal_use_only = 'Linea di attivita sottoposta a controllo modificata da dbi', modified_by = _modifiedby, modified = _modified where id_controllo_ufficiale = _ticketid;
		_codice_linea :=  (select codice_linea from public.get_linee_attivita(_id_stabilimento, tipo_stabilimento, false, -1) where id = _id_linea_attivita);
		insert into linee_attivita_controlli_ufficiali(id_controllo_ufficiale, id_linea_attivita, entered, entered_by, riferimento_nome_tab, codice_linea)
			VALUES(_ticketid , _id_linea_attivita, _modified, _modifiedby, tipo_stabilimento, _codice_linea);
	END IF; 				
			
	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 2, _provvedimenti_prescrittivi);
	msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
 �   DROP FUNCTION dbi_gestione_cu.update_cu_ncp(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _ispezione text, _id_unita_operativa text, _id_componente text, _id_linea_attivita integer);
       dbi_gestione_cu          postgres    false    26            �           1255    443340 M   update_cu_sorveglianza_aperta(integer, text, date, integer, date, text, text)    FUNCTION     �  CREATE FUNCTION dbi_gestione_cu.update_cu_sorveglianza_aperta(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _id_unita_operativa text, _id_componente text) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE
msg text ;
_modified date;
_enabled boolean;
 i integer;
 motivo text;
 nucleo text;
 msg1 text;
 validatore_percontodi boolean;
 _tipo_audit integer;
_site_id integer;
data_inizio_controllo date;
perconto_di_precedente text;
_provvedimenti_prescrittivi integer;

BEGIN

_provvedimenti_prescrittivi = 5;
msg ='';
_modified:= now();
_enabled := true;
_site_id := (select site_id from ticket where ticketid = _ticketid);
data_inizio_controllo := (select assigned_date from ticket where ticketid = _ticketid);

--Eseguo il controllo di tutti i campi del cu 
msg := (select * from dbi_gestione_cu.verifica_campi_cu_update(_ticketid, _assigned_date, _site_id, _data_fine_controllo, null::integer, _modifiedby, _id_unita_operativa, null::text, null::text, _modified, _id_componente, null::text, _provvedimenti_prescrittivi, null::text, null::text[]));

--Controllo se i perconto di sono validi
if( _id_unita_operativa <> '' AND _id_unita_operativa is not null)THEN
	i := 1; 
	motivo := (select split_part(_id_unita_operativa, '-', i));
	if(motivo = '')THEN
		msg := ' KO PER CONTO DI NON VALIDO ';
		return msg;
	END IF;
	while(motivo is not null AND motivo <> '') LOOP 
		i := i+ 1;	
		validatore_percontodi := (select * from  dbi_gestione_cu.per_conto_di_is_valid(motivo, data_inizio_controllo, _site_id));
			if(validatore_percontodi = false)THEN 
				msg := ' KO PER CONTO DI NON VALIDO ';
				return msg;
			END IF;
		motivo := (select split_part(_id_unita_operativa, '-', i));
	END LOOP;
END IF;
	
-- se tutti i controlli sono andati a buon fine, posso procedere ad aggiornare il controllo
raise info 'MESSAGGI DI ERRORE: %', msg;
if (length(trim(msg)) = 0) then

	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 1, _provvedimenti_prescrittivi);
	if(_problem <> '')THEN 
		update ticket set problem = _problem, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Campo note modificato in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_assigned_date is not null)THEN
		update ticket set assigned_date = _assigned_date, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data inizio controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	if(_data_fine_controllo is not null)THEN
		update ticket set data_fine_controllo = _data_fine_controllo, modified = _modified, modifiedby = _modifiedby, note_internal_use_only = CONCAT(note_internal_use_only, ' ', 'Data fine controllo modificata in data: ', cast(_modified as text)) where ticketid = _ticketid;
	END IF;
	
			--Update del perconto di
	if(_id_unita_operativa <> '' AND _id_unita_operativa is not null)THEN 
		perconto_di_precedente := (select string_agg(cast(id_unita_operativa as text), ' , ') per_conto_di from unita_operative_controllo where id_controllo = _ticketid);
		delete from unita_operative_controllo where id_controllo = _ticketid;
		i := 1; 
		motivo := (select split_part(_id_unita_operativa, '-', i));
		while(motivo is not null AND motivo <> '') LOOP 
			i := i+ 1;	
			insert into unita_operative_controllo(id_controllo, id_unita_operativa, note_internal_use_only_hd)
				VALUES(_ticketid, cast(motivo as integer), CONCAT('Modifica effettuata tramite DBI (valore precedente del per conto di: ', perconto_di_precedente, ')'));
			motivo := (select split_part(_id_unita_operativa, '-', i));
		END LOOP;
	END IF; 
	
--Inserimento del nucleo ispettivo
	if(_id_componente <> '' AND _id_componente is not null)THEN
		update cu_nucleo set enabled = false, note_hd = 'Nucleo ispettivo modificato da dbi' where id_controllo_ufficiale = _ticketid;
		i := 1;
		nucleo := (select split_part(_id_componente, '-', i));
		while(nucleo is not null AND nucleo <> '') LOOP
			i:= i + 1; 
			insert into cu_nucleo(id_controllo_ufficiale, id_componente, enabled)
				VALUES(_ticketid, cast(nucleo as integer), _enabled);
			nucleo := (select split_part(_id_componente, '-', i));
		END LOOP;
	END IF; 				
			
	perform * from dbi_gestione_cu.gestione_tabella_log(_ticketid, 2, _provvedimenti_prescrittivi);
	msg := concat('ok: ', _ticketid);
END IF; 
RETURN msg;

END
$$;
 �   DROP FUNCTION dbi_gestione_cu.update_cu_sorveglianza_aperta(_ticketid integer, _problem text, _assigned_date date, _modifiedby integer, _data_fine_controllo date, _id_unita_operativa text, _id_componente text);
       dbi_gestione_cu          postgres    false    26            �           1255    444434 �   verifica_campi_cu_insert(date, integer, date, integer, integer, integer, text, text, text, date, text, text, integer, text, text[])    FUNCTION     �(  CREATE FUNCTION dbi_gestione_cu.verifica_campi_cu_insert(_assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _tipoispezione text, _pianomonitoraggio text, _ispezione text, _entered date, _id_componente text, _id_linea_attivita text, _provvedimenti_prescrittivi integer, _riferimento_id_nome_tab text, chiave_hstore text[]) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE

msg text;
validatore_integer boolean;
validatore_text boolean;
validatore_data_null boolean;
validatore_asl boolean;
validatore_entered boolean;
validatore_data boolean;
validatore_oggetto boolean;
validatore_motivo boolean;
validatore_nucleo boolean;
validatore_match boolean;
validatore_piano boolean;
validatore_linea boolean;
check_hstore integer;

BEGIN 

msg := '';
raise info '%', chiave_hstore;
validatore_data_null := (select * from dbi_gestione_cu.date_null(_assigned_date));
if(validatore_data_null = false)THEN 
	msg := 'KO IL CAMPO DATA INIZIO CONTROLLO NON PUO ESSERE NULL';
	return msg;
END IF;

validatore_data_null := (select * from dbi_gestione_cu.date_null(_data_fine_controllo));
if(validatore_data_null = false)THEN 
	msg := 'KO IL CAMPO DATA FINE CONTROLLO NON PUO ESSERE NULL';
	return msg;
END IF;

--Se il controllo e un ncp la data puo essere precedente al anno attuale quindi viene usata una dbi esterna
if(_provvedimenti_prescrittivi = 2)THEN 
	validatore_data := (select * from dbi_gestione_cu.date_is_valid_ncp(_data_fine_controllo, _assigned_date, _entered));
	if(validatore_data = false) THEN 
		msg := 'KO: DATA FINE CONTROLLO INFERIORE ALLA DATA DI INIZIO DEL CONTROLLO OPPURE DATA INIZIO CONTROLLO MAGGIORE DELLA DATA ODIERNA.';
		return msg; 
	END IF;
ELSE 
	validatore_data := (select * from dbi_gestione_cu.date_is_valid(_data_fine_controllo, _assigned_date, _entered));
	if(validatore_data = false) THEN 
		msg := 'KO: DATA FINE CONTROLLO INFERIORE ALLA DATA DI INIZIO DEL CONTROLLO OPPURE DATA INIZIO CONTROLLO MAGGIORE DELLA DATA ODIERNA.';
		return msg; 
	END IF;
END IF;

validatore_integer := (select * from dbi_gestione_cu.integer_null(_site_id));
if(validatore_integer = false)THEN 
	msg := 'KO IL CAMPO ASL NON PUO ESSERE NULL';											
	return msg;
END IF;

-- Controllo se l'asl ricade nel range 201-207
validatore_asl := (select * from dbi_gestione_cu.asl_is_valid(_site_id));
if(validatore_asl = false)THEN
	msg := 'KO: ASL NON VALIDA. I VALORI CONSENTITI CORRISPONDONO ALLE ASL AVELLINO (CODICE 201), BENEVENTO  (CODICE 202), CASERTA  (CODICE 203), NAPOLI 1 CENTRO  (CODICE 204), NAPOLI 2 NORD  (CODICE 205), SALERNO  (CODICE 206)';
	return msg;
END IF; 

validatore_integer := (select * from dbi_gestione_cu.integer_null(_id_stabilimento));
if(validatore_integer = false)THEN 
	msg := 'KO IL CAMPO ID STABILIMENTO NON PUO ESSERE NULL';
	return msg;
END IF;

validatore_match := (select * from dbi_gestione_cu.match_asl_valid(_id_stabilimento, _site_id));
if(validatore_match = false) then
	msg := 'KO ASL DISCORDANTE O STABILIMENTO NON PRESENTE NEL TIPO SELEZIONATO';
	return msg;
END IF;

validatore_integer := (select * from dbi_gestione_cu.integer_null(_enteredby));
if(validatore_integer = false)THEN 
	msg := 'KO IL CAMPO ENTEREDBY NON PUO ESSERE NULL';
	return msg;
END IF;

validatore_integer := (select * from dbi_gestione_cu.integer_null(_modifiedby));
if(validatore_integer = false)THEN 
	msg := 'KO IL CAMPO MODIFIEDBY NON PUO ESSERE NULL'; 
	return msg;
END IF;

--Se il controllo e un ispezione semplice da gisa ext controllo nelle tabelle di access ext
if(_provvedimenti_prescrittivi = 1)THEN 
	validatore_entered := (select * from dbi_gestione_cu.entered_ext_is_valid(_enteredby));
	if(validatore_entered = false)THEN 
		msg := 'Inserimento da utente non presente nella tabella access_ext';
		return msg;
	END IF;

	validatore_entered := (select * from dbi_gestione_cu.entered_ext_is_valid(_modifiedby));
	if(validatore_entered = false)THEN 
		msg := 'Modifica da utente non presente nella tabella access_ext';
		return msg;
	END IF;
ELSE 	
	validatore_entered := (select * from dbi_gestione_cu.entered_is_valid(_enteredby));
	if(validatore_entered = false)THEN 
		msg := 'Inserimento da utente non presente nella tabella access';
		return msg;
	END IF;

	validatore_entered := (select * from dbi_gestione_cu.entered_is_valid(_modifiedby));
	if(validatore_entered = false)THEN 
		msg := 'Modifica da utente non presente nella tabella access';
		return msg;
	END IF;
END IF;

--Se il controllo è un ispezione semplice 
if(_provvedimenti_prescrittivi = 4)THEN
	validatore_text := (select * from dbi_gestione_cu.text_null(_tipoispezione));
	if(validatore_text = false)THEN 
		validatore_text := (select * from dbi_gestione_cu.text_null(_pianomonitoraggio));
		if(validatore_text = false)THEN 
			msg := 'KO IL CAMPO MOTIVO NON PUO ESSERE NULL';
			return msg;
		END IF; 
	END IF;
	validatore_text := (select * from dbi_gestione_cu.text_null(_pianomonitoraggio));
	if(validatore_text = false)THEN 
		validatore_text := (select * from dbi_gestione_cu.text_null(_tipoispezione));
		if(validatore_text = false)THEN 
			msg := 'KO IL CAMPO MOTIVO NON PUO ESSERE NULL';
			return msg;
		END IF; 
	END IF;
	validatore_motivo := (select * from dbi_gestione_cu.motivo_is_valid(_tipoispezione, _assigned_date));
	if(validatore_motivo = false) THEN 
			msg := 'KO: TIPO ISPEZIONE NON VALIDA';
			return msg;
	END IF; 
	validatore_piano := (select * from dbi_gestione_cu.pianomonitoraggio_is_valid(_pianomonitoraggio, _assigned_date));
	if(validatore_piano = false)THEN 
		msg := ' KO PIANO NON VALIDO ';
		return msg;
	END IF;
END IF;

--Se il controllo è un ncp o una ispezione giornaliera carni o una sorveglianza aperta
if(_provvedimenti_prescrittivi = 2 OR _provvedimenti_prescrittivi = 26 OR _provvedimenti_prescrittivi = 5)THEN
	validatore_text := (select * from dbi_gestione_cu.text_null(_tipoispezione));
	if(validatore_text = false)THEN 
		msg := 'KO IL CAMPO PER CONTO DI NON PUO ESSERE NULL';
		return msg;
	END IF;
END IF;
	
--Se il controllo è un audit
if(_provvedimenti_prescrittivi = 3)THEN
	validatore_text := (select * from dbi_gestione_cu.text_null(_tipoispezione));
	if(validatore_text = false)THEN 
		msg := 'KO IL CAMPO MOTIVO NON PUO ESSERE NULL';
		return msg;
	END IF;
	validatore_motivo := (select * from dbi_gestione_cu.motivo_audit_is_valid(_tipoispezione, _assigned_date));
	if(validatore_motivo = false) THEN 
		msg := 'KO: MOTIVO NON VALIDO PER TECNICA AUDIT';
		return msg;
	END IF;
END IF; 

if(_provvedimenti_prescrittivi = 3)THEN
	check_hstore := (array_length(chiave_hstore, 1));
	if(check_hstore > 1)THEN
		msg := 'KO L''HSTORE ACCETTA NEL CASO DEL AUDIT UNA SOLA CHIAVE: ISPEZIONE';
		return msg; 
	END IF;	
	if(chiave_hstore[1] <> 'ispezione')THEN
		msg := 'KO L''HSTORE ACCETTA NEL CASO DEL AUDIT UNA SOLA CHIAVE: ISPEZIONE';
		return msg;
	END IF;
END IF;

if(_provvedimenti_prescrittivi = 4) THEN 
	check_hstore := (array_length(chiave_hstore, 1));
	raise info '% check hstore', check_hstore;
	if(check_hstore > 2)THEN
		msg := 'KO L''HSTORE ACCETTA NEL CASO DEL ISPEZIONE SEMPLICE SOLO DUE CHIAVI: ISPEZIONE E PIANO';
		return msg;
	END IF; 
	IF(chiave_hstore[1]<> 'ispezione' AND chiave_hstore[1] <> 'piano')THEN
		msg := 'KO L''HSTORE ACCETTA NEL CASO DEL ISPEZIONE SEMPLICE SOLO DUE CHIAVI: ISPEZIONE E PIANO';
		return msg;
	END IF;
	if(check_hstore = 2)THEN
		IF(chiave_hstore[2]<> 'ispezione' AND chiave_hstore[2] <> 'piano')THEN
			msg := 'KO L''HSTORE ACCETTA NEL CASO DEL ISPEZIONE SEMPLICE SOLO DUE CHIAVI: ISPEZIONE E PIANO';
			return msg;
		END IF;
	END IF;
END IF;

--Per l attivita giornaliera di ispezioni carni al macello e la sorveglianza aperta non è presente l oggetto del controllo
if(_provvedimenti_prescrittivi <> 26 AND _provvedimenti_prescrittivi <> 5 AND _ispezione <> '7')THEN 
	validatore_text := (select * from dbi_gestione_cu.text_null(_ispezione));
	if(validatore_text = false)THEN 
		msg := 'KO IL CAMPO OGGETTO SOTTOPOSTO AL CONTROLLO NON PUO ESSERE NULL';
		return msg;
	END IF;
END IF;
--Per l attivita giornaliera di ispezioni carni al macello e la sorveglianza aperta non è presente l oggetto del controllo
if(_provvedimenti_prescrittivi <> 26 AND _provvedimenti_prescrittivi <> 5)THEN
	validatore_oggetto := (select * from dbi_gestione_cu.oggetto_is_valid(_ispezione));
	if(validatore_oggetto = false) THEN 
		msg := 'KO: UNO O PIU'' OGGETTI DEL CONTROLLO SOTTOPOSTI AL CONTROLLO NON VALIDI';
		return msg;
	END IF;
END IF; 

validatore_text := (select * from dbi_gestione_cu.text_null(_id_componente));
if(validatore_text = false)THEN 
	msg := 'KO IL CAMPO NUCLEO ISPETTIVO NON PUO ESSERE NULL';
	return msg;
END IF;

--Se il controllo e un ispezione semplice da gisa ext controllo nelle tabelle di access ext
if(_provvedimenti_prescrittivi = 1)THEN
	validatore_nucleo := (select * from dbi_gestione_cu.nucleo_is_valid_ext(_id_componente));
	if(validatore_nucleo = false) THEN 
		msg := 'KO: NUCLEO ISPETTIVO NON VALIDO';
		return msg;
	END IF;
ELSE
	validatore_nucleo := (select * from dbi_gestione_cu.nucleo_is_valid(_id_componente, _assigned_date, _site_id));
	if(validatore_nucleo = false) THEN 
		msg := 'KO: NUCLEO ISPETTIVO NON VALIDO';
		return msg;
	END IF;
END IF;

--Se il controllo è una sorveglianza aperta non faccio nulla, se il controllo è un audit controllo solo che la linea non sia null poiche il controllo viene fatto nella insert audit, se il controllo non è un audit procedo a controllare anche la linea
if(_provvedimenti_prescrittivi <> 5)THEN
	if(_provvedimenti_prescrittivi <> 3)THEN
		validatore_integer := (select * from dbi_gestione_cu.integer_null(cast(_id_linea_attivita as integer)));
		if(validatore_integer = false)THEN 
			msg := 'KO IL CAMPO LINEA ATTIVITA NON PUO ESSERE NULL';
			return msg; 
		END IF;
		validatore_linea := (select * from dbi_gestione_cu.linea_attivita_is_valid(cast(_id_linea_attivita as integer), _riferimento_id_nome_tab, _id_stabilimento));
		if(validatore_linea = false)THEN					 
			msg := 'KO LINEA ATTIVITA SOTTOPOSTA A CONTROLLO';
			return msg;
		END IF;
	ELSE 
		validatore_text := (select * from dbi_gestione_cu.text_null(_id_linea_attivita));
		if(validatore_text = false)THEN 
			msg := 'KO IL CAMPO LINEA ATTIVITA NON PUO ESSERE NULL';
			return msg;
		END IF;
	END IF;
END IF;

return msg; 

END 
$$;
 �  DROP FUNCTION dbi_gestione_cu.verifica_campi_cu_insert(_assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _enteredby integer, _modifiedby integer, _tipoispezione text, _pianomonitoraggio text, _ispezione text, _entered date, _id_componente text, _id_linea_attivita text, _provvedimenti_prescrittivi integer, _riferimento_id_nome_tab text, chiave_hstore text[]);
       dbi_gestione_cu          postgres    false    26            �           1255    444449 �   verifica_campi_cu_update(integer, date, integer, date, integer, integer, text, text, text, date, text, text, integer, text, text[])    FUNCTION     K  CREATE FUNCTION dbi_gestione_cu.verifica_campi_cu_update(_ticketid integer, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _modifiedby integer, _tipoispezione text, _pianomonitoraggio text, _ispezione text, _entered date, _id_componente text, _id_linea_attivita text, _provvedimenti_prescrittivi integer, _riferimento_id_nome_tab text, chiavi_hstore text[]) RETURNS text
    LANGUAGE plpgsql
    AS $$

   DECLARE

msg text;
validatore_data_null boolean;
validatore_entered boolean;
validatore_data boolean;
validatore_oggetto boolean;
validatore_motivo boolean;
validatore_nucleo boolean;
validatore_piano boolean;
validatore_linea boolean;
i integer;
attivita_split text;
check_hstore integer;
validatore_integer boolean;

BEGIN 

msg := '';
raise info '%', chiavi_hstore;

--Se il controllo e un ncp la data puo essere precedente al anno attuale quindi viene usata una dbi esterna
if(_provvedimenti_prescrittivi = 2 AND _data_fine_controllo is not null AND _assigned_date is not null)THEN 
	validatore_data := (select * from dbi_gestione_cu.date_is_valid_ncp(_data_fine_controllo, _assigned_date, _entered));
	if(validatore_data = false) THEN 
		msg := 'KO: DATA FINE CONTROLLO INFERIORE ALLA DATA DI INIZIO DEL CONTROLLO OPPURE DATA INIZIO CONTROLLO MAGGIORE DELLA DATA ODIERNA.';
		return msg; 
	END IF;
ELSIF(_provvedimenti_prescrittivi <> 2 AND _data_fine_controllo is not null AND _assigned_date is not null)THEN
	validatore_data := (select * from dbi_gestione_cu.date_is_valid(_data_fine_controllo, _assigned_date, _entered));
	if(validatore_data = false) THEN 
		msg := 'KO: DATA FINE CONTROLLO INFERIORE ALLA DATA DI INIZIO DEL CONTROLLO OPPURE DATA INIZIO CONTROLLO MAGGIORE DELLA DATA ODIERNA.';
		return msg; 
	END IF;
END IF;

if(_assigned_date is null)THEN
	_assigned_date := (select assigned_date from ticket where ticketid = _ticketid);
END IF;

validatore_integer := (select * from dbi_gestione_cu.integer_null(_modifiedby));
if(validatore_integer = false)THEN 
	msg := 'KO IL CAMPO MODIFIEDBY NON PUO ESSERE NULL'; 
	return msg;
END IF;

--Se il controllo e un ispezione semplice da gisa ext controllo nelle tabelle di access ext
if(_provvedimenti_prescrittivi = 1)THEN 

	validatore_entered := (select * from dbi_gestione_cu.entered_ext_is_valid(_modifiedby));
	if(validatore_entered = false)THEN 
		msg := 'Modifica da utente non presente nella tabella access_ext';
		return msg;
	END IF;
ELSE 	

	validatore_entered := (select * from dbi_gestione_cu.entered_is_valid(_modifiedby));
	if(validatore_entered = false)THEN 
		msg := 'Modifica da utente non presente nella tabella access';
		return msg;
	END IF;
END IF;

--Se il controllo è un ispezione semplice 
if(_provvedimenti_prescrittivi = 4 AND (_tipoispezione is not null OR _pianomonitoraggio is not null))THEN
   if(_tipoispezione is not null)THEN
		validatore_motivo := (select * from dbi_gestione_cu.motivo_is_valid(_tipoispezione, _assigned_date));
		if(validatore_motivo = false) THEN 
			msg := 'KO: TIPO ISPEZIONE NON VALIDA';
			return msg;
		END IF; 
  END IF;
   if(_pianomonitoraggio is not null)THEN
		validatore_piano := (select * from dbi_gestione_cu.pianomonitoraggio_is_valid(_pianomonitoraggio, _assigned_date));
		if(validatore_piano = false)THEN 
			msg := ' KO PIANO NON VALIDO ';
			return msg;
		END IF;
   END IF;
END IF;

--Se il controllo è un audit
if(_provvedimenti_prescrittivi = 3 AND _tipoispezione is not null )THEN
	validatore_motivo := (select * from dbi_gestione_cu.motivo_audit_is_valid(_tipoispezione, _assigned_date));
	if(validatore_motivo = false) THEN 
		msg := 'KO: MOTIVO NON VALIDO PER TECNICA AUDIT';
		return msg;
	END IF;
END IF; 

if(_provvedimenti_prescrittivi = 3 AND _tipoispezione is not null)THEN
	check_hstore := (array_length(chiave_hstore, 1));
	if(check_hstore > 1)THEN
		msg := 'KO L''HSTORE ACCETTA NEL CASO DEL AUDIT UNA SOLA CHIAVE: ISPEZIONE';
		return msg; 
	END IF;	
	if(chiave_hstore[1] <> 'ispezione')THEN
		msg := 'KO L''HSTORE ACCETTA NEL CASO DEL AUDIT UNA SOLA CHIAVE: ISPEZIONE';
		return msg;
	END IF;
END IF;

if(_provvedimenti_prescrittivi = 4 AND _tipoispezione is not null) THEN 
	check_hstore := (array_length(chiave_hstore, 1));
	if(check_hstore > 2)THEN
		msg := 'KO L''HSTORE ACCETTA NEL CASO DEL ISPEZIONE SEMPLICE SOLO DUE CHIAVI: ISPEZIONE E PIANO';
		return msg;
	END IF; 
	IF(chiave_hstore[1]<> 'ispezione' AND chiave_hstore[1] <> 'piano')THEN
		msg := 'KO L''HSTORE ACCETTA NEL CASO DEL ISPEZIONE SEMPLICE SOLO DUE CHIAVI: ISPEZIONE E PIANO';
		return msg;
	END IF;
	
	if(check_hstore = 2)THEN
		IF(chiave_hstore[2]<> 'ispezione' AND chiave_hstore[2] <> 'piano')THEN
			msg := 'KO L''HSTORE ACCETTA NEL CASO DEL ISPEZIONE SEMPLICE SOLO DUE CHIAVI: ISPEZIONE E PIANO';
			return msg;
		END IF;
	END IF;
END IF;

--Per l attivita giornaliera di ispezioni carni al macello e la sorveglianza aperta non è presente l oggetto del controllo
if(_provvedimenti_prescrittivi <> 26 AND _provvedimenti_prescrittivi <> 5 AND _ispezione is not null)THEN
	validatore_oggetto := (select * from dbi_gestione_cu.oggetto_is_valid(_ispezione));
	if(validatore_oggetto = false) THEN 
		msg := 'KO: UNO O PIU'' OGGETTI DEL CONTROLLO SOTTOPOSTI AL CONTROLLO NON VALIDI';
		return msg;
	END IF;
END IF; 

--Se il controllo e un ispezione semplice da gisa ext controllo nelle tabelle di access ext
if(_provvedimenti_prescrittivi = 1 AND _id_componente is not null)THEN
	validatore_nucleo := (select * from dbi_gestione_cu.nucleo_is_valid_ext(_id_componente));
	if(validatore_nucleo = false) THEN 
		msg := 'KO: NUCLEO ISPETTIVO NON VALIDO';
		return msg;
	END IF;
ELSIF (_provvedimenti_prescrittivi <> 1 AND _id_componente is not null)THEN 
	validatore_nucleo := (select * from dbi_gestione_cu.nucleo_is_valid(_id_componente, _assigned_date, _site_id));
	if(validatore_nucleo = false) THEN 
		msg := 'KO: NUCLEO ISPETTIVO NON VALIDO';
		return msg;
	END IF;
END IF;

--Se il controllo è una sorveglianza aperta non faccio nulla, se il controllo è un audit controllo solo che la linea non sia null poiche il controllo viene fatto nella insert audit, se il controllo non è un audit procedo a controllare anche la linea
if(_provvedimenti_prescrittivi <> 5)THEN
	if(_provvedimenti_prescrittivi <> 3)THEN
		validatore_linea := (select * from dbi_gestione_cu.linea_attivita_is_valid(cast(_id_linea_attivita as integer), _riferimento_id_nome_tab, _id_stabilimento));
		if(validatore_linea = false)THEN					 
			msg := 'KO LINEA ATTIVITA SOTTOPOSTA A CONTROLLO';
			return msg;
		END IF;
	ELSE 
		i :=1;
		attivita_split := (select split_part(_id_linea_attivita, '-', i));
		if(attivita_split = '')THEN
			msg := 'KO LINEA ATTIVITA SOTTOPOSTA A CONTROLLO ';
			return msg;
		END IF;	
		while(attivita_split is not null AND attivita_split <> '') LOOP
			i := i+1;
			validatore_linea := (select * from dbi_gestione_cu.linea_attivita_is_valid(cast(attivita_split as integer), _riferimento_id_nome_tab, _id_stabilimento));
			if(validatore_linea = false)THEN
				msg := 'KO LINEA ATTIVITA SOTTOPOSTA A CONTROLLO ';
				return msg;
			END IF;
			attivita_split := (select split_part(_id_linea_attivita, '-', i));
		END LOOP;
	END IF;
END IF;

return msg; 

END 
$$;
 �  DROP FUNCTION dbi_gestione_cu.verifica_campi_cu_update(_ticketid integer, _assigned_date date, _site_id integer, _data_fine_controllo date, _id_stabilimento integer, _modifiedby integer, _tipoispezione text, _pianomonitoraggio text, _ispezione text, _entered date, _id_componente text, _id_linea_attivita text, _provvedimenti_prescrittivi integer, _riferimento_id_nome_tab text, chiavi_hstore text[]);
       dbi_gestione_cu          postgres    false    26            ]           1259    444385    helper_table    TABLE     �   CREATE TABLE dbi_gestione_cu.helper_table (
    id integer NOT NULL,
    insert text NOT NULL,
    update text NOT NULL,
    _provvedimenti_prescrittivi integer
);
 )   DROP TABLE dbi_gestione_cu.helper_table;
       dbi_gestione_cu         heap    postgres    false    26            U           1259    443422 	   log_table    TABLE     �   CREATE TABLE dbi_gestione_cu.log_table (
    id integer NOT NULL,
    id_controllo integer NOT NULL,
    pre_controllo json NOT NULL,
    post_controllo json,
    data_modifica date
);
 &   DROP TABLE dbi_gestione_cu.log_table;
       dbi_gestione_cu         heap    postgres    false    26            T           1259    443421    log_table_id_seq    SEQUENCE     �   CREATE SEQUENCE dbi_gestione_cu.log_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE dbi_gestione_cu.log_table_id_seq;
       dbi_gestione_cu          postgres    false    26    3157            ]0           0    0    log_table_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE dbi_gestione_cu.log_table_id_seq OWNED BY dbi_gestione_cu.log_table.id;
          dbi_gestione_cu          postgres    false    3156            H.           2604    443425    log_table id    DEFAULT     ~   ALTER TABLE ONLY dbi_gestione_cu.log_table ALTER COLUMN id SET DEFAULT nextval('dbi_gestione_cu.log_table_id_seq'::regclass);
 D   ALTER TABLE dbi_gestione_cu.log_table ALTER COLUMN id DROP DEFAULT;
       dbi_gestione_cu          postgres    false    3157    3156    3157            V0          0    444385    helper_table 
   TABLE DATA           `   COPY dbi_gestione_cu.helper_table (id, insert, update, _provvedimenti_prescrittivi) FROM stdin;
    dbi_gestione_cu          postgres    false    3165   ��      U0          0    443422 	   log_table 
   TABLE DATA           l   COPY dbi_gestione_cu.log_table (id, id_controllo, pre_controllo, post_controllo, data_modifica) FROM stdin;
    dbi_gestione_cu          postgres    false    3157   {�      ^0           0    0    log_table_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('dbi_gestione_cu.log_table_id_seq', 7, true);
          dbi_gestione_cu          postgres    false    3156            L.           2606    444391    helper_table helper_table_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY dbi_gestione_cu.helper_table
    ADD CONSTRAINT helper_table_pkey PRIMARY KEY (id);
 Q   ALTER TABLE ONLY dbi_gestione_cu.helper_table DROP CONSTRAINT helper_table_pkey;
       dbi_gestione_cu            postgres    false    3165            J.           2606    443429    log_table log_table_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY dbi_gestione_cu.log_table
    ADD CONSTRAINT log_table_pkey PRIMARY KEY (id);
 K   ALTER TABLE ONLY dbi_gestione_cu.log_table DROP CONSTRAINT log_table_pkey;
       dbi_gestione_cu            postgres    false    3157            V0   m  x��W�nG<�_����AJ�l���!�\l�
Z�M��ٙ�<��_��ȏ�fv�%)�M���J�D�����j�w�^1REzE+����v-!��r[��A|ħ[�|*��4��J~��7��7Uܴ���BQ����eTsdR�ؕ*g�w�8Z9�pt���p�4�uM�3q����5q0��OJ[FY�[]`Wj��@�"ߩ�Flt'�c�x����(�������Q�T�+��&�E~j��� W�J�3 ����A�mu/����s�8�'�*�!�6��&�ߓP�!��2~�Febى�˘��ծ�� X��U�p�$�P� ��!��=G��r��~�xA���_b�|�>_�}~="/�~��غq���^C��ds�%3'D	!/���5W�+fT:c�zn[/�0hr����;HU�:jJh��G���F<�����?Jbr��m��?�H��"#�E���}@'�I\Ux�п��(�)�&��ɕ0��g��--�����!Q��Z�.i�s��ʱ��y.�E�x�J6Z� ���|���aep'a<ac��[ RH]��Y��g�Wʎ�u�1Ř|> ����.�]�_�t�hL>�G٣��/G�3�b`�PQ��=���Gz��]!9����J6C��o,�+�#��[y��(u(����(�N\A36���������t��t^+>�<��gK=9O��ί�m��K�]���ӷ͇,�G��}���7LN)�;��,Sh���������}׭���&�	M�����կF�Y ��I^��]�|��Tk�.�E�y�x��}�m���/���3��d��f���[*�J�A�u��y���M��N9��§��t9�.� Ӌ�����o���g7���3`�	�      U0   q  x���K�0���_z^�%M�t7q�^<9q�#P��e���&���j�:B)�{���{�k� s�����ƪx�b�V6�x,��T�Y�S٥)K��H�@����c�}�+է�z�P֚�*��;>D�ܻ��Z��k/��������c����LV�{�~j�@}��y��^�V:]@��MH��iz��*$*4��U��Kp���/�^�g�m���t�n� ���~qH��o�Q�e�������Y��+��ڇ��������	8Y�i�-�؁���v�,�.y	�#���/G�s<3�؜,O�<*�i�0 ����?S�I��v��[��I��j��9�(qX�����,�=���2��,��W��W[     