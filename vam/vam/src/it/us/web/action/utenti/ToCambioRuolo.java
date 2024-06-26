package it.us.web.action.utenti;

import java.sql.SQLException;
import java.util.Vector;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BRuolo;
import it.us.web.bean.BUtente;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.RuoloDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.permessi.Permessi;

public class ToCambioRuolo extends GenericAction
{

	@Override
	public void can() throws AuthorizationException, SQLException
	{
		BGuiView gui = GuiViewDAO.getView( "AMMINISTRAZIONE", "UTENTI", "CAMBIO RUOLO" );
		Permessi.can( connection, utente, gui, "w" );
	}

	@Override
	public void execute() throws Exception
	{
		int					user_id	= interoFromRequest( "user_id" );
		BUtente				ut		= (BUtente)persistence.find( BUtente.class, user_id );
		
		req.setAttribute( "user_selected", ut );
		
		Vector<BRuolo> ruoli = RuoloDAO.getRuoli();
		req.setAttribute( "ruoli", ruoli );
		
		if( ut == null )
		{
			goToAction( new List() );
		}
		else
		{
			gotoPage( "/jsp/amministrazione/utenti/cambioRuolo.jsp" );
		}
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}

}
