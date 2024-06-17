package org.aspcfs.modules.richiesteerratacorrige.actions;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;

import org.aspcf.modules.controlliufficiali.base.Organization;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.opu.base.IndirizzoNotFoundException;
import org.aspcfs.modules.opu.base.Stabilimento;
import org.aspcfs.modules.ricercaunica.base.RicercaOpu;
import org.aspcfs.modules.richiesteerratacorrige.base.RichiestaErrataCorrige;
import org.aspcfs.modules.richiesteerratacorrige.base.RichiestaErrataCorrigeCampo;
import org.aspcfs.modules.sintesis.base.SintesisStabilimento;
import org.aspcfs.modules.suap.base.PecMailSender;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;

public class GestioneRichiesteErrataCorrige extends CFSModule {
	
	
	public String executeCommandGestioneRichiesteErrataCorrige(ActionContext context) throws IndirizzoNotFoundException{
		

		int riferimentoId = -1;
		String riferimentoIdNomeTab = context.getRequest().getParameter("riferimentoIdNomeTab");

		String riferimentoIdString = context.getRequest().getParameter("riferimentoId");
		if (riferimentoIdString==null)
			riferimentoIdString = (String) context.getRequest().getAttribute("riferimentoId");
		
		try {riferimentoId = Integer.parseInt(riferimentoIdString);} catch (Exception e){}
		
		Connection db = null;
		
		try {
			db = this.getConnection(context);
			
			ArrayList<RichiestaErrataCorrige> listaErrataCorrige = new ArrayList<RichiestaErrataCorrige>();
			
			String sql="select * from richieste_errata_corrige where 1=1 and riferimento_id = ? and riferimento_id_nome_tab = ? order by data desc";
			
			PreparedStatement pst = db.prepareStatement(sql);
			
				pst.setInt(1, riferimentoId);
				pst.setString(2, riferimentoIdNomeTab);
			
			ResultSet rs = pst.executeQuery();
			while (rs.next()){
				RichiestaErrataCorrige richiesta = new RichiestaErrataCorrige(rs);
				richiesta.setCampi(db);
				
				if (richiesta.getIdUtente() == getUserId(context) || hasPermission(context, "richieste_errata_corrige-edit"))
					listaErrataCorrige.add(richiesta);
			}
				RicercaOpu stab = null;
				
				if (riferimentoIdNomeTab.equals("opu_stabilimento")){
					stab = new RicercaOpu(db, riferimentoId, "id_stabilimento");
					Stabilimento stabcontainer = new Stabilimento(db, riferimentoId);
					context.getRequest().setAttribute("StabilimentoDettaglio", stabcontainer);
				}
				else if (riferimentoIdNomeTab.equals("organization")){
					stab = new RicercaOpu(db, riferimentoId, "org_id");
					Organization stabcontainer = new Organization();
					stabcontainer.queryRecord(db, riferimentoId);
					context.getRequest().setAttribute("OrgDetails", stabcontainer);
				}
				else if (riferimentoIdNomeTab.equals("sintesis_stabilimento")){
					stab = new RicercaOpu(db, riferimentoId, "alt_id");
					SintesisStabilimento stabcontainer = new SintesisStabilimento(db, riferimentoId,true);
					context.getRequest().setAttribute("StabilimentoSintesisDettaglio", stabcontainer);
				}
			context.getRequest().setAttribute("listaErrataCorrige", listaErrataCorrige);
			context.getRequest().setAttribute("Stabilimento", stab);
			context.getRequest().setAttribute("op", context.getRequest().getParameter("op"));

			//context.getRequest().setAttribute("RichiestaAppenaInserita", (RichiestaErrataCorrige) context.getRequest().getAttribute("RichiestaAppenaInserita"));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			this.freeConnection(context, db);
		}
		return "ListaErrataCorrigeOK";
	}

