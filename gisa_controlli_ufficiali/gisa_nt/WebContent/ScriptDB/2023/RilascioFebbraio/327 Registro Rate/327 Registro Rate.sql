

CREATE OR REPLACE FUNCTION public.get_registro_trasgressori_importo_effettivamente_introitato_2(
	_id_sanzione integer)
    RETURNS double precision
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
   DECLARE
tot double precision;
 
BEGIN

tot := 0;

SELECT
SUM(importo_singolo_versamento::double precision) into tot
FROM
pagopa_pagamenti
where id_sanzione = _id_sanzione and tipo_pagamento = 'NO' and stato_pagamento = 'PAGAMENTO COMPLETATO';
	
	RETURN tot;
END
$BODY$;




-- View: public.registro_trasgressori_vista

DROP VIEW public.registro_trasgressori_vista;

CREATE OR REPLACE VIEW public.registro_trasgressori_vista AS 
 SELECT controllo.ticketid AS idcontrollo,
    date_part('year'::text, controllo.assigned_date) AS anno_controllo,
    t.ticketid AS idsanzione,
    asl.description AS asl,
        CASE
            WHEN nucleo.in_dpat THEN 'ASL '::text || asl.description::text
            ELSE nucleo.description::text
        END AS ente1,
        CASE
            WHEN nucleo2.in_dpat THEN 'ASL '::text || asl.description::text
            ELSE nucleo2.description::text
        END AS ente2,
        CASE
            WHEN nucleo3.in_dpat THEN 'ASL '::text || asl.description::text
            ELSE nucleo3.description::text
        END AS ente3,
    t.tipo_richiesta AS numeroverbale,
    t.verbale_sequestro AS numeroverbalesequestri,
        CASE
            WHEN t.pagamento_ultraridotto > 0::double precision THEN 'SI '::text || t.pagamento_ultraridotto
            ELSE 'NO'::text
        END AS importosanzioneultraridotta,
    controllo.assigned_date AS dataaccertamento,
    t.trasgressore,
    t.obbligatoinsolido AS obbligato,
    t.pagamento::text AS importosanzioneridotta,
    rt.id,
    rt.id_sanzione,
    rt.id_controllo_ufficiale,
    rt.anno,
    rt.data_prot_entrata,
    rt.pv_oblato_ridotta,
    rt.fi_assegnatario,
    rt.presentati_scritti,
    rt.presentata_richiesta_riduzione,
    rt.presentata_richiesta_audizione,
    rt.ordinanza_emessa,
    rt.importo_sanzione_ingiunta,
    rt.data_emissione,
    rt.giorni_lavorazione,
    rt.ordinanza_ingiunzione_oblata,
    rt.sentenza_favorevole,
    rt.importo_stabilito,
    rt.ordinanza_ingiunzione_sentenza,
    rt.iscrizione_ruoli_sattoriali,
    rt.note1,
    rt.note2,
    rt.data_inserimento,
    rt.data_modifica,
    rt.id_utente_modifica,
    rt.presentata_opposizione,
    rt.trashed_date,
    rt.richiesta_rateizzazione,
    rt.rata1,
    rt.rata2,
    rt.rata3,
    rt.rata4,
    rt.rata5,
    rt.rata6,
    rt.rata7,
    rt.rata8,
    rt.rata9,
    rt.rata10,
    string_agg(DISTINCT concat(sa_rt.header_allegato, '#', sa_rt.oggetto, '#', sa_rt.nome_client), ';'::text) AS allegato_rt,
    rt.importo_effettivamente_versato1,
 case when count(pagopa_no.id) >0 then 
