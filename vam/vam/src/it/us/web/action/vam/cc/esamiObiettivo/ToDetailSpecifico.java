package it.us.web.action.vam.cc.esamiObiettivo;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameObiettivo;
import it.us.web.bean.vam.EsameObiettivoEsito;
import it.us.web.bean.vam.EsameObiettivoPatologieCongenite;
import it.us.web.bean.vam.EsameObiettivoSintoPatologia;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoApparati;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoEsito;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoInsorgenzaSintomi;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoPeriodoInsorgenzaSintomi;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoSintomi;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoTipo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.vam.CartellaClinicaDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class ToDetailSpecifico extends GenericAction 
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("esameObiettivo");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		connection = ds.getConnection();
		
		int idApparato		  = interoFromRequest( "idApparato" );
		
		//Recupero Bean Apparati
		LookupEsameObiettivoApparati leoa = (LookupEsameObiettivoApparati) persistence.find(LookupEsameObiettivoApparati.class, idApparato);
		req.setAttribute( "apparato", leoa );
		
		System.out.println("Apparato " + leoa.getDescription());
		
		ArrayList<LookupEsameObiettivoTipo> listEsameObiettivoTipo = (ArrayList<LookupEsameObiettivoTipo>) persistence.createCriteria( LookupEsameObiettivoTipo.class )
			.add( Restrictions.eq( "specifico", true ) )	
			.add( Restrictions.eq( "lookupEsameObiettivoApparati.id", leoa.getId() ) )
			.list();
		
		int sizeEsameObiettivoTipo = listEsameObiettivoTipo.size();	
				
		ArrayList<ArrayList<LookupEsameObiettivoEsito>> superList   = new ArrayList();
		ArrayList<ArrayList<LookupEsameObiettivoEsito>> superListFigli   = new ArrayList();
		
		
		ArrayList<String> descrizioniEOTipo 						= new ArrayList();
		
		for (int i = 0; i < sizeEsameObiettivoTipo; i++) {
			
			LookupEsameObiettivoTipo leot = (LookupEsameObiettivoTipo) listEsameObiettivoTipo.get(i);
			
			ArrayList<LookupEsameObiettivoEsito> listEsameObiettivo = (ArrayList<LookupEsameObiettivoEsito>) persistence.createCriteria( LookupEsameObiettivoEsito.class )
			.add( Restrictions.eq( "lookupEsameObiettivoTipo.id", leot.getId() ) )	
			.add( Restrictions.isNull("lookupEsameObiettivoEsito") )
			.list();					
						
			descrizioniEOTipo.add(listEsameObiettivo.get(0).getLookupEsameObiettivoTipo().getDescription());
			superList.add(listEsameObiettivo);
			
		}
		
		
		// La lista di tutti i padri
		ArrayList<LookupEsameObiettivoEsito> listEsameObiettivoFigliList = (ArrayList<LookupEsameObiettivoEsito>) persistence.createCriteria( LookupEsameObiettivoEsito.class )			
		.add( Restrictions.isNotNull("lookupEsameObiettivoEsito") )	
		.list();
		
		HashMap<Integer, Integer> listEsameObiettivoPadri = new HashMap<Integer,Integer>();
		Iterator<LookupEsameObiettivoEsito> listEsameObiettivoFigliIter = listEsameObiettivoFigliList.iterator();
		Integer id = null;
		while(listEsameObiettivoFigliIter.hasNext())
		{
			id = listEsameObiettivoFigliIter.next().getLookupEsameObiettivoEsito().getId();
			listEsameObiettivoPadri.put(id, id);
		}

		req.setAttribute("listEsameObiettivoPadri", listEsameObiettivoPadri);
		req.setAttribute("listEsameObiettivoFigliList", listEsameObiettivoFigliList);
		req.setAttribute("superList", superList);
		req.setAttribute("descrizioniEOTipo", descrizioniEOTipo);
		req.setAttribute("idApparato", idApparato);
		req.setAttribute("esameObiettivo", leoa );
		
		ArrayList<EsameObiettivo> esameObiettivos = CartellaClinicaDAO.getEsameObiettivos(cc.getId(),connection);
		req.setAttribute("esameObiettivos",esameObiettivos);
		
		
		/*Nel caso la cartella clinica contiene gi� degli esami obiettivo
		 * lo scopo � quello di visualizzare nella pagina di edit gli esiti gi�
		 * checkati in precedenza.*/
		if( CartellaClinicaDAO.getEsamiObiettivoApparato( leoa,esameObiettivos ).size() > 0 )
		{	
			
			ArrayList<EsameObiettivoEsito> superListChecked = new ArrayList();
						
			req.setAttribute( "dataEsame", CartellaClinicaDAO.getEsamiObiettivoApparato( leoa, esameObiettivos ).iterator().next().getDataEsameObiettivo());
			
			Iterator eoList = CartellaClinicaDAO.getEsamiObiettivoApparato( leoa, esameObiettivos ).iterator();
			
			while(eoList.hasNext()) {
				EsameObiettivo eo = (EsameObiettivo)eoList.next();
				if(eo.getEsameObiettivoEsitos().size()>0) {
					Iterator eoeList = eo.getEsameObiettivoEsitos().iterator();
					while(eoeList.hasNext()) {
						EsameObiettivoEsito eoeRe = (EsameObiettivoEsito) eoeList.next();						
						superListChecked.add(eoeRe);
					}
				}
			}
			req.setAttribute("superListChecked", superListChecked);
			
		}
		
		
		
		/**
		 * Gestione sezione SINTOMATOLOGIA/PATOLOGIA
		 */
		 //caricamento elenco possibili sintomi
		ArrayList<LookupEsameObiettivoSintomi> sintomi = (ArrayList<LookupEsameObiettivoSintomi>) persistence.createCriteria( LookupEsameObiettivoSintomi.class )
			.add( Restrictions.eq( "apparato", leoa ) )
			.addOrder( Order.asc( "level" ) )
			.addOrder( Order.asc( "description" ) )
			.list();
		
		//caricamento elenco possibili insorgenze sintomi
		ArrayList<LookupEsameObiettivoInsorgenzaSintomi> insorgenze = (ArrayList<LookupEsameObiettivoInsorgenzaSintomi>) persistence.createCriteria( LookupEsameObiettivoInsorgenzaSintomi.class )
			.add( Restrictions.eq( "apparato", leoa ) )
			.addOrder( Order.asc( "level" ) )
			.addOrder( Order.asc( "description" ) )
			.list();
		
		//caricamento elenco possibili periodi insorgenze sintomi
		ArrayList<LookupEsameObiettivoPeriodoInsorgenzaSintomi> periodoInsorgenze = (ArrayList<LookupEsameObiettivoPeriodoInsorgenzaSintomi>) persistence
			.createCriteria( LookupEsameObiettivoPeriodoInsorgenzaSintomi.class )
				.add( Restrictions.eq( "apparato", leoa ) )
				.addOrder( Order.asc( "level" ) )
				.addOrder( Order.asc( "description" ) )
			.list();
		
		//caricamento record SINTOMATOLOGIA/PATOLOGIA eventualmente gi� presente
		ArrayList<EsameObiettivoSintoPatologia> sintopat = (ArrayList<EsameObiettivoSintoPatologia>) persistence.createCriteria( EsameObiettivoSintoPatologia.class )
			.add( Restrictions.eq( "cartellaClinica", cc ) )
			.add( Restrictions.eq( "apparato", leoa ) )
			.list();

		
		//caricamento record PATOLOGIE CONGENITE eventualmente gi� presente
		List<EsameObiettivoPatologieCongenite> patologieCongenite = persistence.createCriteria( EsameObiettivoPatologieCongenite.class )
			.add( Restrictions.eq( "cartellaClinica", cc ) )
			.add( Restrictions.eq( "apparato", leoa ) )
			.list();
		
		
		req.setAttribute( "sintomi", sintomi );
		req.setAttribute( "insorgenze", insorgenze );
		req.setAttribute( "periodoInsorgenze", periodoInsorgenze );
		if( sintopat.size() > 0 )
		{
			req.setAttribute( "sintopatologia", sintopat.get( 0 ) );
		}
		if( patologieCongenite.size() > 0 )
		{
			req.setAttribute( "patologieCongenite", patologieCongenite.get( 0 ) );
		}
		
		
		
		
		if( CartellaClinicaDAO.getEsamiObiettivoApparato( leoa,esameObiettivos ).size() > 0 || sintopat.size() > 0 )
			gotoPage( "/jsp/vam/cc/esamiObiettivo/detailSpecifico.jsp" );
		else
			gotoPage( "/jsp/vam/cc/esamiObiettivo/edit.jsp" );
	}

}

