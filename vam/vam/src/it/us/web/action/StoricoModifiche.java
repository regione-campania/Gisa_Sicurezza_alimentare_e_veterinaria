package it.us.web.action;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.bean.BUtenteAll;
import it.us.web.bean.UtentiOperazioni;
import it.us.web.bean.UtentiOperazioniModifiche;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ehrlichiosi;
import it.us.web.bean.vam.Leishmaniosi;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class StoricoModifiche extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "STORICO", "MAIN", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		//Poich� interessano le modifiche loggate(non tutti i click fatti dall'utente) metto che l'attributo "modifiche" non deve essere vuoto
				ArrayList<UtentiOperazioni> modifiche = (ArrayList<UtentiOperazioni>) persistence.createCriteria(UtentiOperazioni.class)
																						.add(Restrictions.isNotEmpty("modifiche"))
																						.addOrder(Order.desc("entered"))
																						.list();
				
				ArrayList<UtentiOperazioniModifiche> modifiche2 = (ArrayList<UtentiOperazioniModifiche>) persistence.createCriteria(UtentiOperazioniModifiche.class)
						.add(Restrictions.isNotNull("modifiche"))
						.add(Restrictions.eq("operazione", -1))
						.add(Restrictions.eq("nuovagestione", true))
						.addOrder(Order.desc("entered"))
						.list();
				
				ArrayList<UtentiOperazioni> union = new ArrayList<UtentiOperazioni>(); 
				
				for (int i=0; i<modifiche2.size();i++){
					UtentiOperazioni op = new UtentiOperazioni();
					UtentiOperazioniModifiche uom = modifiche2.get(i);
					op.setId(uom.getId());
					op.setEntered(uom.getEntered());
					BUtenteAll ut = UtenteDAO.getUtenteAll(uom.getUserid());
					op.setEnteredBy(ut);
					op.setModified(op.getEntered());
					op.setModifiedBy(op.getEnteredBy());
					op.setCc((CartellaClinica)persistence.find(CartellaClinica.class, uom.getIdcc()));
					op.setOperazione(uom.getUrloperazione());
					op.setDescrizioneOperazione(uom.getDescrizioneoperazione());
					op.setIp("nuovagestione");
					ut = UtenteDAO.getUtenteAll(uom.getUserid());
					op.setUsername(ut.getUsername());
					op.setModifiche(null);
					union.add(op);
				}
				
				union.addAll(modifiche);
				req.setAttribute("modifiche", union);
						
				gotoPage("/jsp/storicoModifiche.jsp");
	}
}



