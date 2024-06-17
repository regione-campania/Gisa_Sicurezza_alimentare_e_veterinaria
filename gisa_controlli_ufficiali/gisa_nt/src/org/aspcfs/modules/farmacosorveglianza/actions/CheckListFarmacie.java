package org.aspcfs.modules.farmacosorveglianza.actions;


import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import org.aspcfs.checklist.action.Checklist;
import org.aspcfs.checklist.base.Audit;
import org.aspcfs.checklist.base.AuditChecklist;
import org.aspcfs.checklist.base.AuditChecklistType;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.farmacosorveglianza.base.Organization;
import org.aspcfs.modules.vigilanza.base.Ticket;
import org.aspcfs.utils.AuditReport;
import org.aspcfs.utils.web.CustomLookupList;

import com.darkhorseventures.framework.actions.ActionContext;

public class CheckListFarmacie extends CFSModule{
	
	 public String executeCommandAdd(ActionContext context)
	  {
		 
		 if (!hasPermission(context, "checklist-checklist-add"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			c.executeCommandAdd(context);
			db = this.getConnection(context);
			Organization organization	 = 	new Organization(db, Integer.parseInt(context.getRequest().getParameter("orgId")));
			organization.setAccountSize(context.getRequest().getParameter("accountSize"));
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
	 
	 
	 public String executeCommandSave(ActionContext context)
	  {
		 
			
		 
		Connection db = null;
		try 
		{
			
			context.getRequest().setAttribute("Farmacosorveglianza", "true");
			Checklist c = new Checklist();
			c.executeCommandSave(context);
			db = this.getConnection(context);
			Organization organization	 = 	new Organization(db, Integer.parseInt(context.getRequest().getParameter("orgId")));
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
	 
	 public String executeCommandView(ActionContext context)
	 {
		 
		 if (!hasPermission(context, "checklist-checklist-view")) 
		{
			return ("PermissionError");
		}
				
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			context.getRequest().setAttribute("farmacosorveglianza", "true");
			c.executeCommandView(context);
			db = this.getConnection(context);
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
			
			Checklist c = new Checklist();
			c.executeCommandModify(context);
			db = this.getConnection(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
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
		 return "checklistImpreseModify";
	 }
	 
	 public String executeCommandUpdate(ActionContext context)
	 {
		 
		 
		 if (!hasPermission(context, "checklist-checklist-edit")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			c.executeCommandUpdate(context);
			db = this.getConnection(context);
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
			
			Checklist c = new Checklist();
			c.executeCommandDelete(context);
			db = this.getConnection(context);
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
					org.aspcfs.modules.farmacosorveglianza.actions.AccountVigilanza AV = new org.aspcfs.modules.farmacosorveglianza.actions.AccountVigilanza();
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
		 
		 
		 if (!hasPermission(context, "checklist-checklist-view")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			c.executeCommandITextReport(context);
			db = this.getConnection(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
			context.getRequest().setAttribute("OrgDetails", organization);
			
			OutputStream out = context.getResponse().getOutputStream();
			AuditReport report = new AuditReport();
			
			report.setContext(context);
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
