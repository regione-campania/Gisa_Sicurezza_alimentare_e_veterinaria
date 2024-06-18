package it.us.web.action.sinantropi.catture;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Catture;
import it.us.web.bean.sinantropi.Detenzioni;
import it.us.web.bean.sinantropi.Reimmissioni;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.sinantropi.lookup.LookupDetentori;
import it.us.web.bean.sinantropi.lookup.LookupSpecieSinantropi;
import it.us.web.bean.sinantropi.lookup.LookupTipiDocumento;
import it.us.web.bean.vam.lookup.LookupComuni;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.HibernateException;
import org.hibernate.criterion.Order;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Add extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_cattura");
	}

	public void execute() throws Exception
	{
		final Logger logger = LoggerFactory.getLogger(Add.class);
					
		int idSinantropo = interoFromRequest("idSinantropo");
		
		Sinantropo s = (Sinantropo) persistence.find(Sinantropo.class, idSinantropo);
				
		/*GESTIONE CATTURA*/		
		Catture c = new Catture();
		BeanUtils.populate(c, req.getParameterMap());	
		
		c.setEntered(new Date());		
		c.setEnteredBy(utente);
		c.setModified(new Date());		
		c.setModifiedBy(utente);
		
		String provinciaCattura = stringaFromRequest("provinciaCattura");
		int comuneCattura = 0; 
		
		if (provinciaCattura.equals("BN"))		
			comuneCattura = interoFromRequest("comuneCatturaBN");
		else if (provinciaCattura.equals("NA"))	
			comuneCattura = interoFromRequest("comuneCatturaNA");
		else if (provinciaCattura.equals("SA"))	
			comuneCattura = interoFromRequest("comuneCatturaSA");
		else if (provinciaCattura.equals("CE"))	
			comuneCattura = interoFromRequest("comuneCatturaCE");
		else if (provinciaCattura.equals("AV"))	
			comuneCattura = interoFromRequest("comuneCatturaAV");
				
		
	/*	ArrayList<LookupComuni> listComuni = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
		.addOrder( Order.asc( "level" ) )
		.list(); */
		
		ArrayList<LookupComuni> listComuni = (ArrayList<LookupComuni>)req.getServletContext().getAttribute("listComuni");
		
		LookupComuni lc = null;
		
		Iterator listComuniIterator = listComuni.iterator();
		
		Set<Catture> setCatture = new HashSet<Catture>(0);
		while(listComuniIterator.hasNext()) {			
			lc = (LookupComuni) listComuniIterator.next();			
			if (lc.getId() == comuneCattura) 
				c.setComuneCattura(lc);
		}
		c.setSinantropo(s);
		setCatture.add(c);
		s.setCattureis(setCatture);
			
		
		try {
			
			validaBean( s, new ToAdd()  );
			validaBean( c, new ToAdd()  );
			
			//Inserimento cattura
			if (dataFromRequest("dataCattura")!=null && !stringaFromRequest("provinciaCattura").equals("X")) {
				s.setLastOperation("RINVENIMENTO");
				persistence.insert(c);
			}
					
			//Inserimento Sinantropo
			persistence.update(s);								
		
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
			logger.error("Cannot update Sinantropo with Cattura" + e.getMessage());
			throw e;		
		}
		
		
		setMessaggio( "Registrazione del Rinvenimento effettuata" );		
		redirectTo  ( "sinantropi.catture.List.us?idSinantropo="+idSinantropo);
			
	}	
}



