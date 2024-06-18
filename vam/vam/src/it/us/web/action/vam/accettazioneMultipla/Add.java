package it.us.web.action.vam.accettazioneMultipla;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.bean.Parameter;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.SuperUtenteAll;
import it.us.web.bean.remoteBean.ProprietarioCane;
import it.us.web.bean.remoteBean.ProprietarioGatto;
import it.us.web.bean.remoteBean.RegistrazioniInterface;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.AccettazioneNoH;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.AnimaleNoH;
import it.us.web.bean.vam.AttivitaBdr;
import it.us.web.bean.vam.AttivitaBdrNoH;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Clinica;
import it.us.web.bean.vam.Trasferimento;
import it.us.web.bean.vam.lookup.LookupAccettazioneAttivitaEsterna;
import it.us.web.bean.vam.lookup.LookupAsl;
import it.us.web.bean.vam.lookup.LookupAssociazioni;
import it.us.web.bean.vam.lookup.LookupComuni;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazioneCondizionate;
import it.us.web.bean.vam.lookup.LookupPersonaleInterno;
import it.us.web.bean.vam.lookup.LookupSpecie;
import it.us.web.bean.vam.lookup.LookupTipiRichiedente;
import it.us.web.bean.vam.lookup.LookupTipoTrasferimento;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.constants.IdOperazioniInBdr;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.constants.TipiRichiedente;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.hibernate.Persistence;
import it.us.web.dao.hibernate.PersistenceFactory;
import it.us.web.dao.lookup.LookupAslDAO;
import it.us.web.dao.lookup.LookupAssociazioniDAO;
import it.us.web.dao.lookup.LookupAttivitaEsterneDAO;
import it.us.web.dao.lookup.LookupComuniDAO;
import it.us.web.dao.lookup.LookupOperazioniAccettazioneDAO;
import it.us.web.dao.lookup.LookupPersonaleInternoDAO;
import it.us.web.dao.lookup.LookupTipiRichiedenteDAO;
import it.us.web.dao.lookup.LookupTipoTrasferimentoDAO;
import it.us.web.dao.vam.AccettazioneDAO;
import it.us.web.dao.vam.AnimaleDAO;
import it.us.web.dao.vam.AnimaleDAONoH;
import it.us.web.dao.vam.AttivitaBdrDAO;
import it.us.web.dao.vam.ClinicaDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.exceptions.ModificaBdrException;
import it.us.web.util.DateUtils;
import it.us.web.util.dwr.vam.accettazione.Test;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;
import it.us.web.util.vam.RegistrazioniUtil;