(select * from get_registro_trasgressori_importo_effettivamente_introitato_2(t.ticketid))
else rt.importo_effettivamente_versato2  
    end as importo_effettivamente_versato2,
    rt.importo_effettivamente_versato3,
    rt.importo_effettivamente_versato4,
    rt.competenza_regionale,
    rt.pratica_chiusa,
    rt.data_ultima_notifica,
    rt.data_pagamento,
    rt.pagamento_ridotto_consentito,
    rt.data_ultima_notifica_ordinanza,
    rt.data_pagamento_ordinanza,
    rt.pagamento_ridotto_consentito_ordinanza,
        CASE
            WHEN rt.id IS NOT NULL THEN true
            ELSE false
        END AS esistente,
    rt.progressivo,
    rt.num_ordinanza,
    string_agg(DISTINCT concat(sa_pv.header_allegato, '#', sa_pv.oggetto, '#', sa_pv.nome_client), ';'::text) AS allegato_pv,
    string_agg(DISTINCT concat(sa_al.header_allegato, '#', sa_al.oggetto, '#', sa_al.nome_client), ';'::text) AS allegato_al,
    string_agg(DISTINCT concat_ws('#'::text, pagopa_pv.identificativo_univoco_versamento, pagopa_pv.url_file_avviso, pagopa_pv.stato_pagamento), '##'::text) AS pagopa_pv_iuv,
    string_agg(DISTINCT concat_ws('#'::text, pagopa_no.identificativo_univoco_versamento, pagopa_no.url_file_avviso, pagopa_no.stato_pagamento), '##'::text) AS pagopa_no_iuv,
        CASE
            WHEN rt.forzato THEN rt.forzato_pv_oblato_r
            ELSE pagopa_pv_r."check"
        END AS pagopa_pv_oblato_ridotta,
        CASE
            WHEN rt.forzato THEN rt.forzato_pv_oblato_ur
            ELSE pagopa_pv_ur."check"
        END AS pagopa_pv_oblato_ultraridotta,
        CASE
            WHEN rt.forzato THEN rt.forzato_pv_data_pagamento
            ELSE COALESCE(pagopa_pv_r.data_esito_singolo_pagamento, pagopa_pv_ur.data_esito_singolo_pagamento)::timestamp without time zone
        END AS pagopa_pv_data_pagamento,
    string_agg(DISTINCT concat(
        CASE
            WHEN pagopa_no_1.id IS NOT NULL THEN 'PRIMA RATA; '::text
            ELSE ''::text
        END,
        CASE
            WHEN pagopa_no_2.id IS NOT NULL THEN 'SECONDA RATA; '::text
            ELSE ''::text
        END,
        CASE
            WHEN pagopa_no_3.id IS NOT NULL THEN 'TERZA RATA; '::text
            ELSE ''::text
        END,
        CASE
            WHEN pagopa_no_4.id IS NOT NULL THEN 'QUARTA RATA; '::text
            ELSE ''::text
        END,
        CASE
            WHEN pagopa_no_5.id IS NOT NULL THEN 'QUINTA RATA; '::text
            ELSE ''::text
        END,
        CASE
            WHEN pagopa_no_6.id IS NOT NULL THEN 'SESTA RATA; '::text
            ELSE ''::text
        END,
        CASE
            WHEN pagopa_no_7.id IS NOT NULL THEN 'SETTIMA RATA; '::text
            ELSE ''::text
        END,
        CASE
            WHEN pagopa_no_8.id IS NOT NULL THEN 'OTTAVA RATA; '::text
            ELSE ''::text
        END,
        CASE
            WHEN pagopa_no_9.id IS NOT NULL THEN 'NONA RATA; '::text
            ELSE ''::text
        END,
        CASE
            WHEN pagopa_no_10.id IS NOT NULL THEN 'DECIMA RATA; '::text
            ELSE ''::text
        END), ''::text) AS pagopa_no_rate_pagate,
        case when count(pagopa_pv.id)>0 then 'PV' when count(pagopa_no.id) is not null then 'NO' else '' end as pagopa_tipo,
           case when string_agg(distinct pagopa_no.stato_pagamento, ',') ='PAGAMENTO COMPLETATO' then true else false end as pagopa_no_tutte_rate_pagate
   FROM ticket t
     JOIN ticket controllo ON controllo.tipologia = 3 AND t.id_controllo_ufficiale::text = controllo.id_controllo_ufficiale::text
     LEFT JOIN nucleo_ispettivo_mv mv_nucleo ON mv_nucleo.id_controllo_ufficiale = controllo.ticketid
     LEFT JOIN lookup_qualifiche nucleo ON nucleo.description::text = mv_nucleo.nucleo_ispettivo::text
     LEFT JOIN lookup_qualifiche nucleo2 ON nucleo2.description::text = mv_nucleo.nucleo_ispettivo_due::text
     LEFT JOIN lookup_qualifiche nucleo3 ON nucleo3.description::text = mv_nucleo.nucleo_ispettivo_tre::text
     LEFT JOIN lookup_site_id asl ON asl.code = controllo.site_id
     LEFT JOIN sanzioni_allegati sa_pv ON sa_pv.id_sanzione = t.ticketid AND sa_pv.tipo_allegato = 'SanzionePV'::text AND sa_pv.trashed_date IS NULL
     LEFT JOIN sanzioni_allegati sa_al ON sa_al.id_sanzione = t.ticketid AND sa_al.tipo_allegato = 'SanzioneAL'::text AND sa_al.trashed_date IS NULL
     LEFT JOIN sanzioni_allegati sa_rt ON sa_rt.id_sanzione = t.ticketid AND sa_rt.tipo_allegato = 'RegistroTrasgressori'::text AND sa_rt.trashed_date IS NULL
     LEFT JOIN registro_trasgressori_values rt ON t.ticketid = rt.id_sanzione
     LEFT JOIN pagopa_pagamenti pagopa_pv ON pagopa_pv.id_sanzione = t.ticketid AND pagopa_pv.trashed_date IS NULL AND pagopa_pv.tipo_pagamento = 'PV'::text
     LEFT JOIN pagopa_pagamenti pagopa_no ON pagopa_no.id_sanzione = t.ticketid AND pagopa_no.trashed_date IS NULL AND pagopa_no.tipo_pagamento = 'NO'::text
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id,
            pagopa_pagamenti.data_esito_singolo_pagamento,
            true AS "check"
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'PV'::text AND pagopa_pagamenti.tipo_riduzione = 'R'::text AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_pv_r ON pagopa_pv_r.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id,
            pagopa_pagamenti.data_esito_singolo_pagamento,
            true AS "check"
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'PV'::text AND pagopa_pagamenti.tipo_riduzione = 'U'::text AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_pv_ur ON pagopa_pv_ur.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 1 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_1 ON pagopa_no_1.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 2 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_2 ON pagopa_no_2.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 3 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_3 ON pagopa_no_3.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 4 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_4 ON pagopa_no_4.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 5 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_5 ON pagopa_no_5.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 6 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_6 ON pagopa_no_6.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 7 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_7 ON pagopa_no_7.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 8 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_8 ON pagopa_no_8.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 9 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_9 ON pagopa_no_9.id_sanzione = t.ticketid
     LEFT JOIN ( SELECT DISTINCT ON (pagopa_pagamenti.id_sanzione) pagopa_pagamenti.id_sanzione,
            pagopa_pagamenti.id
           FROM pagopa_pagamenti
          WHERE pagopa_pagamenti.trashed_date IS NULL AND pagopa_pagamenti.tipo_pagamento = 'NO'::text AND pagopa_pagamenti.indice = 10 AND pagopa_pagamenti.stato_pagamento = 'PAGAMENTO COMPLETATO'::text) pagopa_no_10 ON pagopa_no_10.id_sanzione = t.ticketid
  WHERE t.trashed_date IS NULL AND t.tipologia = 1 AND controllo.trashed_date IS NULL AND controllo.assigned_date >= '2015-03-01 00:00:00'::timestamp without time zone AND controllo.status_id <> 1 AND t.id_nonconformita > 0
  GROUP BY controllo.ticketid, t.ticketid, asl.description, nucleo.in_dpat, nucleo.description, nucleo2.in_dpat, nucleo2.description, nucleo3.in_dpat, nucleo3.description, rt.id, rt.id_sanzione, rt.id_controllo_ufficiale, rt.anno, rt.data_prot_entrata, rt.pv_oblato_ridotta, rt.fi_assegnatario, rt.presentati_scritti, rt.presentata_richiesta_riduzione, rt.presentata_richiesta_audizione, rt.ordinanza_emessa, rt.importo_sanzione_ingiunta, rt.data_emissione, rt.giorni_lavorazione, rt.ordinanza_ingiunzione_oblata, rt.sentenza_favorevole, rt.importo_stabilito, rt.ordinanza_ingiunzione_sentenza, rt.iscrizione_ruoli_sattoriali, rt.note1, rt.note2, rt.data_inserimento, rt.data_modifica, rt.id_utente_modifica, rt.presentata_opposizione, rt.trashed_date, rt.richiesta_rateizzazione, rt.rata1, rt.rata2, rt.rata3, rt.rata4, rt.rata5, rt.rata6, rt.rata7, rt.rata8, rt.rata9, rt.rata10, rt.allegato_documentale, rt.importo_effettivamente_versato1, rt.importo_effettivamente_versato2, rt.importo_effettivamente_versato3, rt.importo_effettivamente_versato4, rt.competenza_regionale, rt.pratica_chiusa, rt.data_ultima_notifica, rt.data_pagamento, rt.pagamento_ridotto_consentito, rt.data_ultima_notifica_ordinanza, rt.data_pagamento_ordinanza, rt.pagamento_ridotto_consentito_ordinanza, pagopa_pv_r."check", pagopa_pv_ur."check", pagopa_pv_r.data_esito_singolo_pagamento, pagopa_pv_ur.data_esito_singolo_pagamento
