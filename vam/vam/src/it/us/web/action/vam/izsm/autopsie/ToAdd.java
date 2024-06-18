package it.us.web.action.vam.izsm.autopsie;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.remoteBean.Cane;
import it.us.web.bean.remoteBean.Gatto;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.Autopsia;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupAsl;
import it.us.web.bean.vam.lookup.LookupAutopsiaEsitiEsami;
import it.us.web.bean.vam.lookup.LookupAutopsiaOrganiTipiEsamiEsiti;
import it.us.web.bean.vam.lookup.LookupAutopsiaPatologiePrevalenti;
import it.us.web.bean.vam.lookup.LookupAutopsiaTipiEsami;
import it.us.web.bean.vam.lookup.LookupCMF;
import it.us.web.bean.vam.lookup.LookupCMI;
import it.us.web.bean.vam.lookup.LookupAutopsiaFenomeniCadaverici;
import it.us.web.bean.vam.lookup.LookupAutopsiaModalitaConservazione;
import it.us.web.bean.vam.lookup.LookupAutopsiaOrgani;
import it.us.web.bean.vam.lookup.LookupMantelli;
import it.us.web.bean.vam.lookup.LookupRazze;
import it.us.web.bean.vam.lookup.LookupSpecie;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.bean.vam.lookup.LookupAutopsiaSalaSettoria;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.ComparatorSuperUtenti;
import it.us.web.util.vam.ComparatorUtenti;
import it.us.web.util.vam.FelinaRemoteUtil;