public class Add extends GenericAction  implements TipiRichiedente, Specie
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "ACCETTAZIONE", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("accettazione");
	}

	/**
	 * synchronized per evitare problemi col progressivo
	 */
	@SuppressWarnings("unchecked")
	@Override
	public synchronized void execute() throws Exception
	{
		Context ctxBdu = new InitialContext();
		javax.sql.DataSource dsBdu = (javax.sql.DataSource)ctxBdu.lookup("java:comp/env/jdbc/bduS");
		connectionBdu = dsBdu.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connectionBdu);

		Context ctx3 = new InitialContext();
		javax.sql.DataSource ds3 = (javax.sql.DataSource)ctx3.lookup("java:comp/env/jdbc/vamM");
		connection = ds3.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		Statement st1 = null;
		ResultSet rs1 = null;
		
		ArrayList<Parameter> mcs = parameterList("microchip", true);
		
		SimpleDateFormat sdf = new SimpleDateFormat( "yyMMddHHmmss" );
		String idAccMultipla = utente.getClinica().getId() + "" + sdf.format( new Date()) ;
		
		
		for(int i=0;i<mcs.size();i++)
		{
			AccettazioneNoH accettazione = new AccettazioneNoH();
			BeanUtils.populate(accettazione, req.getParameterMap());
			accettazione = popolaBean(accettazione,i+1);
			
			AnimaleNoH animale = AnimaleDAONoH.getAnimaleNoH(mcs.get(i).getValore(), connection);		
			accettazione.setOperazioniRichieste( (Set<LookupOperazioniAccettazione>) objectList( LookupOperazioniAccettazione.class, "op_" ) );
			
			
			//Ricontrollo possibilit� di apertura nuove accettazioni, per evitare salvataggi al tasto indietro, F5 ecc
			
			
			accettazione.setAnimale( animale );
	
			animale.setClinicaChippatura(utente.getClinica());
			
			setupRichiedente( accettazione );
			if(stringaFromRequest("progressivo")==null)
				setupProgressivo( accettazione, i );
			setupCampiSistema( accettazione );
			
			validaBean( accettazione, new ToAdd() );
			
			accettazione.setIdAccMultipla(idAccMultipla);
			
			AnimaleDAO.updateClinicaChippatura(connection,animale);
			
			int idAccettazione = AccettazioneDAO.getNextId(connection);
			accettazione.setId(idAccettazione);
			AccettazioneDAO.insert(accettazione, connection);
			gestisciOperazioneInserimentoAnagrafe( accettazione );
			
			Iterator<LookupOperazioniAccettazione> iterOpRichieste = accettazione.getOperazioniRichieste().iterator();
			while(iterOpRichieste.hasNext())
			{
				LookupOperazioniAccettazione op = iterOpRichieste.next();
				AccettazioneDAO.insertOperazioniRichieste(accettazione.getId(), op.getId(), connection);
			}
			Iterator<SuperUtenteAll> iterPersonaleAsl = accettazione.getPersonaleAsl().iterator();
			while(iterPersonaleAsl.hasNext())
			{
				SuperUtenteAll sUt = iterPersonaleAsl.next();
				AccettazioneDAO.insertPersonaleAsl(accettazione.getId(), sUt.getId(), connection);
			}
			Iterator<LookupPersonaleInterno> iterPersonaleInterno = accettazione.getPersonaleInterno().iterator();
			while(iterPersonaleInterno.hasNext())
			{
				LookupPersonaleInterno persInterno = iterPersonaleInterno.next();
				AccettazioneDAO.insertPersonaleInterno(accettazione.getId(), persInterno.getId(), connection);
			}
		}
		persistence.commit();
		
		String mcsString = "";
		for(int i=0;i<mcs.size();i++)
		{
			
			mcsString += mcs.get(i).getValore();
			if(i<mcs.size()-1)
				mcsString += "-----";
		}
		
		setMessaggio("Le accettazioni sono state inserite");
		redirectTo( "vam.accettazioneMultipla.List.us?microchip=" + mcsString );
			
	}

	/**
	 * Se prima dell'accettazione si � proceduto ad anagrafare l'animale (flag "iscrizione anagrafe" selezionato)
	 * viene inserito il relativo record nella tabella "AttivitaBdr"
	 * @param accettazione
	 * @throws Exception 
	 */
	private void gestisciOperazioneInserimentoAnagrafe(AccettazioneNoH accettazione) throws Exception
	{
		Set<LookupOperazioniAccettazione> loas = accettazione.getOperazioniRichieste();
		for( LookupOperazioniAccettazione ll: loas )
		{
			//"iscrizione anagrafe" ha id 1
			if( ll.getId() == IdOperazioniBdr.iscrizione && accettazione.getAnimale().getLookupSpecie().getId() != Specie.SINANTROPO)
			{
				AttivitaBdrNoH abdr = new AttivitaBdrNoH();
				abdr.setAccettazione	( accettazione );
				abdr.setEntered			( accettazione.getEntered() );
				abdr.setEnteredBy		( utente.getId() );
				abdr.setModified		( abdr.getEntered() );
				abdr.setModifiedBy		( utente.getId() );
				abdr.setOperazioneBdr	( ll );
				
				if (accettazione.getAnimale().getLookupSpecie().getId() != Specie.SINANTROPO ){
					int idTipoRegBdr = RegistrazioniUtil.getIdTipoBdr(accettazione.getAnimale(), accettazione, ll, connection, connectionBdu,req);
					abdr.setIdRegistrazioneBdr(CaninaRemoteUtil.getUltimaRegistrazione(accettazione.getAnimale().getIdentificativo(), idTipoRegBdr, connectionBdu,req));
				}
				
				HashSet<AttivitaBdrNoH> hs = new HashSet<AttivitaBdrNoH>();
				hs.add( abdr );
				
				accettazione.setAttivitaBdrs( hs );
				AttivitaBdrDAO.insert(abdr, connection);
			}
		}
		
	}

	private void setupCampiSistema(AccettazioneNoH accettazione)
	{
		accettazione.setEnteredBy( utente );
		accettazione.setModifiedBy( utente );
		accettazione.setEntered( new Date(System.currentTimeMillis()) );
		accettazione.setModified( accettazione.getEntered() );
	}

	@SuppressWarnings("unchecked")
	private void setupProgressivo(AccettazioneNoH accettazione, int aggiunta)
	{
		int nextProgressivo = 1;
		nextProgressivo =  AccettazioneDAO.getNextProgressivo(DateUtils.annoCorrente( accettazione.getData() )  , 
				                           DateUtils.annoSuccessivo( accettazione.getData()) ,
				                           utente.getClinica().getId(),
				                           connection );
		
		accettazione.setProgressivo( nextProgressivo + aggiunta );
	}

	private void setupRichiedente(AccettazioneNoH accettazione) throws Exception
	{
		
		LookupTipiRichiedente tipoRichiedente = LookupTipiRichiedenteDAO.getTipoRichiedente(interoFromRequest( "tipoRichiedente" ), connection);
		
		accettazione.setLookupTipiRichiedente( tipoRichiedente );
		
		switch ( tipoRichiedente.getId() )
		{
		case PRIVATO:
			richiedentePrivato( accettazione );
			break;
		//case PERSONALE_INTERNO:
			//richiedentePersonaleInterno( accettazione );
			//break;
		case PERSONALE_ASL:
			richiedentePersonaleAsl( accettazione );
			break;
		case ASSOCIAZIONE:
			richiedenteAssociazione( accettazione );
			break;
		default:
			if( tipoRichiedente.getForzaPubblica() ) { richiedenteForzaPubblica( accettazione ); }
			break;
		}
		
		if(stringaFromRequest("interventoPersonaleInterno")!=null)
			richiedentePersonaleInterno(accettazione);
		
	}

	private void richiedenteForzaPubblica(AccettazioneNoH accettazione)
	{
		//nulla da fare (vengono caricati automaticamente i campi nome, cognome, documento e codice fiscale)
	}

	private void richiedentePersonaleAsl(AccettazioneNoH accettazione) throws Exception
	{
		int asl = interoFromRequest("idRichiedenteAsl");
		LookupAsl		aslObject					= LookupAslDAO.getAsl(asl, connection);
		
		String personaleAslString = req.getParameter("idDipendenteAsl");
		String[] personaleAsl = personaleAslString.split(",");
		Set<SuperUtenteAll> personaliAslSet = new HashSet<SuperUtenteAll>();
		for(int i=0;i<personaleAsl.length;i++)
		{
			int			idRichiedenteAsl	= Integer.parseInt(personaleAsl[i]);
			SuperUtenteAll		user					= UtenteDAO.getUtenteAll(idRichiedenteAsl).getSuperutente();
			personaliAslSet.add(user);
		}
		accettazione.setPersonaleAsl(personaliAslSet);
		accettazione.setRichiedenteAsl(aslObject);
	}

	private void richiedentePersonaleInterno(AccettazioneNoH accettazione) throws Exception
	{
		String personaleInternoString = req.getParameter("idRichiedenteInterno");
		String[] personaleInterno = personaleInternoString.split(",");
		Set<LookupPersonaleInterno> personaliInterni = new HashSet<LookupPersonaleInterno>();
		for(int i=0;i<personaleInterno.length;i++)
		{
			int			idRichiedenteInterno	= Integer.parseInt(personaleInterno[i]);
			LookupPersonaleInterno		user					= LookupPersonaleInternoDAO.getPersonale(idRichiedenteInterno, connection);
			personaliInterni.add(user);
		}
		accettazione.setPersonaleInterno(personaliInterni);
	}
	
	private void richiedenteAssociazione(AccettazioneNoH accettazione) throws Exception
	{
		int					idAssociazione	= interoFromRequest( "idAssociazione" );
		
		LookupAssociazioni	associazione	= LookupAssociazioniDAO.getAssociazione(idAssociazione,connection);

		accettazione.setRichiedenteAssociazione( associazione );		
	}

	private void richiedentePrivato(AccettazioneNoH accettazione)
	{
		boolean coincideConProprietario = booleanoFromRequest( "richiedenteProprietario" );
		
		accettazione.setRichiedenteProprietario( coincideConProprietario );
		
		if( coincideConProprietario )
		{
			accettazione.setRichiedenteNome			( accettazione.getProprietarioNome() );
			accettazione.setRichiedenteCognome		( accettazione.getProprietarioCognome() );
			accettazione.setRichiedenteCodiceFiscale( accettazione.getProprietarioCodiceFiscale() );
			accettazione.setRichiedenteDocumento	( accettazione.getProprietarioDocumento() );
			accettazione.setRichiedenteTipoProprietario			( accettazione.getProprietarioTipo() );
		}
	}
	
	
	private String checkPossibilitaAprire( Set<LookupOperazioniAccettazione> opSelezionate, String idUtente, AnimaleNoH animale, String idRichiedenteS, String idClinicaDestinazione, String tipoEsecuzione, Integer idTipoTrasf, boolean intraFuoriAsl, boolean versoAssocCanili )
	{
		String ret = "";
		try
		{
			Context ctx = new InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
			Connection connectionBduTemp = ds.getConnection();
			GenericAction.aggiornaConnessioneApertaSessione(req);
			Persistence persistence 								 = PersistenceFactory.getPersistence();
			GenericAction.aggiornaConnessioneApertaSessione(req);
			BUtente utente 										 	 = UtenteDAO.getUtente(Integer.parseInt(idUtente));
			Integer idRichiedente 									 = null;
			Clinica clinicaDestinazione								 = null;
			if(tipoEsecuzione.equals("accettazione"))
				idRichiedente = Integer.parseInt(idRichiedenteS);
			if(tipoEsecuzione.equals("trasferimento"))
				clinicaDestinazione = ClinicaDAO.getClinica(Integer.parseInt(idClinicaDestinazione), connection);
			//Set<LookupOperazioniAccettazione> opSelezionate 	 	 = convertToSet(opSelezionateArray, persistence);
			Iterator<LookupOperazioniAccettazione> opSelezionateIter = opSelezionate.iterator();
			RegistrazioniInterface opEffettuabiliBdr			 	 = AnimaliUtil.findRegistrazioniEffettuabili( connection, animale, utente, connectionBduTemp,req );
			
			while(opSelezionateIter.hasNext())
			{
				boolean anomaliaRiscontrata = false;
				LookupOperazioniAccettazione operazione = opSelezionateIter.next();
				
				if(tipoEsecuzione.equals("accettazione") && nonEffettuabileInBdr(operazione, opEffettuabiliBdr, idTipoTrasf, connection, connection, utente, animale, intraFuoriAsl, versoAssocCanili) && !verificaRichiedenteAssociazione(idRichiedente, operazione) && !operazioneAbilitanteSelezionata(opSelezionate, operazione))
				{
					ret += "- " + operazione.getDescription() + " non risulta effettuabile in BDR.\n" ;
					anomaliaRiscontrata=true;
				}
				
				if(tipoEsecuzione.equals("trasferimento") && nonEffettuabileInBdr(operazione, opEffettuabiliBdr, idTipoTrasf, connection, connectionBdu, utente, animale, intraFuoriAsl, versoAssocCanili) && !operazioneAbilitanteSelezionata(opSelezionate, operazione))
				{
					ret += "- " + operazione.getDescription() + " non risulta effettuabile in BDR.\n" ;
					anomaliaRiscontrata=true;
				}
				
				if(tipoEsecuzione.equals("accettazione") && !anomaliaRiscontrata && nonEffettuabileAnimaliDeceduti(operazione, animale, utente, persistence, connection) && !verificaRichiedenteAssociazione(idRichiedente, operazione) && !operazioneAbilitanteSelezionata(opSelezionate, operazione))
				{
					ret += "- " + operazione.getDescription() + " non risulta effettuabile per animali deceduti.\n" ;
					anomaliaRiscontrata=true;	
				}
				
				if(tipoEsecuzione.equals("trasferimento") && !anomaliaRiscontrata && nonEffettuabileAnimaliDeceduti(operazione, animale, utente, persistence, connection) && !operazioneAbilitanteSelezionata(opSelezionate, operazione))
				{
					ret += "- " + operazione.getDescription() + " non risulta effettuabile per animali deceduti.\n" ;
					anomaliaRiscontrata=true;	
				}
				
				if(tipoEsecuzione.equals("accettazione") && !anomaliaRiscontrata && nonEffettuabileAnimaliVivi(operazione, animale, utente, persistence, connection) &&  !verificaRichiedenteAssociazione(idRichiedente, operazione) && !operazioneAbilitanteSelezionata(opSelezionate, operazione))
				{
					ret += "- " + operazione.getDescription() + " non risulta effettuabile per animali vivi.\n" ;
					anomaliaRiscontrata=true;
				}
				
				if(tipoEsecuzione.equals("trasferimento") && !anomaliaRiscontrata && nonEffettuabileAnimaliVivi(operazione, animale, utente, persistence, connection) && !operazioneAbilitanteSelezionata(opSelezionate, operazione))
				{
					ret += "- " + operazione.getDescription() + " non risulta effettuabile per animali vivi.\n" ;
					anomaliaRiscontrata=true;
				}
				
				if(tipoEsecuzione.equals("accettazione") && !anomaliaRiscontrata && nonEffettuabileAnimaliFuoriAsl(operazione, animale, utente, persistence, connection) && nonEffettuabileAnimaliFuoriAslDeceduti(operazione, animale, utente, persistence, connection) && !verificaRichiedenteAssociazione(idRichiedente, operazione) && !operazioneAbilitanteSelezionata(opSelezionate, operazione))
				{
					ret += "- " + operazione.getDescription() + " non risulta effettuabile per animali fuori asl.\n" ;
					anomaliaRiscontrata=true;
				}
				
				if(tipoEsecuzione.equals("trasferimento") && !anomaliaRiscontrata && nonEffettuabileAnimaliFuoriAsl(operazione, animale, utente, persistence, connection) && nonEffettuabileAnimaliFuoriAslDeceduti(operazione, animale, utente, persistence, connection) && !operazioneAbilitanteSelezionata(opSelezionate, operazione))
				{
					ret += "- " + operazione.getDescription() + " non risulta effettuabile per animali fuori asl.\n" ;
					anomaliaRiscontrata=true;
				}
				
				LookupOperazioniAccettazione opDisabilitante = operazioneDisabilitanteSelezionata(opSelezionate, operazione);
				if(!anomaliaRiscontrata && opDisabilitante!=null)
				{
					ret += "- " + operazione.getDescription() + " non risulta effettuabile perch� � stata selezionata l'operazione " + opDisabilitante.getDescription() + ".\n";
					anomaliaRiscontrata=true;
				}
			}
			
			if(!ret.equals(""))
				ret="L'accettazione non � registrabile per i seguenti motivi:\n"+ret;
			
			PersistenceFactory.closePersistence( persistence, true );
			GenericAction.aggiornaConnessioneChiusaSessione(req);
			connectionBduTemp.close();
			GenericAction.aggiornaConnessioneChiusaSessione(req);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return e.getMessage();
		}
		return ret;
		
	}
	
