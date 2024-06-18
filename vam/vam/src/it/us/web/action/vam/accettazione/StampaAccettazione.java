package it.us.web.action.vam.accettazione;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashSet;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.SuperUtenteAll;
import it.us.web.bean.remoteBean.Cane;
import it.us.web.bean.remoteBean.Gatto;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.lookup.LookupAsl;
import it.us.web.bean.vam.lookup.LookupMantelli;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.bean.vam.lookup.LookupRazze;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.constants.IdRichiesteVarie;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.vam.AccettazioneDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;
import it.us.web.util.vam.RegistrazioniUtil;

import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;


public class StampaAccettazione extends GenericAction  implements Specie
{

	@Override
	public void can() throws AuthorizationException
	{
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	@Override
	public void execute() throws Exception
	{
		Context ctxBdu = new InitialContext();
		javax.sql.DataSource dsBdu = (javax.sql.DataSource)ctxBdu.lookup("java:comp/env/jdbc/bduS");
		Connection connectionBdu = dsBdu.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connectionBdu);
		
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup("java:comp/env/jdbc/vamM");
		connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		
		Accettazione accettazione = AccettazioneDAO.getAccettazione(interoFromRequest( "id" ), connection); 
		req.setAttribute("Accettazione", accettazione);
		req.setAttribute( "idOpsBdr", 		IdOperazioniBdr.getInstance() );
		req.setAttribute( "idRichiesteVarie", IdRichiesteVarie.getInstance() );
		
		HashSet<SuperUtenteAll> personaleAslSelezionato = AccettazioneDAO.getPersonaleAsl(interoFromRequest( "id" ), connection);
		req.setAttribute("personaleAslSelezionato", personaleAslSelezionato);
		
		//Se il cane non � morto senza mc bisogna leggere in bdr le info sulla morte e stato attuale
		ServicesStatus status = new ServicesStatus();
		int specie = accettazione.getAnimale().getLookupSpecie().getId();
		Gatto gatto = null;
		Cane cane = null;
		if(!accettazione.getAnimale().getDecedutoNonAnagrafe())
		{
			if (specie == CANE ) 
			{
				cane = CaninaRemoteUtil.findCane(accettazione.getAnimale().getIdentificativo(), utente, status, connectionBdu, req);
				RegistrazioniCaninaResponse res	= AnimaliUtil.fetchDatiDecessoCane(cane);
				req.setAttribute("res", res);
			}
			else if (specie == GATTO) 
			{
				gatto = FelinaRemoteUtil.findGatto(accettazione.getAnimale().getIdentificativo(), utente, status, connectionBdu, req);
				RegistrazioniFelinaResponse rfr	= AnimaliUtil.fetchDatiDecessoGatto(gatto);
				req.setAttribute("res", rfr);
			}
			else if (specie == SINANTROPO) 
			{
				RegistrazioniSinantropiResponse rsr = SinantropoUtil.getInfoDecesso(persistence, accettazione.getAnimale());
				req.setAttribute("res", rsr);
				req.setAttribute("fuoriAsl", false);
				req.setAttribute("versoAssocCanili", false);
			}
			
			if(specie==CANE || specie==GATTO)
				RegistrazioniUtil.sincronizzaDaBdu(accettazione, null, persistence, connectionBdu, utente, false, req, connection);
		}
		req.setAttribute( "idOpsBdr", 		IdOperazioniBdr.getInstance() );
		req.setAttribute( "idRichiesteVarie", IdRichiesteVarie.getInstance() );
		req.setAttribute( "accettazione", accettazione );
		req.setAttribute( "specie", SpecieAnimali.getInstance() );
		
		req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(accettazione.getAnimale(), cane, gatto, persistence, utente, status, connectionBdu, req));
		gotoPage( "popup", "/jsp/vam/accettazione/stampaAccettazione.jsp" );
	} 

}
