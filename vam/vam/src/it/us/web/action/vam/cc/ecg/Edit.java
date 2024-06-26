package it.us.web.action.vam.cc.ecg;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.lookup.LookupAritmie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;

public class Edit extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ecg");
	}

	public void execute() throws Exception
	{
		
		final Logger logger = LoggerFactory.getLogger(Edit.class);

		int idEcg  = interoFromRequest("idEcg");
		String diagnosi = stringaFromRequest("diagnosi");
		
		//Recupero Bean ECG
		Ecg ecg  = (Ecg) persistence.find(Ecg.class, idEcg);
		
		BeanUtils.populate(ecg, req.getParameterMap());
		
		Set<LookupAritmie> aritmie = objectList(LookupAritmie.class, "aritmia_");
		Iterator<LookupAritmie> aritmieIterator = objectList(LookupAritmie.class, "aritmia_").iterator();
		
		//Controllo che sia stata selezionata un'aritmia: in tal caso diagnosi = P(positiva)
		if(diagnosi==null && aritmieIterator.hasNext())
		{
			ecg.setDiagnosi("P");
			ecg.setAritmie(aritmie);
		}
		else if(diagnosi==null && !aritmieIterator.hasNext())
		{
			ecg.setDiagnosi(null);
			ecg.setAritmie(null);
		}
		else
			ecg.setDiagnosi("N");
		
		ecg.setModified(new Date());
		ecg.setModifiedBy(utente);
		
		validaBean( ecg , new ToEdit() );
		
		try 
		{
			persistence.update(ecg);
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(ecg);
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
			logger.error("Cannot edit ECG" + e.getMessage());
			throw e;		
		}
					
		
		setMessaggio("Modica dell'ECG eseguita");
		redirectTo( "vam.cc.ecg.List.us" );	
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Ecg";
	}
}


