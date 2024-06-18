package it.us.web.action.vam.cc.ehrlichiosi;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ehrlichiosi;
import it.us.web.bean.vam.lookup.LookupEhrlichiosiEsiti;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;


public class ToEdit extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ehrlichiosi");
	}

	public void execute() throws Exception
	{

			int id = interoFromRequest("idEhrlichiosi");		
						
			//Recupero Bean Ehrlichiosi
			Ehrlichiosi e = (Ehrlichiosi) persistence.find(Ehrlichiosi.class, id);
			ArrayList<LookupEhrlichiosiEsiti> listEsiti = (ArrayList<LookupEhrlichiosiEsiti>) persistence.findAll(LookupEhrlichiosiEsiti.class);
		
		
			req.setAttribute("e", e);	
			req.setAttribute("listEsiti", listEsiti);		
		
			gotoPage("/jsp/vam/cc/ehrlichiosi/edit.jsp");

	}
}

