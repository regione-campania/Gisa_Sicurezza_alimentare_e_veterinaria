package ext.aspcfs.modules.apicolture.actions;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import org.aspcfs.checklist.action.ChecklistApi;
import org.aspcfs.checklist.base.Audit;
import org.aspcfs.checklist.base.AuditChecklist;
import org.aspcfs.checklist.base.AuditChecklistType;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.opu.base.IndirizzoNotFoundException;
import org.aspcfs.modules.vigilanza.base.Ticket;
import org.aspcfs.utils.AuditReport;
import org.aspcfs.utils.web.CustomLookupList;

import com.darkhorseventures.framework.actions.ActionContext;

import ext.aspcfs.modules.apiari.base.Stabilimento;

public class CheckListImprese extends CFSModule{
	
	 public String executeCommandAdd(ActionContext context)
	  {
		 
		 if (!hasPermission(context, "checklist-checklist-add"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
		try 
		{
		
			ChecklistApi c = new ChecklistApi();
			c.executeCommandAdd(context);
			
			db = this.getConnection(context);
			Stabilimento organization	 = new Stabilimento(db, Integer.parseInt(context.getRequest().getParameter("stabId")));
			organization.getPrefissoAction(context.getAction().getActionName());
			
			context.getRequest().setAttribute("OrgDetails", organization);
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		finally 
		{
			this.freeConnection(context, db);
		}
		
		 return "checklistImpreseAdd";
	 
	  }
	 
	 
	 public String executeCommandSave(ActionContext context) throws NumberFormatException, IndirizzoNotFoundException, IllegalAccessException, InstantiationException
	 {
		 
		 if (!hasPermission(context, "checklist-checklist-add")) 
		 {
				return ("PermissionError");
		 }		
		 
		Connection db = null;
		try 
		{
			
			ChecklistApi c = new ChecklistApi();
			c.executeCommandSave(context);
			
			db = this.getConnection(context);
			Stabilimento organization	 = 	new Stabilimento(db, Integer.parseInt(context.getRequest().getParameter("orgId")));
			organization.getPrefissoAction(context.getAction().getActionName());
			context.getRequest().setAttribute("OrgDetails", organization);
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		finally 
		{
			this.freeConnection(context, db);
		}
		 return "checklistImpreseSaveOk";
	  }
	 
	 public String executeCommandView(ActionContext context) throws IndirizzoNotFoundException, IllegalAccessException, InstantiationException
	 {
		 
		 if (!hasPermission(context, "checklist-checklist-view")) 
		{
			return ("PermissionError");
		}
				
		Connection db = null;
		try 
		{
			
			ChecklistApi c = new ChecklistApi();
			c.executeCommandView(context);
			
			db = this.getConnection(context);
			org.aspcfs.checklist.base.Organization 	orgTemp 		= 	(org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Stabilimento 							organization	= 	new Stabilimento(db, orgTemp.getOrg_id());
			organization.getPrefissoAction(context.getAction().getActionName());
			
			context.getRequest().setAttribute("OrgDetails", organization);
			
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		finally 
		{
			this.freeConnection(context, db);
		}
		 return "checklistImpreseView";
	 }
	 
	 public String executeCommandModify(ActionContext context) throws IndirizzoNotFoundException, IllegalAccessException, InstantiationException
	 {
		 
		 
		 if (!hasPermission(context, "checklist-checklist-edit")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try 
		{
			
			ChecklistApi c = new ChecklistApi();
			c.executeCommandModify(context);
			db = this.getConnection(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			
			Stabilimento organization	 = 	new Stabilimento(db, orgTemp.getOrg_id());
			organization.getPrefissoAction(context.getAction().getActionName());
			context.getRequest().setAttribute("OrgDetails", organization);
			
		} 
		catch (SQLException e) 
		{
			context.getResponse().setStatus(2012);
			e.printStackTrace();
		}
		finally 
		{
			this.freeConnection(context, db);
		}
		 return "checklistImpreseModify";
	 }
	 
	 public String executeCommandAggiornaChecklist(ActionContext context)
	 {
		 
		 return "checklistImpreseUpdate";

	 }
	 
	 public String executeCommandUpdate(ActionContext context) throws IndirizzoNotFoundException, IllegalAccessException, InstantiationException
	 {
		 
			
		Connection db = null;
		try 
		{
			
			ChecklistApi c = new ChecklistApi()		;
			c.executeCommandUpdate(context)		;
			Ticket newTic = (Ticket) context.getRequest().getAttribute("TicketDetails");

			db = this.getConnection(context)	;
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Stabilimento organization	 = 	new Stabilimento(db, newTic.getIdApiario());
			organization.getPrefissoAction(context.getAction().getActionName());
			context.getRequest().setAttribute("OrgDetails", organization);
			
		} 
		catch (Exception e) 
		{
			
				context.getRequest().setAttribute("ErroreChecklist", "Errore");
				return executeCommandModify(context);
			
			//context.getRequest().setAttribute("Error", e);
		}
		finally 
		{
			this.freeConnection(context, db);
		}
		 return "checklistImpreseUpdate";
	 }
	 
	 public String executeCommandDelete(ActionContext context)
	 {
		 
		 
		 if (!hasPermission(context, "checklist-checklist-delete")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try  
		{
			
			ChecklistApi c = new ChecklistApi();
			c.executeCommandDelete(context);
		
			db = this.getConnection(context);
			//org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
				Stabilimento organization	 = 	new Stabilimento(db, Integer.parseInt((String)context.getRequest().getAttribute("idApiario")));
				organization.getPrefissoAction(context.getAction().getActionName());
				context.getRequest().setAttribute("OrgDetails", organization);
		
		} 
		
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		finally 
		{
			this.freeConnection(context, db);
		}
		
		 return ("checklistImpreseDelete");
	 }
	 
	 public String executeCommandUpdateCategoria(ActionContext context)
	 {
					
		Connection db = null;
		
		String idControllo = context.getRequest().getParameter("idC");
		String idStabilimento = context.getRequest().getParameter("orgId");
		
		try 
		{
			
			db = this.getConnection(context);
			
			//verifica possibilita chiusura CU
			Ticket thisTicket = new Ticket(db, Integer.parseInt(idControllo));
			String messaggioAllegatiSanzione = thisTicket.isControlloChiudibileAllegatiSanzione(db);
			if (messaggioAllegatiSanzione!=null && !messaggioAllegatiSanzione.equals("")){
				int flag = 6;
				context.getRequest().setAttribute("Chiudi",""+flag);
				context.getRequest().setAttribute("Messaggio",messaggioAllegatiSanzione);
				context.getRequest().setAttribute("id", idControllo);
				context.getRequest().setAttribute("idStabilimentoopu", idStabilimento);
				ext.aspcfs.modules.apicolture.actions.AccountVigilanza AV = new ext.aspcfs.modules.apicolture.actions.AccountVigilanza();
				//return AV.executeCommandTicketDetails(context);
				return AV.executeCommandChiudiTutto(context);
			}
			
			ChecklistApi c = new ChecklistApi();
			c.executeCommandUpdateLivello(context);
			
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Stabilimento organization	 = 	new Stabilimento(db, orgTemp.getOrg_id());
			
			organization.getPrefissoAction(context.getAction().getActionName());
			context.getRequest().setAttribute("OrgDetails", organization);
		
		} 
		
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		finally 
		{
			this.freeConnection(context, db);
		}
		
		AccountVigilanza AV = new AccountVigilanza();
		return AV.executeCommandChiudiTutto(context);
		//return ("checklistImpreseUpdateCategoria");
	 }
	 
	 
	 
	 
	 public String executeCommandStampa(ActionContext context)
	 {
		
		 
		 if (!hasPermission(context, "checklist-checklist-edit")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try 
		{
			
			ChecklistApi c = new ChecklistApi();
			c.executeCommandITextReport(context);
			
			db = this.getConnection(context);
			org.aspcfs.modules.opu.base.Stabilimento orgTemp = (org.aspcfs.modules.opu.base.Stabilimento) context.getRequest().getAttribute("OrgDetails");
			Stabilimento organization	 = 	new Stabilimento(db, orgTemp.getIdStabilimento());
			organization.getPrefissoAction(context.getAction().getActionName());
			context.getRequest().setAttribute("OrgDetails", organization);
			
			OutputStream out = context.getResponse().getOutputStream();
			AuditReport report = new AuditReport();
			

			Audit 							audit 				= 	(Audit) context.getRequest().getAttribute("Audit");
			ArrayList<CustomLookupList> 	checklistList 		= 	( ArrayList<CustomLookupList>) context.getRequest().getAttribute("checklistList");
			CustomLookupList 				checklistType 		=	(CustomLookupList) context.getRequest().getAttribute("typeList");
			ArrayList<AuditChecklistType> 	auditChecklistType 	=	(ArrayList<AuditChecklistType>) context.getRequest().getAttribute("auditChecklistType");
			ArrayList<AuditChecklist> 		auditChecklist 		=	( ArrayList<AuditChecklist>) context.getRequest().getAttribute("auditChecklist");
			
			report.setContext(context);
			report.generate( out, audit, organization, checklistList, checklistType,auditChecklist, auditChecklistType, db);
			out.flush();
		} 
		
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		finally 
		{
			this.freeConnection(context, db);
		}
		 return ("-none-");
	 }
	 
	 
	 
	
	 
	 
	 

}
