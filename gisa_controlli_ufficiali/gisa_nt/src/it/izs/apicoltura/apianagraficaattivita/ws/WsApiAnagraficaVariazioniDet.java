package it.izs.apicoltura.apianagraficaattivita.ws;

import it.izs.bdn.anagrafica.ws.WsApiAnagraficaPersoneBdn;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.GregorianCalendar;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.apache.log4j.Logger;
import org.aspcfs.modules.util.imports.ApplicationProperties;

import com.sun.xml.internal.ws.fault.ServerSOAPFaultException;

import ext.aspcfs.modules.apiari.base.Stabilimento;
import ext.aspcfs.modules.apiari.base.WSBdnLog;

public class WsApiAnagraficaVariazioniDet {
	
	  private final static Logger log = Logger.getLogger(it.izs.apicoltura.apianagraficaattivita.ws.WsApiAnagraficaVariazioniDet.class);

	ApistodetEndpoint endPointAnagraficaDet = null ;
	SOAPAutenticazioneWS autenticazione = null ;
	
	public WsApiAnagraficaVariazioniDet()
	{
		
		ApistodetEndpointService service = new ApistodetEndpointService();
		endPointAnagraficaDet = service.getApistodetEndpointPort();
		autenticazione = new SOAPAutenticazioneWS();
		autenticazione.setUsername(ApplicationProperties.getProperty("USERNAME_BDAPI"));
		autenticazione.setPassword(ApplicationProperties.getProperty("PASSWORD_BDAPI"));
		autenticazione.setRuoloCodice(ApplicationProperties.getProperty("RUOLO_CODICE_BDAPI"));
		autenticazione.setRuoloValoreCodice(ApplicationProperties.getProperty("RUOLO_VALORE_BDAPI"));
		
	}
	
	public void insertApiAnagraficaDetentore(Stabilimento attivitaApicoltura,Connection db,int idUtente) throws it.izs.bdn.anagrafica.ws.BusinessWsException_Exception, SQLException
	{
		log.info("##WS.API.ANAGRAFICA.VARIAZIONE.DETENTORE## CHIAMATO SERVIZIO");

		WSBdnLog logWS = new WSBdnLog();
		logWS.setIdUtente(idUtente);
		logWS.setIdOggetto(attivitaApicoltura.getIdStabilimento());
		logWS.setNomeTabella("apicoltura_apiari");
		logWS.setTipoOperazione(WSBdnLog.TYPE_WS_INSERT_VAR_DET);
		logWS.setIdVariazione(attivitaApicoltura.getIdVariazioneEseguita());
		logWS.setTabellaVariazione("apicoltura_apiari_variazioni_detentore");
		
		
			Apistodet variazioneDetentore = new Apistodet();
				
			
			WsApiAnagraficaPersoneBdn wsPersone = new WsApiAnagraficaPersoneBdn();
			if (wsPersone.searchPersone(attivitaApicoltura.getDetentore(),db,idUtente)==null)
			{
				wsPersone.insertAnagraficaPersona(attivitaApicoltura.getDetentore(),db,idUtente);
				
			}
			variazioneDetentore.setDetenIdFiscale(attivitaApicoltura.getDetentore().getCodFiscale());
			variazioneDetentore.setApiApiattAziendaCodice(attivitaApicoltura.getOperatore().getCodiceAzienda());
			variazioneDetentore.setApiProgressivo(Integer.parseInt(attivitaApicoltura.getProgressivoBDA()));
	
			GregorianCalendar c = new GregorianCalendar();
			c.setTime(attivitaApicoltura.getData_assegnazione_detentore());
			XMLGregorianCalendar dtApertura=null;
			try {
				
				dtApertura = DatatypeFactory.newInstance().newXMLGregorianCalendar(c);
			} catch (DatatypeConfigurationException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			variazioneDetentore.setDtAssegnazione(dtApertura);


			InsertStoricoDetentore storicoDet = new InsertStoricoDetentore();
			storicoDet.setStoricoDetentoreTO(variazioneDetentore);
			
			logWS.setParametri(variazioneDetentore);

			try {
				logWS.setDataInvio(new Timestamp(System.currentTimeMillis()));

				InsertStoricoDetentoreResponse response =  endPointAnagraficaDet.insertStoricoDetentore(storicoDet, autenticazione);
				Apistodet risposta =  response.getStoricoDetentoreTO();
				logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
				logWS.setEsito("OK");
				logWS.insertBdnLogWs();
				log.info("##WS.API.ANAGRAFICA.VARIAZIONE.DETENTORE## CHIAMATO SERVIZIO OK");

			} catch (BusinessWsException_Exception e) {
				
				log.info("##WS.API.ANAGRAFICA.VARIAZIONE.DETENTORE## CHIAMATO SERVIZIO KO");
				logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
				logWS.setEsito("KO");

				String errore ="";
				if (e instanceof BusinessWsException_Exception)
				{
					BusinessWsException_Exception ee = (BusinessWsException_Exception)e;
				 errore = ee.getFaultInfo().getMessage()+" : "+ee.getFaultInfo().getResult().getErrore();
				
				for (FieldError error : ee.getFaultInfo().getResult().getErrors())
				{
					errore +="["+error.getField()+": "+error.getMessage()+ "]" ;
		
				}
				}
				
				logWS.setNoteEsito(errore);
				
				logWS.insertBdnLogWs();
			}
			catch (ServerSOAPFaultException e) {
				// TODO Auto-generated catch block
				logWS.setDataRisposta(new Timestamp(System.currentTimeMillis()));
				logWS.setEsito("KO");
				logWS.setNoteEsito("ERRORE ServerSOAPFaultException: "+e.getMessage());
				logWS.insertBdnLogWs();
				
				log.info("ServerSOAPFaultException: ##WS.API.ANAGRAFICA.VARIAZIONE.CENSIMENTO## CHIAMATO SERVIZIO KO");

			
				
			}


		
		
	}

}
