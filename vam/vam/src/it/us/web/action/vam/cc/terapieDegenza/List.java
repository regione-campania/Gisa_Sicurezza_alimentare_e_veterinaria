package it.us.web.action.vam.cc.terapieDegenza;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.TerapiaDegenza;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class List extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "LIST", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("terapia");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		//Recupero di tutte le terapie
		ArrayList<TerapiaDegenza> tdList = (ArrayList<TerapiaDegenza>) persistence.getNamedQuery("GetTerapieDegenzaByCC").setInteger("idCartellaClinica", idCc).list();
		
		//Recupero terapie separate per tipo
		ArrayList<TerapiaDegenza> tdListFarm  = (ArrayList<TerapiaDegenza>) persistence.getNamedQuery("GetTerapieDegenzaByCCFarmacologica").setInteger("idCartellaClinica", idCc).list();
		ArrayList<TerapiaDegenza> tdListAltra = (ArrayList<TerapiaDegenza>) persistence.getNamedQuery("GetTerapieDegenzaByCCAltra").setInteger("idCartellaClinica", idCc).list();

		//Controllo esistenza farmaci in magazzino
		ArrayList<MagazzinoFarmaci> mfList 
		= (ArrayList<MagazzinoFarmaci>) persistence.getNamedQuery("GetFarmaciByClinica").setInteger("idClinica", utente.getClinica().getId()).list();
		
		boolean esisteMagazzinoFarmaci = mfList!=null && !mfList.isEmpty(); 

		req.setAttribute("esisteMagazzinoFarmaci", esisteMagazzinoFarmaci);
		
		req.setAttribute("tdList", tdList);
		req.setAttribute("numeroTerapieFarmacologiche", tdListFarm.size());
		req.setAttribute("numeroAltreTerapie", 			tdListAltra.size());
				
		gotoPage("/jsp/vam/cc/terapieDegenza/list.jsp");
	}
}
