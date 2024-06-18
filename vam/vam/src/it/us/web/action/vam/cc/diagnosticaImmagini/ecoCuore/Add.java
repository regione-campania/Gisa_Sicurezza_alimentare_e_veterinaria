package it.us.web.action.vam.cc.diagnosticaImmagini.ecoCuore;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EcoCuore;
import it.us.web.bean.vam.EcoCuoreEsito;
import it.us.web.bean.vam.lookup.LookupEcoCuoreAnomalia;
import it.us.web.bean.vam.lookup.LookupEcoCuoreDiagnosi;
import it.us.web.bean.vam.lookup.LookupEcoCuoreTipo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;
import org.hibernate.criterion.Restrictions;

public class Add extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ecoCuore");
	}

	public void execute() throws Exception
	{
		
		final Logger logger = LoggerFactory.getLogger(Add.class);

		EcoCuore ecoCuore = new EcoCuore();
		
		BeanUtils.populate(ecoCuore, req.getParameterMap());				
		
		
		//GESTIONE ESITI ESAME B-MODE
		//Inizializzo la lista di Esiti
		Set<EcoCuoreEsito> esiti = new HashSet<EcoCuoreEsito>();
		
		//Itero i tipi
		Iterator<LookupEcoCuoreTipo> tipi = (Iterator<LookupEcoCuoreTipo>) persistence.findAll(LookupEcoCuoreTipo.class).listIterator();
		while(tipi.hasNext())
		{
			LookupEcoCuoreTipo tipo = tipi.next();
			
			//Se l'esito per quel tipo � Normale
			if(stringaFromRequest("_"+tipo.getId()).equals("Normale"))
			{
				EcoCuoreEsito esito = new EcoCuoreEsito();
				esito.setEcoCuore(ecoCuore);
				esito.setEnabled(true);
				esito.setLookupEcoCuoreTipo(tipo);
				esito.setNormale(true);
				esiti.add(esito);
			}
			//Se l'esito per quel tipo � Anormale
			else if(stringaFromRequest("_"+tipo.getId()).equals("Anormale"))
			{
				//Itero le anomalie possibili su quel tipo
				Iterator<LookupEcoCuoreAnomalia> anomalie = (Iterator<LookupEcoCuoreAnomalia>) persistence.createCriteria( LookupEcoCuoreAnomalia.class )
				.add( Restrictions.eq( "lookupEcoCuoreTipo.id",  tipo.getId() )).list().iterator();
				while(anomalie.hasNext())
				{
					LookupEcoCuoreAnomalia anomalia = anomalie.next();
					if(stringaFromRequest("anomalia_"+anomalia.getId())!=null)
					{
						EcoCuoreEsito esito = new EcoCuoreEsito();
						esito.setEcoCuore(ecoCuore);
						esito.setEnabled(true);
						esito.setLookupEcoCuoreTipo(tipo);
						esito.setNormale(false);
						esito.setLookupEcoCuoreAnomalia(anomalia);
						esiti.add(esito);
					}
				}
				
				
			}
		}
		//FINE GESTIONE ESITI ESAME B-MODE
		
		
		//Gestione Lookup Diagnosi
		Set<LookupEcoCuoreDiagnosi> diagnosi = objectList(LookupEcoCuoreDiagnosi.class, "diagnosi_");
		
		
		//Controllo che sia stata selezionata almeno una diagnosi
		if(!diagnosi.isEmpty())
		{
			ecoCuore.setLookupEcoCuoreDiagnosis(diagnosi);
		}
		//Fine Gestione Lookup Diagnosi
		
		
		
		ecoCuore.setEntered(new Date());		
		ecoCuore.setEnteredBy(utente);
		ecoCuore.setCartellaClinica( cc );	
		
		validaBean( ecoCuore , new ToAdd() );
			
		try {
			persistence.insert(ecoCuore);
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(ecoCuore);
			}
			
			Iterator<EcoCuoreEsito> iter = esiti.iterator();
			while( iter.hasNext() )
			{
				EcoCuoreEsito e = iter.next();
						
				persistence.insert(e);		
				if(cc.getDataChiusura()!=null)
				{
					beanModificati.add(e);
				}
			}
			
			cc.setModified( new Date() );
			cc.setModifiedBy( utente );
			persistence.update( cc );
			persistence.commit();
		}
		catch (RuntimeException e)
		{
			try
			{		
				persistence.rollBack();				
			}
			catch (HibernateException e1)
			{				
				logger.error("Error during Rollback transaction" + e1.getMessage());
			}
			logger.error("Cannot save Eco-Cuore" + e.getMessage());
			throw e;		
		}
		
		
		setMessaggio("Eco-Cuore aggiunto");
		redirectTo("vam.cc.diagnosticaImmagini.ecoCuore.List.us");
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta Eco-cuore";
	}
}