	public String executeCommandNuovaRichiestaErrataCorrige(ActionContext context) throws IndirizzoNotFoundException{

		int riferimentoId = -1;
		
		String riferimentoIdString = context.getRequest().getParameter("riferimentoId");
		String riferimentoIdNomeTab = context.getRequest().getParameter("riferimentoIdNomeTab");
	
		try {riferimentoId = Integer.parseInt(riferimentoIdString);} catch (Exception e){}

		String idControllo = context.getRequest().getParameter("idControllo");
		String contesto = context.getRequest().getParameter("contesto");
		
		context.getRequest().setAttribute("idControllo", idControllo);
		context.getRequest().setAttribute("contesto", contesto);

		Connection db = null;
		
		try {
			db = this.getConnection(context);
			
			LookupList LookupTipoInformazione = new LookupList(db,"richieste_errata_corrige_lookup_info_da_modificare");
			context.getRequest().setAttribute("LookupTipoInformazione", LookupTipoInformazione);
			LookupList LookupTipoMotivoCorrezione = new LookupList(db,"richieste_errata_corrige_lookup_motivo_correzione");
			context.getRequest().setAttribute("LookupMotivoCorrezione", LookupTipoMotivoCorrezione);
			
			RicercaOpu stab = null;
			if (riferimentoIdNomeTab.equals("opu_stabilimento")){
				stab = new RicercaOpu(db, riferimentoId, "id_stabilimento");
				Stabilimento stabcontainer = new Stabilimento(db, riferimentoId);
				context.getRequest().setAttribute("StabilimentoDettaglio", stabcontainer);
			}
			else if (riferimentoIdNomeTab.equals("organization")){
				stab = new RicercaOpu(db, riferimentoId, "org_id");
				Organization stabcontainer = new Organization();
				stabcontainer.queryRecord(db, riferimentoId);
				context.getRequest().setAttribute("OrgDetails", stabcontainer);
			}
			else if (riferimentoIdNomeTab.equals("sintesis_stabilimento")){
				stab = new RicercaOpu(db, riferimentoId, "alt_id");
				SintesisStabilimento stabcontainer = new SintesisStabilimento(db, riferimentoId,true);
				context.getRequest().setAttribute("StabilimentoSintesisDettaglio", stabcontainer);
			}

			context.getRequest().setAttribute("Stabilimento", stab);
			context.getRequest().setAttribute("op", context.getRequest().getParameter("op"));

			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			this.freeConnection(context, db);
		}
		return "NuovaErrataCorrigeOK";
	}

	public String executeCommandSalvaErrataCorrige(ActionContext context) throws IndirizzoNotFoundException{

		int riferimentoId = -1;
					
		String riferimentoIdString = context.getRequest().getParameter("riferimentoId");
		String riferimentoIdNomeTab = context.getRequest().getParameter("riferimentoIdNomeTab");
		
		riferimentoId = Integer.parseInt(riferimentoIdString);
		
		int idUtente = getUserId(context);
		String note = context.getRequest().getParameter("note");
		String telefono = context.getRequest().getParameter("telefono");
		String mail = context.getRequest().getParameter("mail");
		String motivo = context.getRequest().getParameter("motivoCorrezione");

		String idControllo = context.getRequest().getParameter("idControllo");
		String contesto = context.getRequest().getParameter("contesto");
		
		Connection db = null;
		
		try {
			db = this.getConnection(context);
			
			RicercaOpu stab = null;
			
			if (riferimentoIdNomeTab.equals("opu_stabilimento")){
				stab = new RicercaOpu(db, riferimentoId, "id_stabilimento");
			}
			else if (riferimentoIdNomeTab.equals("organization")){
				stab = new RicercaOpu(db, riferimentoId, "org_id");
			}
			else if (riferimentoIdNomeTab.equals("sintesis_stabilimento")){
				stab = new RicercaOpu (db, riferimentoId, "alt_id");
			}
	
			RichiestaErrataCorrige richiesta = new RichiestaErrataCorrige();
			richiesta.setRiferimentoId(riferimentoId);
			richiesta.setRiferimentoIdNomeTab(riferimentoIdNomeTab);
			richiesta.setIdAsl(stab.getIdAsl());
			richiesta.setIdUtente(idUtente);
			richiesta.setIdLookupMotivoCorrezione(motivo);
			richiesta.setTelefono(telefono);
			richiesta.setMail(mail); 
			richiesta.setNote(note);
			richiesta.setIdControllo(idControllo);
			richiesta.setContesto(contesto);
			richiesta.insert(db);
			
			for (int i = 0; i<5; i++){
				RichiestaErrataCorrigeCampo campo = new RichiestaErrataCorrigeCampo();
				campo.setIdErrataCorrige(richiesta.getId());
				campo.setIdLookupInfoDaModificare(Integer.parseInt(context.getRequest().getParameter("tipoInformazione"+i)));
				campo.setDatoErrato(context.getRequest().getParameter("datoErrato"+i));
				campo.setDatoCorretto(context.getRequest().getParameter("datoCorretto"+i));
				campo.insert(db);
			}
			
			//context.getRequest().setAttribute("RichiestaAppenaInserita", richiesta);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			this.freeConnection(context, db);
		}
		
		context.getRequest().setAttribute("riferimentoId", String.valueOf(riferimentoId));
		context.getRequest().setAttribute("op", context.getRequest().getParameter("op"));
		
		return executeCommandGestioneRichiesteErrataCorrige(context);
	}