//Verifico se non � possibile per animali vivi
private boolean nonEffettuabileAnimaliVivi(LookupOperazioniAccettazione operazione, AnimaleNoH animale, BUtente utente, Persistence persistence,Connection connection) throws Exception
{
	Date dataDecesso = null;
	if(animale.getLookupSpecie().getId()==SpecieAnimali.cane && CaninaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection ,req)!=null)
		dataDecesso = CaninaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection,req ).getDataEvento();
	else if(animale.getLookupSpecie().getId()==SpecieAnimali.gatto && FelinaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection ,req)!=null)
		dataDecesso = FelinaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection ,req).getDataEvento();
	else if(animale.getLookupSpecie().getId()==SpecieAnimali.sinantropo && SinantropoUtil.getInfoDecesso(persistence, animale)!=null)
		dataDecesso = SinantropoUtil.getInfoDecesso(persistence, animale).getDataEvento();
	return !(operazione.getEffettuabileDaVivo()==null || operazione.getEffettuabileDaVivo()) && !animale.getDecedutoNonAnagrafe() && dataDecesso==null ;
}

//Verifico se non � possibile per animali fuori asl, nel caso di accettazione
private boolean nonEffettuabileAnimaliFuoriAsl(LookupOperazioniAccettazione operazione, AnimaleNoH animale, BUtente utente, Persistence persistence,Connection connection) throws Exception
{
	boolean fuoriAsl = false;
	Integer asl = null;
	ArrayList<LookupAsl> listAsl = null;
	if(animale.getLookupSpecie().getId()==SpecieAnimali.cane)
	{
		ProprietarioCane prop = CaninaRemoteUtil.findProprietario(animale.getIdentificativo(), utente, connection,req);
		if(prop!=null)
			asl =CaninaRemoteUtil.findProprietario(animale.getIdentificativo(), utente, connection,req).getAsl();
		if(asl!=null)
			fuoriAsl = asl!=utente.getClinica().getLookupAsl().getId();
	}
	else if(animale.getLookupSpecie().getId()==SpecieAnimali.gatto)
	{
		ProprietarioGatto prop = FelinaRemoteUtil.findProprietario(animale.getIdentificativo(), utente, connection,req);
		if(prop!=null)
			asl =FelinaRemoteUtil.findProprietario(animale.getIdentificativo(), utente, connection,req).getAsl();
		if(asl!=null)
			fuoriAsl = asl!=utente.getClinica().getLookupAsl().getId();
	}
	return !(operazione.getEffettuabileFuoriAsl()==null || operazione.getEffettuabileFuoriAsl()) && animale.getLookupSpecie().getId()!=SpecieAnimali.sinantropo && fuoriAsl;
}