UNION
 SELECT NULL::integer AS idcontrollo,
    date_part('year'::text, t.assigned_date) AS anno_controllo,
    t.ticketid AS idsanzione,
    asl.description AS asl,
    ''::text AS ente1,
    ''::text AS ente2,
    ''::text AS ente3,
    t.tipo_richiesta AS numeroverbale,
    t.verbale_sequestro AS numeroverbalesequestri,
        CASE
            WHEN t.pagamento_ultraridotto > 0::double precision THEN 'SI '::text || t.pagamento_ultraridotto
            ELSE 'NO'::text
        END AS importosanzioneultraridotta,
    t.assigned_date AS dataaccertamento,
    t.trasgressore,
    t.obbligatoinsolido AS obbligato,
    t.pagamento::text AS importosanzioneridotta,
    rt.id,
    rt.id_sanzione,
    rt.id_controllo_ufficiale,
    rt.anno,
    rt.data_prot_entrata,
    rt.pv_oblato_ridotta,
    rt.fi_assegnatario,
    rt.presentati_scritti,
    rt.presentata_richiesta_riduzione,
    rt.presentata_richiesta_audizione,
    rt.ordinanza_emessa,
    rt.importo_sanzione_ingiunta,
    rt.data_emissione,
    rt.giorni_lavorazione,
    rt.ordinanza_ingiunzione_oblata,
    rt.sentenza_favorevole,
    rt.importo_stabilito,
    rt.ordinanza_ingiunzione_sentenza,
    rt.iscrizione_ruoli_sattoriali,
    rt.note1,
    rt.note2,
    rt.data_inserimento,
    rt.data_modifica,
    rt.id_utente_modifica,
    rt.presentata_opposizione,
    rt.trashed_date,
    rt.richiesta_rateizzazione,
    rt.rata1,
    rt.rata2,
    rt.rata3,
    rt.rata4,
    rt.rata5,
    rt.rata6,
    rt.rata7,
    rt.rata8,
    rt.rata9,
    rt.rata10,
    string_agg(DISTINCT concat(sa_rt.header_allegato, '#', sa_rt.oggetto, '#', sa_rt.nome_client), ';'::text) AS allegato_rt,
    rt.importo_effettivamente_versato1,
    rt.importo_effettivamente_versato2,
    rt.importo_effettivamente_versato3,
    rt.importo_effettivamente_versato4,
    rt.competenza_regionale,
    rt.pratica_chiusa,
    rt.data_ultima_notifica,
    rt.data_pagamento,
    rt.pagamento_ridotto_consentito,
    rt.data_ultima_notifica_ordinanza,
    rt.data_pagamento_ordinanza,
    rt.pagamento_ridotto_consentito_ordinanza,
        CASE
            WHEN rt.id IS NOT NULL THEN true
            ELSE false
        END AS esistente,
    rt.progressivo,
    rt.num_ordinanza,
    ''::text AS allegato_pv,
    ''::text AS allegato_al,
    ''::text AS pagopa_pv_iuv,
    ''::text AS pagopa_no_iuv,
    NULL::boolean AS pagopa_pv_oblato_ridotta,
    NULL::boolean AS pagopa_pv_oblato_ultraridotta,
    NULL::timestamp without time zone AS pagopa_pv_data_pagamento,
    ''::text AS pagopa_no_rate_pagate,
    ''::text AS pagopa_tipo,
    false as pagopa_no_tutte_rate_pagate
   FROM ticket t
     LEFT JOIN lookup_site_id asl ON asl.code = t.site_id
     LEFT JOIN sanzioni_allegati sa_rt ON sa_rt.id_sanzione = t.ticketid AND sa_rt.tipo_allegato = 'RegistroTrasgressori'::text AND sa_rt.trashed_date IS NULL
     LEFT JOIN registro_trasgressori_values rt ON t.ticketid = rt.id_sanzione
  WHERE t.trashed_date IS NULL AND t.tipologia = 1 AND t.assigned_date >= '2015-03-01 00:00:00'::timestamp without time zone AND t.note_internal_use_only ~~* '%RECORD GENERATO AUTOMATICAMENTE PER INSERIMENTO SANZIONE FORZATA NEL REGISTRO TRASGRESSORI%'::text
  GROUP BY t.ticketid, asl.description, rt.id, rt.id_sanzione, rt.id_controllo_ufficiale, rt.anno, rt.data_prot_entrata, rt.pv_oblato_ridotta, rt.fi_assegnatario, rt.presentati_scritti, rt.presentata_richiesta_riduzione, rt.presentata_richiesta_audizione, rt.ordinanza_emessa, rt.importo_sanzione_ingiunta, rt.data_emissione, rt.giorni_lavorazione, rt.ordinanza_ingiunzione_oblata, rt.sentenza_favorevole, rt.importo_stabilito, rt.ordinanza_ingiunzione_sentenza, rt.iscrizione_ruoli_sattoriali, rt.note1, rt.note2, rt.data_inserimento, rt.data_modifica, rt.id_utente_modifica, rt.presentata_opposizione, rt.trashed_date, rt.richiesta_rateizzazione, rt.rata1, rt.rata2, rt.rata3, rt.rata4, rt.rata5, rt.rata6, rt.rata7, rt.rata8, rt.rata9, rt.rata10, rt.allegato_documentale, rt.importo_effettivamente_versato1, rt.importo_effettivamente_versato2, rt.importo_effettivamente_versato3, rt.importo_effettivamente_versato4, rt.competenza_regionale, rt.pratica_chiusa, rt.data_ultima_notifica, rt.data_pagamento, rt.pagamento_ridotto_consentito, rt.data_ultima_notifica_ordinanza, rt.data_pagamento_ordinanza, rt.pagamento_ridotto_consentito_ordinanza;

ALTER TABLE public.registro_trasgressori_vista
  OWNER TO postgres;
