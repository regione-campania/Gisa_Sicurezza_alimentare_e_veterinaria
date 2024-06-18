package it.us.web.action.vam.cc.trasferimenti;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Clinica;
import it.us.web.bean.vam.Trasferimento;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.exceptions.ValidationBeanException;

import java.util.Date;
import java.util.Set;

import org.apache.commons.beanutils.BeanUtils;

public class Add extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
		canCc(cc);
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("trasferimenti");
	}

	@SuppressWarnings("unchecked")
	public void execute() throws Exception
	{
		Trasferimento trasferimento = new Trasferimento();
		
		BeanUtils.populate( trasferimento, req.getParameterMap() );
		
		Boolean urgenza = booleanoFromRequest( "urgenza" );
			
		trasferimento.setCartellaClinica( cc );
		trasferimento.setOperazioniRichieste( (Set<LookupOperazioniAccettazione>) objectList( LookupOperazioniAccettazione.class, "op_" ) );

		
		trasferimento.setModified( new Date() );
		trasferimento.setModifiedBy( utente );
		trasferimento.setEntered( trasferimento.getModified() );
		trasferimento.setEnteredBy( utente );
		
		trasferimento.setClinicaOrigine( utente.getClinica() );
		trasferimento.setUrgenza( urgenza );
		
		//if( urgenza ) ora anche se non c'� urgenza si permette di scegliere la clinica di destinazione
		{
			Clinica cd = (Clinica) persistence.find( Clinica.class, interoFromRequest( "clinicaDestinazioneId" ) );
			trasferimento.setClinicaDestinazione( cd );
		}
		
		//La cartella clinica attuale viene chiusa dopo il trasferimento dell'animale
		cc.setDataChiusura(dataFromRequest("dataRichiesta"));
		
		
		
		validaBean( trasferimento,  new ToAdd()  );
		
		persistence.insert( trasferimento );
		cc.setModified( new Date() );
		cc.setModifiedBy( utente );
		
		cc.setDimissioniEntered(new Date());
		cc.setDimissioniEnteredBy(utente);
		
		persistence.update( cc );		
		persistence.commit();
		
		setMessaggio( "Richiesta di trasferimento eseguita con successo." );
		redirectTo( "vam.cc.trasferimenti.List.us" );
	}
}