//Verifico se non � possibile per animali fuori asl, nel caso di trasferimento
private boolean nonEffettuabileAnimaliFuoriAsl(LookupOperazioniAccettazione operazione, Animale animale, BUtente utente, Clinica clinicaDestinazione, Persistence persistence) throws UnsupportedEncodingException
{
	boolean fuoriAsl = false;
	LookupAsl asl = null;
	ArrayList<LookupAsl> listAsl = null;
	if(animale.getLookupSpecie().getId()==SpecieAnimali.cane)
	{
		//Cane cane = ((ArrayList<Cane>)persistence.getNamedQuery("GetCaneByMc").setString( "mc", animale.getIdentificativo()).list()).get(0);
		/*listAsl = (ArrayList<LookupAsl>)persistence.getNamedQuery("GetProprietarioAslCane").setInteger( "idCane", cane.getId()).list();
		if(!listAsl.isEmpty())
			asl = listAsl.get(0);
		if(asl!=null)
			fuoriAsl = asl.getId()!=clinicaDestinazione.getLookupAsl().getId();*/
	}
	else if(animale.getLookupSpecie().getId()==SpecieAnimali.gatto)
	{
		//Gatto gatto = ((ArrayList<Gatto>)persistence.getNamedQuery("GetGattoByMc").setString( "mc", animale.getIdentificativo()).list()).get(0);
		/*listAsl = (ArrayList<LookupAsl>)persistence.getNamedQuery("GetProprietarioAslGatto").setInteger( "idGatto", gatto.getId()).list();
		if(!listAsl.isEmpty())
			asl = listAsl.get(0);
		if(asl!=null)
			fuoriAsl = asl.getId()!=clinicaDestinazione.getLookupAsl().getId();*/
	}
	return !(operazione.getEffettuabileFuoriAsl()==null || operazione.getEffettuabileFuoriAsl()) && animale.getLookupSpecie().getId()!=SpecieAnimali.sinantropo && fuoriAsl;
}

