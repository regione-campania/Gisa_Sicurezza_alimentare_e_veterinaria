-- da lanciare su guc ufficiale
select * from guc_endpoint_connector_config where id_endpoint = 3 and id_operazione = 2 and enabled
select  *  from guc_endpoint_connector_config where id_endpoint = 2 and id_operazione = 2 and enabled

-- versioni corrette
select * from dbi_insert_utente_ext(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);--28 per gisa ext ok
select * from dbi_insert_utente(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);--20 guc ok

update guc_endpoint_connector_config set sql='select * from dbi_insert_utente_ext(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);' where id_endpoint = 3 and id_operazione = 2 and enabled
