package it.us.web.action.sinantropi;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.sinantropi.lookup.LookupSinantropiEta;
import it.us.web.bean.sinantropi.lookup.LookupSpecieSinantropi;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToEdit extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_anagrafica");
	}

	public void execute() throws Exception
	{
		int idSinantropo = interoFromRequest("idSinantropo");
		
		Sinantropo s = (Sinantropo)persistence.find(Sinantropo.class, idSinantropo);
		
		ArrayList<LookupSpecieSinantropi> listUccelli = (ArrayList<LookupSpecieSinantropi>) persistence.createCriteria( LookupSpecieSinantropi.class )
		.add( Restrictions.eq( "uccello", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();	
		
		ArrayList<LookupSpecieSinantropi> listMammiferi = (ArrayList<LookupSpecieSinantropi>) persistence.createCriteria( LookupSpecieSinantropi.class )
		.add( Restrictions.eq( "mammifero", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();
		
		ArrayList<LookupSpecieSinantropi> listRettiliAnfibi = (ArrayList<LookupSpecieSinantropi>) persistence.createCriteria( LookupSpecieSinantropi.class )
		.add( Restrictions.eq( "rettileAnfibio", true ) )
		.addOrder( Order.asc( "level" ) )
		.list();
		
		ArrayList<LookupTaglie>		taglie		= (ArrayList<LookupTaglie>) persistence.createCriteria( LookupTaglie.class )
		.add( Restrictions.eq( "enabled", true ) )
		.addOrder( Order.asc( "level" ) )
		.addOrder( Order.asc( "description" ) ).list();
		
		ArrayList<LookupSinantropiEta> listEta = (ArrayList<LookupSinantropiEta>) persistence.createCriteria( LookupSinantropiEta.class )
				.list();
		
				
		req.setAttribute("taglie", taglie);
		req.setAttribute("s", s);
		req.setAttribute("listUccelli", listUccelli);
		req.setAttribute("listMammiferi", listMammiferi);
		req.setAttribute("listRettiliAnfibi", listRettiliAnfibi);
		req.setAttribute("listEta", listEta);
		
		gotoPage("sinantropi_default","/jsp/sinantropi/edit.jsp");
	}
}