//Verifico se non � possibile per animali fuori asl deceduti
private boolean nonEffettuabileAnimaliFuoriAslDeceduti(LookupOperazioniAccettazione operazione, AnimaleNoH animale, BUtente utente, Persistence persistence, Connection connection) throws Exception
{
	Date dataDecesso = null;
	if(animale.getLookupSpecie().getId()==SpecieAnimali.cane && CaninaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection ,req)!=null)
		dataDecesso = CaninaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection ,req).getDataEvento();
	else if(animale.getLookupSpecie().getId()==SpecieAnimali.gatto && FelinaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection,req )!=null)
		dataDecesso = FelinaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection ,req).getDataEvento();
	else if(animale.getLookupSpecie().getId()==SpecieAnimali.sinantropo && SinantropoUtil.getInfoDecesso(persistence, animale)!=null)
		dataDecesso = SinantropoUtil.getInfoDecesso(persistence, animale).getDataEvento();
	return !((operazione.getEffettuabileFuoriAslMorto()==null || operazione.getEffettuabileFuoriAslMorto()) && (animale.getDecedutoNonAnagrafe() || dataDecesso!=null));
}

private Set<LookupOperazioniAccettazione> convertToSet(String[] opSelezionateArray, Persistence persistence) throws Exception
{
	int i = 0;
	Set<LookupOperazioniAccettazione> opSelezionate = new HashSet<LookupOperazioniAccettazione>();
	while(i<opSelezionateArray.length)
	{
		opSelezionate.add((LookupOperazioniAccettazione)persistence.find(LookupOperazioniAccettazione.class, Integer.parseInt(opSelezionateArray[i]) )  );
		i++;
	}
	return opSelezionate;
}

private Animale getAnimale(int idAnimale, Persistence persistence) throws Exception
{
	Animale animale = ((ArrayList<Animale>)persistence.getNamedQuery("GetAnimaleById").setInteger("id", idAnimale).list()).get(0);
	//Animale animale = (Animale)persistence.find(Animale.class, idAnimale);
	
	return animale;
}

//Controlla se � possibile aprire un'accettazione in accordo col documento "CR VAM - vincoli su inserimento accettazione"
//Se si pu� aprire ritorna una stringa vuota, altrimenti il messaggio indicante il motivo
public String possibileAprire(String idAnimale, String idUtente)
{
	try
	{
		Persistence persistence 								 = PersistenceFactory.getPersistence();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		BUtente utente 										 	 = (BUtente)persistence.find(BUtente.class, Integer.parseInt(idUtente));
		Animale animale 									 	 = getAnimale(Integer.parseInt(idAnimale), persistence);
		Accettazione accettazione 								 = null;
		String messaggio 										 = "";
		Clinica clinica											 = null;
		CartellaClinica cc 										 = null;

		
		if((accettazione = animale.getAccettazioneConOpDaCompletare())!=null)
			messaggio = "Apertura impossibile: esiste gi� l'accettazione con n� " + accettazione.getProgressivoFormattato() + " che ha delle operazioni in sospeso.";
		else if((accettazione = animale.getAccettazioneConCcDaAprire())!=null && accettazione.getObbligoAprireCartellaClinica())
			messaggio = "Apertura impossibile: esiste gi� l'accettazione con n� " + accettazione.getProgressivoFormattato() + " su cui deve essere aperta la cartella clinica.";
		if((accettazione = animale.getAccettazionePerSmaltimento())!=null && animale.getDataSmaltimentoCarogna()==null)
			messaggio = "Apertura impossibile: esiste gi� l'accettazione con n� " + accettazione.getProgressivoFormattato() + " su cui deve essere registrato il trasporto spoglie. Se si deve inserire una cartella nescroscopica proseguire da questa accettazione.";
		else if((cc = getCcRicovero(animale, persistence))!=null && (!animaleInArrivo(animale,utente) || !animaleRientrante(animale,utente,persistence)))
			messaggio = "Apertura impossibile: l'animale � ricoverato presso " + ((cc.getEnteredBy().getClinica()==utente.getClinica())?("la tua clinica"):("la clinica " + cc.getEnteredBy().getClinica().getNome())) + " con la cc numero " + cc.getNumero();
		else if((cc = getCcConOpDaCompletare(animale, persistence))!=null && animale.getLookupSpecie().getId()!=Specie.SINANTROPO)
			messaggio = "Apertura impossibile: esiste la cc " + cc.getNumero() + " con registrazioni in sospeso nelle dimissioni";
		else if((animale.getEsameNecroscopico()!=null || animale.getDataSmaltimentoCarogna()!=null) && (!animaleInArrivo(animale,utente) || !animaleRientrante(animale,utente,persistence)))
			messaggio = "Apertura impossibile: l'animale � morto ed � stata fatta una necroscopia o registrato il trasporto spoglie.";
		PersistenceFactory.closePersistence( persistence, true );
		GenericAction.aggiornaConnessioneChiusaSessione(req);
		
		return messaggio;
	}
	catch(Exception e)
	{
		e.printStackTrace();
		return "";
	}
}

