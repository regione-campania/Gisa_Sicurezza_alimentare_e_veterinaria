package org.aspcfs.modules.oia.actions;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import org.aspcfs.checklist.action.Checklist;
import org.aspcfs.checklist.base.Audit;
import org.aspcfs.checklist.base.AuditChecklist;
import org.aspcfs.checklist.base.AuditChecklistType;
import org.aspcfs.modules.accounts.base.Organization;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.oia.base.OiaNodo;
import org.aspcfs.modules.vigilanza.base.Ticket;
import org.aspcfs.utils.AuditReport;
import org.aspcfs.utils.web.CustomLookupList;

import com.darkhorseventures.framework.actions.ActionContext;

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
			db = this.getConnection(context);
			  OiaNodo orgDetail = new OiaNodo(db, Integer.parseInt(context.getParameter("idNodo")), this.getSystemStatus(context));
			
			context.getRequest().setAttribute("OrgDetails", orgDetail);
			Checklist c = new Checklist();
			c.executeCommandAdd(context);
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
	 
	 
	 public String executeCommandSave(ActionContext context)
	 {
		 
		 if (!hasPermission(context, "checklist-checklist-add")) 
		 {
				return ("PermissionError");
		 }		
		 
		Connection db = null;
		try 
		{
			db = this.getConnection(context);
			  OiaNodo orgDetail = new OiaNodo(db, Integer.parseInt(context.getParameter("idNodo")), this.getSystemStatus(context));
			context.getRequest().setAttribute("OrgDetails", orgDetail);
			Checklist c = new Checklist();
			c.executeCommandSave(context);
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
	 
	 public String executeCommandView(ActionContext context)
	 {
		 
		 if (!hasPermission(context, "checklist-checklist-view")) 
		{
			return ("PermissionError");
		}
				
		Connection db = null;
		try 
		{
			db = this.getConnection(context);
			Checklist c = new Checklist();
			c.executeCommandView(context);
			org.aspcfs.checklist.base.Organization 	orgTemp 		= 	(org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization 							organization	= 	new Organization(db, orgTemp.getOrg_id());
			
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
	 
	 public String executeCommandModify(ActionContext context)
	 {
		 
		 
		 if (!hasPermission(context, "checklist-checklist-edit")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try 
		{
			db = this.getConnection(context);
			Checklist c = new Checklist();
			c.executeCommandModify(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
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
	 
	 public String executeCommandUpdate(ActionContext context)
	 {
		 
			
		Connection db = null;
		try 
		{
			db = this.getConnection(context)	;
			Checklist c = new Checklist()		;
			c.executeCommandUpdate(context)		;
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
			context.getRequest().setAttribute("OrgDetails", organization);
			
		} 
		catch (Exception e) 
		{
			
				System.out.println("Errore in modifica Checklis : "+e.getMessage());
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
			db = this.getConnection(context);
			Checklist c = new Checklist();
			c.executeCommandDelete(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
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
		String orgId = context.getRequest().getParameter("orgId");
		
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
				context.getRequest().setAttribute("orgId", orgId);
				org.aspcfs.modules.oia.actions.AccountVigilanza AV = new org.aspcfs.modules.oia.actions.AccountVigilanza();
				//return AV.executeCommandTicketDetails(context);
				return AV.executeCommandChiudiTutto(context);
			}
			
			Checklist c = new Checklist();
			c.executeCommandUpdateLivello(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
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
			db = this.getConnection(context);
			Checklist c = new Checklist();
			c.executeCommandITextReport(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
			context.getRequest().setAttribute("OrgDetails", organization);
			
			OutputStream out = context.getResponse().getOutputStream();
			AuditReport report = new AuditReport();
			

			Audit 							audit 				= 	(Audit) context.getRequest().getAttribute("Audit");
			ArrayList<CustomLookupList> 	checklistList 		= 	( ArrayList<CustomLookupList>) context.getRequest().getAttribute("checklistList");
			CustomLookupList 				checklistType 		=	(CustomLookupList) context.getRequest().getAttribute("typeList");
			ArrayList<AuditChecklistType> 	auditChecklistType 	=	(ArrayList<AuditChecklistType>) context.getRequest().getAttribute("auditChecklistType");
			ArrayList<AuditChecklist> 		auditChecklist 		=	( ArrayList<AuditChecklist>) context.getRequest().getAttribute("auditChecklist");
			
			
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
