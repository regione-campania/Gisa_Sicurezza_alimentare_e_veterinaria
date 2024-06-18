package it.us.web.action.vam.cc.diagnosticaImmagini.tac;

import java.util.Date;
import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Tac;
import it.us.web.dao.GuiViewDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;

public class Add extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("tac");
	}

	public void execute() throws Exception
	{
		
		final Logger logger = LoggerFactory.getLogger(Add.class);

		Tac tac = new Tac();
		
		BeanUtils.populate(tac, req.getParameterMap());				
		tac.setEntered(new Date());		
		tac.setEnteredBy(utente);
		tac.setCartellaClinica( cc );	
		
		validaBean( tac , new ToAdd() );
		
		try {
			persistence.insert(tac);		
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(tac);
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
			logger.error("Cannot save TAC" + e.getMessage());
			throw e;		
		}
		
		setMessaggio("TAC aggiunta");
		redirectTo("vam.cc.diagnosticaImmagini.tac.List.us");
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta Tac";
	}
}