private CartellaClinica getCcRicovero(Animale animale, Persistence persistence)
{
	
	String microchip = (animale.getIdentificativo() != null && !("").equals(animale.getIdentificativo())) ? animale.getIdentificativo() : animale.getTatuaggio();
	ArrayList<CartellaClinica> cc = (ArrayList<CartellaClinica>)persistence.getNamedQuery("AnimaleRicoveratoOggi")
									.setString( "mc", microchip )
									.list();
	if(!cc.isEmpty())
		return cc.get(0);
	else
		return null;
}

private CartellaClinica getCcConOpDaCompletare(Animale animale, Persistence persistence)
{
	ArrayList<CartellaClinica> ccList = (ArrayList<CartellaClinica>) persistence.getNamedQuery("GetCCByIdCane2").setInteger("idAnimale", animale.getId()).list();
	
	Iterator<CartellaClinica> iter = ccList.iterator();
	while(iter.hasNext())
	{
		CartellaClinica cc = iter.next();
		if(getIdTipoAttivitaBdrCompletata(cc)==null && (cc.getDestinazioneAnimale().getId()==3 || cc.getDestinazioneAnimale().getId()==5))
		{
			return cc;
		}
	}
	
	return null;
}


//Controlla se c'� una riconsegna in atto per quest'animale
private boolean animaleRientrante(Animale animale, BUtente utente, Persistence persistence)
{
	ArrayList<Trasferimento> trasferimentiRientranti = (ArrayList<Trasferimento>) persistence
	.createCriteria( Trasferimento.class )
	.add( Restrictions.eq( "clinicaOrigine", utente.getClinica()) )
	.add( Restrictions.isNotNull( "cartellaClinicaMittenteRiconsegna" ) )
	.add( Restrictions.eq("cartellaClinica.accettazione.animale", animale) )
	.createAlias( "cartellaClinicaMittenteRiconsegna", "cc" )
	.add( Restrictions.leProperty( "cc.modified", "cc.entered" ) )
	.list();
	
	if(trasferimentiRientranti.isEmpty())
		return false;
	else
		return true;
	
}

//Controlla se c'� un trasferimento in ingresso per quest'animale
private boolean animaleInArrivo(Animale animale, BUtente utente)
{
	for(Trasferimento t : utente.getClinica().getTrasferimentiIngresso())
	{
		if( t.getStato().getStato()!=1 && 
			t.getStato().getStato()!=6 && 
			t.getDataAccettazioneDestinatario()==null && 
			t.getCartellaClinica().getAccettazione().getAnimale()==animale)
			return true;
	}
	return false;
}



//Controlla se esiste un'accettazione pi� recente per l'animale in questa clinica
public String controlloDataAccettazioniRecenti(String idAnimale, String idUtente, String dataImmessa, int idClinica)
{
	try
	{
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date data = sdf.parse(dataImmessa);
		Persistence persistence 								 = PersistenceFactory.getPersistence();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		Animale animale 									 	 = getAnimale(Integer.parseInt(idAnimale), persistence);
		Accettazione accettazione 								 = null;
		String messaggio 										 = "";
		
		if((accettazione = animale.getAccettazionePiuRecenteByClinica(idClinica))!=null && accettazione.getData().after(data))
			messaggio = "Salvataggio impossibile: esiste un'accettazione pi� recente: " + accettazione.getProgressivoFormattato();
		PersistenceFactory.closePersistence( persistence, true );
		GenericAction.aggiornaConnessioneChiusaSessione(req);
		
		return messaggio;
	}
	catch(Exception e)
	{
		e.printStackTrace();
		return "";
	}
}


private Integer getIdTipoAttivitaBdrCompletata(CartellaClinica cc)
{
	Integer idTipoAttivitaBdr = null;
	Iterator<AttivitaBdr> iter = cc.getAttivitaBdrs().iterator();
	while(iter.hasNext())
	{
		AttivitaBdr att = iter.next();
		if(att.getIdRegistrazioneBdr()!=null && att.getIdRegistrazioneBdr()>0 && att.getOperazioneBdr().getId()!=IdOperazioniBdr.sterilizzazione)
			idTipoAttivitaBdr = att.getOperazioneBdr().getId();
	}
	return idTipoAttivitaBdr;
}