	public String executeCommandModuloRichiestaErrataCorrige(ActionContext context) throws IndirizzoNotFoundException{

		int id = Integer.parseInt(context.getRequest().getParameter("id"));
			
		Connection db = null;
		
		try {
			db = this.getConnection(context);
		
			RichiestaErrataCorrige richiesta = new RichiestaErrataCorrige(db, id);
			context.getRequest().setAttribute("Richiesta", richiesta);
			
			LookupList LookupTipoInformazione = new LookupList(db,"richieste_errata_corrige_lookup_info_da_modificare");
			context.getRequest().setAttribute("LookupTipoInformazione", LookupTipoInformazione);
			LookupList LookupTipoMotivoCorrezione = new LookupList(db,"richieste_errata_corrige_lookup_motivo_correzione");
			context.getRequest().setAttribute("LookupMotivoCorrezione", LookupTipoMotivoCorrezione);
					
			

			RicercaOpu stab = null;
			
			if (richiesta.getRiferimentoIdNomeTab().equals("opu_stabilimento"))
				stab = new RicercaOpu(db, richiesta.getRiferimentoId(), "id_stabilimento");
			else if (richiesta.getRiferimentoIdNomeTab().equals("organization"))
				stab = new RicercaOpu(db, richiesta.getRiferimentoId(), "org_id");
			else if (richiesta.getRiferimentoIdNomeTab().equals("sintesis_stabilimento"))
				stab = new RicercaOpu (db, richiesta.getRiferimentoId(), "alt_id");
			
			context.getRequest().setAttribute("Stabilimento", stab);
			
			User user = new User(db, richiesta.getIdUtente());
			context.getRequest().setAttribute("Utente", user);
			
			LookupList aslList = new LookupList(db, "lookup_site_id");
			context.getRequest().setAttribute("AslList", aslList);

			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			this.freeConnection(context, db);
		}
		return "ModuloRichiestaErrataCorrigeOK";
	}

	public static void associaHeaderEInviaMail(ActionContext context, Connection db, int id, String headerDocumento, String file) throws SQLException, IndirizzoNotFoundException {
		RichiestaErrataCorrige richiesta = new RichiestaErrataCorrige(db, id);
		
		if (richiesta.getHeaderDocumento()==null) {
			richiesta.setHeaderDocumento(headerDocumento);
			richiesta.updateHeaderDocumento(db);
			
			User user = new User (db, richiesta.getIdUtente());
			
			RicercaOpu stab = null;
			
			if (richiesta.getRiferimentoIdNomeTab().equals("opu_stabilimento"))
				stab = new RicercaOpu(db, richiesta.getRiferimentoId(), "id_stabilimento");
			else if (richiesta.getRiferimentoIdNomeTab().equals("organization"))
				stab = new RicercaOpu(db, richiesta.getRiferimentoId(), "org_id");
			else if (richiesta.getRiferimentoIdNomeTab().equals("sintesis_stabilimento"))
				stab = new RicercaOpu (db, richiesta.getRiferimentoId(), "alt_id");
			
			String toDest=ApplicationProperties.getProperty("DEST_EMAIL_ERRATA_CORRIGE");
			String oggetto =ApplicationProperties.getProperty("OGGETTO_EMAIL_ERRATA_CORRIGE");
		
			
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
			String testo = "E' stata generata una nuova richiesta di Errata Corrige.<br/><br/>"
					+ "Richiedente: "+ user.getContact().getNameFirst() + " "+ user.getContact().getNameLast() + " ("+user.getUsername()+") "+"<br/>"
					+ "Num. telefono: "+richiesta.getTelefono()+" Mail: "+richiesta.getMail()+" <br/>"
					+ "Stabilimento: "+stab.getRagioneSociale()+ " (" + stab.getNumeroRegistrazione()+")<br/>"
					+ "Data: "+ dateFormat.format(richiesta.getData())+"<br/><br/>";
			
			if (richiesta.getIdControllo()>0)
				testo+= "Id Controllo: "+richiesta.getIdControllo()+"<br/>";
			if (richiesta.getContesto()!=null)
				testo+= "Contesto: "+richiesta.getContesto()+"<br/>";
			
			File allegato = new File(file);
			
			sendMailErrataCorrige(context.getRequest(), testo, oggetto, toDest, allegato);
		}
		
	}


	public static void sendMailErrataCorrige(HttpServletRequest req,String testo,String object,String toDest, File allegato)
	{
		
		String[] toDestArray = toDest.split(";");
		HashMap<String,String> configs = new HashMap<String,String>();
		configs.put("mail.smtp.starttls.enable",ApplicationProperties.getProperty("mail.smtp.starttls.enable"));
		configs.put("mail.smtp.auth", ApplicationProperties.getProperty("mail.smtp.auth"));
		configs.put("mail.smtp.host", ApplicationProperties.getProperty("mail.smtp.host"));
		configs.put("mail.smtp.port", ApplicationProperties.getProperty("mail.smtp.port"));
		configs.put("mail.smtp.ssl.enable",ApplicationProperties.getProperty("mail.smtp.ssl.enable"));
		configs.put("mail.smtp.ssl.protocols", ApplicationProperties.getProperty("mail.smtp.ssl.protocols"));
		configs.put("mail.smtp.socketFactory.class", ApplicationProperties.getProperty("mail.smtp.socketFactory.class"));
		configs.put("mail.smtp.socketFactory.fallback", ApplicationProperties.getProperty("mail.smtp.socketFactory.fallback"));
		
		PecMailSender sender = new PecMailSender(configs,ApplicationProperties.getProperty("username"), ApplicationProperties.getProperty("password"));
		try {
			sender.sendMailConAllegato(object,testo,ApplicationProperties.getProperty("mail.smtp.from"), toDestArray, allegato);
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	
}