public class ToAdd extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("esameNecroscopico");
	}

	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		
			ArrayList<LookupAutopsiaPatologiePrevalenti> patologieDefinitive = (ArrayList<LookupAutopsiaPatologiePrevalenti>) persistence.createCriteria( LookupAutopsiaPatologiePrevalenti.class )
					.addOrder( Order.asc( "level" ) )
					.add( Restrictions.eq( "enabled", true ) )
					.add( Restrictions.eq( "definitiva", true ) )
					.list();
			
		/*	ArrayList<LookupCMI> listCMI = (ArrayList<LookupCMI>) persistence.createCriteria( LookupCMI.class )
			.addOrder( Order.asc( "level" ) )
			.list();*/
			
			ArrayList<LookupCMF> listCMF = (ArrayList<LookupCMF>) persistence.createCriteria( LookupCMF.class )
			.addOrder( Order.asc( "level" ) )
			.list();
			
	//		ArrayList<LookupCMI> listCMINaturali = (ArrayList<LookupCMI>) persistence.createCriteria( LookupCMI.class )
	//		.add( Restrictions.eq( "causaNaturale", true ) )
	//		.list();
	//		
	//		ArrayList<LookupCMI> listCMIOther = (ArrayList<LookupCMI>) persistence.createCriteria( LookupCMI.class )
	//		.add( Restrictions.eq( "causaNaturale", false ) )
	//		.list();
			
			ArrayList<LookupAutopsiaModalitaConservazione> listModalitaConservazione = (ArrayList<LookupAutopsiaModalitaConservazione>) persistence.createCriteria( LookupAutopsiaModalitaConservazione.class )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			ArrayList<LookupAutopsiaFenomeniCadaverici> listFenomeniCadaverici = (ArrayList<LookupAutopsiaFenomeniCadaverici>) persistence.createCriteria( LookupAutopsiaFenomeniCadaverici.class )
			.add( Restrictions.isNull("padre") )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			ArrayList<LookupAutopsiaOrgani> listOrganiTessutiAutopsia = (ArrayList<LookupAutopsiaOrgani>) persistence.createCriteria( LookupAutopsiaOrgani.class )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			
			LookupSpecie specie = cc.getAccettazione().getAnimale().getLookupSpecie();
			String filtroSpecie = "";
			if(specie.getId()==SpecieAnimali.cane)
				filtroSpecie = "cani";
			else if(specie.getId()==SpecieAnimali.gatto)
				filtroSpecie = "gatti";
			else
			{
				Animale animale = cc.getAccettazione().getAnimale();
				if(animale.getDecedutoNonAnagrafe())
				{
					if(animale.getRazzaSinantropo()!=null)
					{
						if(animale.getRazzaSinantropo().toLowerCase().contains("uccell"))
							filtroSpecie = "uccelli";
						else
							filtroSpecie = "mammiferi";
					}
					else
						filtroSpecie = "mammiferi";
				}
				else
				{
					Sinantropo s = SinantropoUtil.getSinantropoByNumero(persistence, cc.getAccettazione().getAnimale().getIdentificativo());
					if(s.getLookupSpecieSinantropi().getUccello() || s.getLookupSpecieSinantropi().getUccelloZ())
						filtroSpecie = "uccelli";
					else
					{
						//attualmente per i rettili mostriamo gli organi degli uccelli perch� abbiamo solo quelli, 
						//quando avremo gli organi per ogni specie allora lo adatteremo
						filtroSpecie = "mammiferi";
					}
				}
			}
			ArrayList<LookupAutopsiaOrgani> organiSde = (ArrayList<LookupAutopsiaOrgani>) persistence.createCriteria( LookupAutopsiaOrgani.class )
			.add( Restrictions.eq( "tessuto", false ) )
			.add( Restrictions.eq( "enabledSde", true ) )
			.add( Restrictions.eq( filtroSpecie, true ) )
			.addOrder( Order.asc( "levelSde" ) )
			.list();
			
			ArrayList<LookupAutopsiaOrgani> organi = (ArrayList<LookupAutopsiaOrgani>) persistence.createCriteria( LookupAutopsiaOrgani.class )
			.add( Restrictions.eq( "tessuto", false ) )
			.add( Restrictions.eq( filtroSpecie, true ) )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			ArrayList<LookupAutopsiaOrgani> listTessutiAutopsia = (ArrayList<LookupAutopsiaOrgani>) persistence.createCriteria( LookupAutopsiaOrgani.class )
			.add( Restrictions.eq( "tessuto", true ) )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			ArrayList<LookupAutopsiaTipiEsami> listAutopsiaTipiEsami = (ArrayList<LookupAutopsiaTipiEsami>) persistence.createCriteria( LookupAutopsiaTipiEsami.class )
			.addOrder( Order.asc( "description" ) )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			ArrayList<LookupAutopsiaOrganiTipiEsamiEsiti> listOrganiTipiEsiti = (ArrayList<LookupAutopsiaOrganiTipiEsamiEsiti>) persistence.getNamedQuery("LookupAutopsiaOrganiTipiEsamiEsiti_OrganoEnabled").list();
			
			ArrayList<LookupAutopsiaTipiEsami> listTipiAutopsia = (ArrayList<LookupAutopsiaTipiEsami>) persistence.createCriteria( LookupAutopsiaTipiEsami.class )
			.list();
			
			ArrayList<LookupAutopsiaEsitiEsami> listEsitiAutopsia = (ArrayList<LookupAutopsiaEsitiEsami>) persistence.createCriteria( LookupAutopsiaEsitiEsami.class )
			.list();
			
			ArrayList<String> ruoli = new ArrayList<String>();
			ruoli.add("Ambulatorio - Veterinario");
			ruoli.add("Universita");
			
			Hashtable<Integer, SuperUtente> operatori = new Hashtable<Integer, SuperUtente>();
			//persistence.update(utente.getClinica());
			//Vecchia applicazione filtri
			/*
			for(BUtente u :utente.getClinica().getUtentis())
			{
				//Controllo il ruolo anche per id poich� nel campo ruolo, quando Guc aggiorna, inserisce l'id(questa cosa si deve modificare, guc deve inserire il nomne del ruolo)
				if(u.getRuolo()!=null && (u.getRuolo().equals("Ambulatorio - Veterinario") || u.getRuolo().equalsIgnoreCase("Referente Asl") || u.getRuolo().equals("14")))
					operatori.put(u.getSuperutente().getId(), u.getSuperutente());
			}
			ArrayList<LookupAsl> aslList = (ArrayList<LookupAsl>)persistence.findAll(LookupAsl.class);
			for(LookupAsl asl :aslList)
			{
				if(asl.getId()!=utente.getClinica().getLookupAsl().getId())
				{
					for(BUtente u :asl.getUtentiDistinct())
					{
						if(u.getRuolo()!=null && (u.getRuolo().equals("Referente Asl") || u.getRuolo().equals("14")))
							operatori.put(u.getSuperutente().getId(), u.getSuperutente());
					}
				}
				else
				{
					for(BUtente u :asl.getUtentiDistinct())
					{
						if(u.getRuolo()!=null && (u.getRuolo().equals("Universita") || u.getRuolo().equals("8")))
							operatori.put(u.getSuperutente().getId(), u.getSuperutente());
					}
				}
			}
			*/
			
			//Nuova applicazione filtri
			ArrayList<LookupAsl> aslList = (ArrayList<LookupAsl>)persistence.findAll(LookupAsl.class);
			Hashtable<String, String> nominativi = new Hashtable<String, String>();
			for(LookupAsl asl :aslList)
			{
				for(BUtente u :asl.getUtentiDistinct())
				{
					String ruolo = u.getRuolo();
					if(ruolo!=null && (ruolo.equals("Universita") || ruolo.equals("8") || 
									   ruolo.equals("Referente Asl") || ruolo.equals("14") || 
									   ruolo.equals("Sinantropi") || ruolo.equals("13") || 
									   ruolo.equals("Ambulatorio - Veterinario") || ruolo.equals("5")|| 
									   ruolo.equals("Borsisti") || ruolo.equals("12"))
									   && nominativi.get(u.getSuperutente().toString().toUpperCase())==null)
					{
						operatori.put(u.getSuperutente().getId(), u.getSuperutente());
						nominativi.put(u.getSuperutente().toString().toUpperCase(), u.getSuperutente().toString().toUpperCase());
					}
				}
			}
			//Fine nuova applicazione filtri
			
			Enumeration<SuperUtente> operatori2 = (Enumeration<SuperUtente>)operatori.elements();
			ArrayList<SuperUtente> operatori3 = new ArrayList<SuperUtente>();
			while( operatori2.hasMoreElements() )
			{
				operatori3.add( operatori2.nextElement() );
			}
			Collections.sort(operatori3, new ComparatorSuperUtenti());
			
			ArrayList<LookupAutopsiaSalaSettoria>		listAutopsiaSalaSettoria    = (ArrayList<LookupAutopsiaSalaSettoria>) persistence.createCriteria( LookupAutopsiaSalaSettoria.class )
			.add( Restrictions.eq( "enabled", true ) )
			.addOrder( Order.asc( "esterna" ) )
			.addOrder( Order.asc( "level" ) )
			.add( Restrictions.eq( "esameRiferimento", "Necroscopico" ) )
			.addOrder( Order.asc( "description" ) ).list();
			
			
			/*SERVIZIO DECESSO*/			
			ServicesStatus status = new ServicesStatus();
			
			if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 1 && !cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe()) {
				RegistrazioniCaninaResponse res	= CaninaRemoteUtil.getInfoDecesso( cc.getAccettazione().getAnimale().getIdentificativo(), utente, status, connection,req);
				
				//Errore nella comunicazione con il Wrapper
				if (!status.isAllRight()) {
					setMessaggio("Errore nella comunicazione con la BDR di riferimento");
					goToAction(new it.us.web.action.vam.cc.Detail());
				}
				
				req.setAttribute("res", res);
			}
			else if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 2 && !cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe()) {
				RegistrazioniFelinaResponse rfr = FelinaRemoteUtil.getInfoDecesso( cc.getAccettazione().getAnimale().getIdentificativo(), utente, status, connection,req);
				
				//Errore nella comunicazione con il Wrapper
				if (!status.isAllRight()) {
					setMessaggio("Errore nella comunicazione con la BDR di riferimento");
					goToAction(new it.us.web.action.vam.cc.Detail());
				}
				
				req.setAttribute("res", rfr);
			}
			else if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 3) {
				RegistrazioniSinantropiResponse rsr = SinantropoUtil.getInfoDecesso(persistence, cc.getAccettazione().getAnimale());
				req.setAttribute("res", rsr);
			}
				
			
		//	req.setAttribute("listCMI", listCMI);		
			req.setAttribute("listCMF", listCMF);	
			req.setAttribute("listModalitaConservazione", listModalitaConservazione);
			req.setAttribute("listFenomeniCadaverici", listFenomeniCadaverici);		
			req.setAttribute("organi", organi);		
			req.setAttribute("organiSde", organiSde);		
			req.setAttribute("listTessutiAutopsia", listTessutiAutopsia);		
			req.setAttribute("listOrganiTessutiAutopsia", listOrganiTessutiAutopsia);		
			req.setAttribute("listOrganiTipiEsiti", listOrganiTipiEsiti);
			req.setAttribute("listAutopsiaTipiEsami", listAutopsiaTipiEsami);
			req.setAttribute("listTipiAutopsia", listTipiAutopsia);
			req.setAttribute("listEsitiAutopsia",       listEsitiAutopsia);	
			req.setAttribute("allOrganiTipiEsiti",      getOrganoTipoEsitoForJsp(listOrganiTipiEsiti));	
			req.setAttribute("operatori", operatori3);
			req.setAttribute("listAutopsiaSalaSettoria", listAutopsiaSalaSettoria);
			req.setAttribute( "specie", SpecieAnimali.getInstance() );
			req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(cc.getAccettazione().getAnimale(), persistence, utente, status, connection,req));
			req.setAttribute("patologieDefinitive", patologieDefinitive);
			
			//Controllo se posso inserire la necroscopia
			Autopsia a = cc.getAutopsia();
			boolean utenteStrutturaNecroscopia = true;
			if(a.getLass().getEsterna())
			{
				if(a.getLass().getDescription().toLowerCase().contains("izsm-avellino") && utente.getClinica().getNomeBreve().toLowerCase().contains("izsm-avellino"))
					utenteStrutturaNecroscopia = true;
				else if(a.getLass().getDescription().toLowerCase().contains("izsm-avellino") && utente.getClinica().getNomeBreve().toLowerCase().contains("izsm-avellino"))
					utenteStrutturaNecroscopia = true;
				else if(a.getLass().getDescription().toLowerCase().contains("izsm-benevento") && utente.getClinica().getNomeBreve().toLowerCase().contains("izsm-benevento"))
					utenteStrutturaNecroscopia = true;
				else if(a.getLass().getDescription().toLowerCase().contains("izsm-caserta") && utente.getClinica().getNomeBreve().toLowerCase().contains("izsm-caserta"))
					utenteStrutturaNecroscopia = true;
				else if(a.getLass().getDescription().toLowerCase().contains("izsm-portici") && utente.getClinica().getNomeBreve().toLowerCase().contains("izsm-portici"))
					utenteStrutturaNecroscopia = true;
				else if(a.getLass().getDescription().toLowerCase().contains("izsm-salerno") && utente.getClinica().getNomeBreve().toLowerCase().contains("izsm-salerno"))
					utenteStrutturaNecroscopia = true;
				else if(a.getLass().getDescription().toLowerCase().contains("unina") && utente.getClinica().getNomeBreve().toLowerCase().contains("unina"))
					utenteStrutturaNecroscopia = true;
				else 
					utenteStrutturaNecroscopia = false;
			}
			else
			{
				if(utente.getClinica().getId()!=a.getEnteredBy().getClinica().getId())
					utenteStrutturaNecroscopia = false;
			}
			
			req.setAttribute("utenteStrutturaNecroscopia", utenteStrutturaNecroscopia);
			//Fine controllo
			
			gotoPage("/jsp/vam/izsm/autopsie/add.jsp");
			
	}
	
	
	private HashMap<String, Set<LookupAutopsiaOrganiTipiEsamiEsiti>> getOrganoTipoEsitoForJsp(ArrayList<LookupAutopsiaOrganiTipiEsamiEsiti> listOrganiTipiEsiti) 
	{
		HashMap<String, Set<LookupAutopsiaOrganiTipiEsamiEsiti>>     allOrganiTipiEsiti = new HashMap<String, Set<LookupAutopsiaOrganiTipiEsamiEsiti>>(0);
		Iterator<LookupAutopsiaOrganiTipiEsamiEsiti> iter = listOrganiTipiEsiti.iterator();
		while(iter.hasNext())
		{
			LookupAutopsiaOrganiTipiEsamiEsiti ote = iter.next();
			int idOrgano      = ote.getLookupOrganiAutopsia().getId();
			int idTipo        = ote.getLookupAutopsiaTipiEsami().getId();
			String descOrgano = ote.getLookupOrganiAutopsia().getDescription();
			String descTipo   = ote.getLookupAutopsiaTipiEsami().getDescription();
			String chiave     = idOrgano+"---"+descOrgano+";"+idTipo+"---"+descTipo;
			if(allOrganiTipiEsiti.containsKey(chiave))
			{
				Set<LookupAutopsiaOrganiTipiEsamiEsiti> temp = allOrganiTipiEsiti.get(chiave);
				allOrganiTipiEsiti.remove(chiave);
				temp.add(ote);
				allOrganiTipiEsiti.put(chiave, temp);
			}
			else
			{
				Set<LookupAutopsiaOrganiTipiEsamiEsiti> toAdd = new HashSet<LookupAutopsiaOrganiTipiEsamiEsiti>();
				toAdd.add(ote);
				allOrganiTipiEsiti.put(chiave, toAdd);
			}
		}
		
		return allOrganiTipiEsiti;
	}
}