//Verifico in BDR
	private boolean nonEffettuabileInBdr(LookupOperazioniAccettazione operazione, RegistrazioniInterface opEffettuabiliBdr, Integer idTipoTrasf, Connection connection, Connection connectionBdu, BUtente utente, AnimaleNoH animale, boolean intraFuoriAsl, boolean versoAssocCanili) throws Exception
	{
		Integer idTipoPrevistaInBdu = null;
		boolean trasfPossibile = false;
		if(operazione.getId()==IdOperazioniBdr.trasferimento)
		{
			idTipoPrevistaInBdu = RegistrazioniUtil.getIdTipoBdrPreAcc(animale, idTipoTrasf, intraFuoriAsl, versoAssocCanili, operazione, connection, connectionBdu,req);
			System.out.println("id tipo prevista in bdu: " + idTipoPrevistaInBdu);
			if(idTipoPrevistaInBdu==IdOperazioniInBdr.trasferimento)
				trasfPossibile = opEffettuabiliBdr.getTrasferimento()!=null && opEffettuabiliBdr.getTrasferimento();
			else if(idTipoPrevistaInBdu==IdOperazioniInBdr.adozioneDaCanile || idTipoPrevistaInBdu==IdOperazioniInBdr.adozioneDaColonia)
				trasfPossibile = opEffettuabiliBdr.getAdozione()!=null && opEffettuabiliBdr.getAdozione();
			else if(idTipoPrevistaInBdu==IdOperazioniInBdr.cessione)
				trasfPossibile = opEffettuabiliBdr.getCessione()!=null && opEffettuabiliBdr.getCessione();
			else if(idTipoPrevistaInBdu==IdOperazioniInBdr.adozioneFuoriAsl)
				trasfPossibile = opEffettuabiliBdr.getAdozioneFuoriAsl()!=null && opEffettuabiliBdr.getAdozioneFuoriAsl();
			else if(idTipoPrevistaInBdu==IdOperazioniInBdr.adozioneVersoAssocCanili)
				trasfPossibile = opEffettuabiliBdr.getAdozioneVersoAssocCanili()!=null && opEffettuabiliBdr.getAdozioneVersoAssocCanili();
			else if(idTipoPrevistaInBdu==IdOperazioniInBdr.trasferimentoFuoriRegione)
				trasfPossibile = opEffettuabiliBdr.getTrasfRegione()!=null && opEffettuabiliBdr.getTrasfRegione();
			else if(idTipoPrevistaInBdu==IdOperazioniInBdr.trasferimentoResidenzaProprietario)
				trasfPossibile = opEffettuabiliBdr.getTrasferimentoResidenzaProp()!=null && opEffettuabiliBdr.getTrasferimentoResidenzaProp();
		}
				
		System.out.println("operazione id: "  + operazione.getId());
		System.out.println("trasferimento: "  + IdOperazioniBdr.trasferimento);
		System.out.println("trasfPossibile: " + trasfPossibile);
		
		return (operazione.getId() == IdOperazioniBdr.adozione && intraFuoriAsl==false && (opEffettuabiliBdr.getAdozione()==null || !opEffettuabiliBdr.getAdozione())) ||
			   (operazione.getId() == IdOperazioniBdr.adozione && intraFuoriAsl    && (opEffettuabiliBdr.getAdozioneFuoriAsl()==null         || !opEffettuabiliBdr.getAdozioneFuoriAsl())) ||
			   (operazione.getId() == IdOperazioniBdr.adozione && versoAssocCanili && (opEffettuabiliBdr.getAdozioneVersoAssocCanili()==null || !opEffettuabiliBdr.getAdozioneVersoAssocCanili())) ||
			   (operazione.getId() == IdOperazioniBdr.furto 			&& (opEffettuabiliBdr.getFurto()==null || !opEffettuabiliBdr.getFurto())) ||
			   (operazione.getId() == IdOperazioniBdr.decesso 			&& (opEffettuabiliBdr.getDecesso()==null || !opEffettuabiliBdr.getDecesso())) ||
			   (operazione.getId() == IdOperazioniBdr.trasferimento 	&& !trasfPossibile) ||
			   (operazione.getId() == IdOperazioniBdr.smarrimento 		&& (opEffettuabiliBdr.getSmarrimento()==null || !opEffettuabiliBdr.getSmarrimento())) ||
			   (operazione.getId() == IdOperazioniBdr.ritrovamento 		&& (opEffettuabiliBdr.getRitrovamento()==null || !opEffettuabiliBdr.getRitrovamento())) ||
			   (operazione.getId() == IdOperazioniBdr.sterilizzazione   && (opEffettuabiliBdr.getSterilizzazione()==null || !opEffettuabiliBdr.getSterilizzazione())) ||
			   (operazione.getId() == IdOperazioniBdr.ritrovamentoSmarrNonDenunciato && (opEffettuabiliBdr.getRitrovamentoSmarrNonDenunciato()==null || !opEffettuabiliBdr.getRitrovamentoSmarrNonDenunciato())) ||
			   (operazione.getId() == IdOperazioniBdr.passaporto 		&&(opEffettuabiliBdr.getPassaporto()==null || !opEffettuabiliBdr.getPassaporto())) ||
			   (operazione.getId() == IdOperazioniBdr.rinnovoPassaporto 		&&(opEffettuabiliBdr.getRinnovoPassaporto()==null || !opEffettuabiliBdr.getRinnovoPassaporto())) ||
			   (operazione.getId() == IdOperazioniBdr.prelievoDna 		&&(opEffettuabiliBdr.getPrelievoDna()==null || !opEffettuabiliBdr.getPrelievoDna())) ||
			   (operazione.getId() == IdOperazioniBdr.prelievoLeishmania &&(opEffettuabiliBdr.getPrelievoLeishmania()==null || !opEffettuabiliBdr.getPrelievoLeishmania()));
		
	}
	
	
	
	
	
	//Se il richiedente � un'associazione, il ritrovamento si pu� fare in ogni caso
		private boolean verificaRichiedenteAssociazione(int idRichiedente, LookupOperazioniAccettazione operazione)
		{
			return idRichiedente==TipiRichiedente.ASSOCIAZIONE && operazione.getId()==IdOperazioniBdr.ritrovamento;
		}
		
		//Se un'operazione abilitante � stata selezionata, allora l'operazione che stiamo esaminando si pu� fare in ogni caso
		private boolean operazioneAbilitanteSelezionata(Set<LookupOperazioniAccettazione> opSelezionate, LookupOperazioniAccettazione operazione)
		{
			Iterator<LookupOperazioniAccettazione> opSelezionateIter = opSelezionate.iterator();
			while(opSelezionateIter.hasNext())
			{
				LookupOperazioniAccettazione opTemp = opSelezionateIter.next();
				Iterator<LookupOperazioniAccettazioneCondizionate> opCondizionate = opTemp.getOperazioniCondizionate().iterator();
				while(opCondizionate.hasNext())
				{
					LookupOperazioniAccettazioneCondizionate opCondizionateTemp = opCondizionate.next();
					if(opCondizionateTemp.getOperazioneCondizionata()==operazione && opCondizionateTemp.getOperazioneDaFare().equals("enable"))
						return true;
				}
			}
			return false;
		}
		
		//Se un'operazione disabilitante � stata selezionata, allora l'operazione che stiamo esaminando non si pu� fare in ogni caso
		private LookupOperazioniAccettazione operazioneDisabilitanteSelezionata(Set<LookupOperazioniAccettazione> opSelezionate, LookupOperazioniAccettazione operazione)
		{
			Iterator<LookupOperazioniAccettazione> opSelezionateIter = opSelezionate.iterator();
			while(opSelezionateIter.hasNext())
			{
				LookupOperazioniAccettazione opTemp = opSelezionateIter.next();
				Iterator<LookupOperazioniAccettazioneCondizionate> opCondizionate = opTemp.getOperazioniCondizionate().iterator();
				while(opCondizionate.hasNext())
				{
					LookupOperazioniAccettazioneCondizionate opCondizionateTemp = opCondizionate.next();
					if(opCondizionateTemp.getOperazioneCondizionata()==operazione && opCondizionateTemp.getOperazioneDaFare().equals("disable"))
						return opCondizionateTemp.getOperazioneCondizionante();
				}
			}
			return null;
		
		}
		
		//Verifico se non � possibile per animali deceduti
		private boolean nonEffettuabileAnimaliDeceduti(LookupOperazioniAccettazione operazione, AnimaleNoH animale, BUtente utente, Persistence persistence,Connection connection) throws Exception
		{
			Date dataDecesso = null;
			if(animale.getLookupSpecie().getId()==SpecieAnimali.cane && CaninaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection ,req)!=null)
				dataDecesso = CaninaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection ,req).getDataEvento();
			else if(animale.getLookupSpecie().getId()==SpecieAnimali.gatto && FelinaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection,req )!=null)
				dataDecesso = FelinaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, new ServicesStatus(), connection ,req).getDataEvento();
			else if(animale.getLookupSpecie().getId()==SpecieAnimali.sinantropo && SinantropoUtil.getInfoDecesso(persistence, animale)!=null)
				dataDecesso = SinantropoUtil.getInfoDecesso(persistence, animale).getDataEvento();
			return !(operazione.getEffettuabileDaMorto()==null || operazione.getEffettuabileDaMorto()) && (animale.getDecedutoNonAnagrafe() || dataDecesso!=null);
		}
		
		
		private boolean mustRicattura(Animale animale, Connection connection,Set<LookupOperazioniAccettazione> operazioni) throws ClassNotFoundException, ParseException, SQLException, NamingException
		{
			Iterator<LookupOperazioniAccettazione> opSelezionateIter = operazioni.iterator();
			boolean decessoSelezionato = false;
			while(opSelezionateIter.hasNext())
			{
				LookupOperazioniAccettazione op = opSelezionateIter.next();
				if(op.getId() == IdOperazioniBdr.decesso)
				{
					decessoSelezionato=true;
					break;
				}
			}
			
			RegistrazioniInterface opEffettuabiliBdr = AnimaliUtil.findRegistrazioniEffettuabili( connection, animale, utente, connection,req );
			if((animale.getLookupSpecie().getId()!=Specie.SINANTROPO && opEffettuabiliBdr.getRicattura()) && !decessoSelezionato)
				return true;
			else 
				return false;
			
		}
		
		private AccettazioneNoH popolaBean(AccettazioneNoH accettazione, int i) 
		{
			accettazione.setProprietarioCap(req.getParameter("cap"+i));
			accettazione.setProprietarioCognome(req.getParameter("proprietarioCognome"+i));
			accettazione.setSterilizzato(Boolean.parseBoolean(req.getParameter("sterilizzato"+i)));
			accettazione.setRandagio(Boolean.parseBoolean(req.getParameter("randagio"+i)));
			accettazione.setProprietarioTelefono(req.getParameter("proprietarioTelefono"+i));
			accettazione.setProprietarioProvincia(req.getParameter("proprietarioProvincia"+i));
			accettazione.setProprietarioComune(req.getParameter("proprietarioComune"+i));
			accettazione.setProprietarioIndirizzo(req.getParameter("proprietarioIndirizzo"+i));
			accettazione.setProprietarioDocumento(req.getParameter("proprietarioDocumento"+i));
			accettazione.setProprietarioCodiceFiscale(req.getParameter("proprietarioCodiceFiscale"+i));
			accettazione.setProprietarioNome(req.getParameter("proprietarioNome"+i));
			accettazione.setProprietarioTipo(req.getParameter("proprietarioTipo"+i));
			return accettazione;
		}
		
}










