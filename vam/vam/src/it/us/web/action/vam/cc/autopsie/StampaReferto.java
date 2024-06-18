package it.us.web.action.vam.cc.autopsie;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.AnimaleAnagrafica;
import it.us.web.bean.vam.Autopsia;
import it.us.web.bean.vam.AutopsiaOrganoPatologie;
import it.us.web.bean.vam.Diagnosi;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.TerapiaDegenza;
import it.us.web.bean.vam.Trasferimento;
import it.us.web.bean.vam.lookup.LookupAutopsiaEsitiEsami;
import it.us.web.bean.vam.lookup.LookupAutopsiaFenomeniCadaverici;
import it.us.web.bean.vam.lookup.LookupAutopsiaOrgani;
import it.us.web.bean.vam.lookup.LookupAutopsiaOrganiTipiEsamiEsiti;
import it.us.web.bean.vam.lookup.LookupAutopsiaTipiEsami;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.constants.IdRichiesteVarie;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class StampaReferto extends GenericAction {
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("cc");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		//Se idCartellaClinica vuol dire che � gi� in sessione	
		int id = interoFromRequest("id");
		
		if(id>0)
			session.setAttribute("id", id);		
		
		Autopsia autopsia = (Autopsia) persistence.find (Autopsia.class, interoFromRequest("id") );	
		req.setAttribute( "a",autopsia);
		Animale animale = autopsia.getCartellaClinica().getAccettazione().getAnimale();
		AnimaleAnagrafica animaleAnagrafica = AnimaliUtil.getAnagrafica(animale, persistence, utente, new ServicesStatus(), connection, req );
		
		ArrayList<LookupAutopsiaFenomeniCadaverici> listFenomeniCadaverici = (ArrayList<LookupAutopsiaFenomeniCadaverici>) persistence.createCriteria( LookupAutopsiaFenomeniCadaverici.class )
				.add( Restrictions.isNull("padre") )
				.addOrder( Order.asc( "level" ) )
				.list();
				
				req.setAttribute("listFenomeniCadaverici", listFenomeniCadaverici);		
		
				ArrayList<LookupAutopsiaOrgani> listOrganiAutopsia = (ArrayList<LookupAutopsiaOrgani>) persistence.createCriteria( LookupAutopsiaOrgani.class )
						.add( Restrictions.eq( "tessuto", false ) )
						.add( Restrictions.eq( "enabledSde", true ) )
						.addOrder( Order.asc( "levelSde" ) )
						.list();
						
						ArrayList<LookupAutopsiaTipiEsami> listTipiAutopsia = (ArrayList<LookupAutopsiaTipiEsami>) persistence.createCriteria( LookupAutopsiaTipiEsami.class )
						.list();
						
						ArrayList<LookupAutopsiaEsitiEsami> listEsitiAutopsia = (ArrayList<LookupAutopsiaEsitiEsami>) persistence.createCriteria( LookupAutopsiaEsitiEsami.class )
						.list();
						
						ArrayList<LookupAutopsiaOrganiTipiEsamiEsiti> listOrganiTipiEsiti = (ArrayList<LookupAutopsiaOrganiTipiEsamiEsiti>) persistence.getNamedQuery("LookupAutopsiaOrganiTipiEsamiEsiti_OrganoEnabled").list();
							
						ArrayList<AutopsiaOrganoPatologie> organi = (ArrayList<AutopsiaOrganoPatologie>) persistence.getNamedQuery("GetAutopsiaOrganoPatologiaFromAutopsia").setInteger("idAutopsia", autopsia.getId()).list();

												req.setAttribute("organi", 		organi);
						req.setAttribute("listOrganiAutopsia", 		listOrganiAutopsia);
						req.setAttribute("listTipiAutopsia", 		listTipiAutopsia);	
						req.setAttribute("listEsitiAutopsia", 		listEsitiAutopsia);	
					 it.us.web.action.vam.cc.autopsie.Detail d = new  it.us.web.action.vam.cc.autopsie.Detail();
						req.setAttribute("allOrganiTipiEsiti",     d.getOrganoTipoEsitoForJsp(listOrganiTipiEsiti));
		
		
		
		ServicesStatus status = new ServicesStatus();
						
		req.setAttribute( "specie", SpecieAnimali.getInstance() );
		req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(animale, persistence, utente, status, connection, req));
		
		
		gotoPage("popup", "/jsp/vam/cc/autopsie/refertoNecro.jsp");
	}
}
