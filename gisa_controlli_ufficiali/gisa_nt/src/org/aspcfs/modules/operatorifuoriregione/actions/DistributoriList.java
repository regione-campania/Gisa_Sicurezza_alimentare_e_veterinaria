package org.aspcfs.modules.operatorifuoriregione.actions;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.distributori.base.Distrubutore;
import org.aspcfs.modules.operatorifuoriregione.base.Organization;
import org.aspcfs.modules.trasportoanimali.base.Comuni;
import org.aspcfs.utils.web.LookupList;
import org.jmesa.facade.TableFacade;
import org.jmesa.facade.TableFacadeFactory;
import org.jmesa.limit.Limit;
import org.jmesa.view.editor.CellEditor;
import org.jmesa.view.html.component.HtmlColumn;
import org.jmesa.view.html.component.HtmlRow;
import org.jmesa.view.html.editor.DroplistFilterEditor;
import org.jmesa.view.html.editor.HtmlCellEditor;
import org.jmesa.view.html.toolbar.ToolbarItem;
import org.jmesa.view.html.toolbar.ToolbarItemFactoryImpl;
import org.jmesa.worksheet.UniqueProperty;
import org.jmesa.worksheet.Worksheet;
import org.jmesa.worksheet.WorksheetColumn;
import org.jmesa.worksheet.WorksheetRow;
import org.jmesa.worksheet.WorksheetUtils;

import com.darkhorseventures.framework.actions.ActionContext;

public final class DistributoriList extends CFSModule
{

	public String executeCommandDefault(ActionContext context)
	{

			if(context.getRequest().getParameter("command")==null){


		return executeCommandDetails(context);

			}else
				return executeCommandAdd(context);
		
	}

	String org_id="-1";
	Connection db=null;


	
	public String executeCommandAdd(ActionContext context) {
		if (!hasPermission(context, "distributori-distributori-view")) {
			return ("PermissionError");
		}

		
		context.getRequest().setAttribute("add","add");
		SystemStatus systemStatus = this.getSystemStatus(context);
		Organization newOrg = null;
		try {
context.getRequest().setAttribute("aggiunto", "true");

String scroll = (String) context.getRequest().getParameter("scroll");
context.getRequest().setAttribute( "scroll", scroll );

			String temporgId = context.getRequest().getParameter("orgId");
			if (temporgId == null) {
				temporgId = (String) context.getRequest().getAttribute("orgId");
			}
			int tempid = Integer.parseInt(temporgId);
			db = this.getConnection(context);
			//if (!isRecordAccessPermitted(context, db, Integer.parseInt(temporgId))) {
				//return ("PermissionError");
			//}
			newOrg = new Organization(db, tempid);
			//check whether or not the owner is an active User

			String  org_id=context.getRequest().getParameter("orgId");



			PreparedStatement	stat	= db.prepareStatement( "select * from distributori_automatici ,lookup_tipo_distributore where alimenti_distribuiti=code and org_id="+newOrg.getId());
			ResultSet			rs		= stat.executeQuery();
		

 

			TableFacade tf = TableFacadeFactory.createTableFacade("15", context.getRequest());
			tf.setEditable(true);
			Worksheet worksheet = tf.getWorksheet();
		

	
			 Collection<Distrubutore> coll=	newOrg.getListaDistributori();
				coll.add(new Distrubutore("","","","","","","","",null,-1,""));
			
				
				tf.setItems( coll);
				tf.setColumnProperties( 
					"matricola", "data", "comune", "provincia", "indirizzo",
					"cap", "descrizioneTipoAlimenti","note","ubicazione","elimina"
			);
			tf.setStateAttr("restore");					
			HtmlRow row = (HtmlRow) tf.getTable().getRow();
			row.setUniqueProperty("matricola"); // the unique worksheet properties to identify the row


			tf.getTable().getRow().getColumn( "matricola" ).setTitle( "matricola" );
			tf.getTable().getRow().getColumn( "data" ).setTitle( "data Installazione" );
			tf.getTable().getRow().getColumn( "comune" ).setTitle( "comune" );
			tf.getTable().getRow().getColumn( "provincia" ).setTitle( "provincia" );
			tf.getTable().getRow().getColumn( "indirizzo" ).setTitle( "indirizzo" );
			tf.getTable().getRow().getColumn( "cap" ).setTitle( "cap" );
		
			tf.getTable().getRow().getColumn( "descrizioneTipoAlimenti" ).setTitle( "Alimento Distribuito" );
			tf.getTable().getRow().getColumn( "note" ).setTitle( "note" );
			tf.getTable().getRow().getColumn( "ubicazione" ).setTitle( "Ubicazione" );
			tf.getTable().getRow().getColumn( "elimina" ).setTitle( "Elimina" );
			
			
			HtmlColumn cg1 = (HtmlColumn) tf.getTable().getRow().getColumn("descrizioneTipoAlimenti");
			cg1.getCellRenderer().setCellEditor( 
	        		new CellEditor()
	        		{	
	        			public Object getValue(Object item, String property, int rowCount)
	        			{
	        				LookupList alimenti = null;
							try {
								alimenti = new LookupList(db,"lookup_tipo_distributore");
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
	        		
	        				String temp	= (String) (new HtmlCellEditor()).getValue(item, property, rowCount);
	        				String id	= (String) (new HtmlCellEditor()).getValue(item, "alimentoDistribuito", rowCount);
	        				
	        				String matricola	= (String) (new HtmlCellEditor()).getValue(item, "matricola", rowCount);
	        				temp = (temp == null || "".equals(temp.trim())) ? ("-") : (temp);
	        				return alimenti.getHtmlSelect("alimentiDistribuiti_"+matricola, id);
	        			}
	        		}
	        
	        	);


			Limit limit = tf.getLimit();
			if(! limit.isExported() )
			{



				HtmlColumn cg = (HtmlColumn) tf.getTable().getRow().getColumn("matricola");
				cg.getFilterRenderer().setFilterEditor(new DroplistFilterEditor());
				//cg.setFilterable( false );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("data");
				cg.setFilterable( true );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("comune");
				cg.setFilterable( true );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("provincia");
				cg.setFilterable( false );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("indirizzo");
				cg.setFilterable( true );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("cap");
				cg.setFilterable( false );

				

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("descrizioneTipoAlimenti");
				cg.setFilterable( false );
				cg.setEditable(false);

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("note");
				cg.setFilterable( false );
				
				cg = (HtmlColumn) tf.getTable().getRow().getColumn("ubicazione");
				cg.setFilterable( false );
				cg = (HtmlColumn) tf.getTable().getRow().getColumn("elimina");
				cg.setEditable(false);
				cg.getCellRenderer().setCellEditor( 
		        		new CellEditor()
		        		{	
		        			public Object getValue(Object item, String property, int rowCount)
		        			{
		        				String iddef=(String) (new HtmlCellEditor()).getValue(item, "matricola", rowCount);
		        				
		        				String orgid=(String) (new HtmlCellEditor()).getValue(item, "org_id", rowCount);
		        				Comuni comune = new Comuni();
		        				
		        				if(orgid.equals("-1") )
		        					return "Elimina";
		        				else
								
		        		
		        				return "<a href='DistributoriListFuoriRegione.do?orgId="+orgid+"&oggetto=distributore&id=-1"+"'>Elimina </a>";
		        			}
		        		}
		        
		        	);
				cg.setFilterable(false);


			}
		
			ToolbarItem item7 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createFilterItem();
			item7.setTooltip( "Filtra" );
			tf.getToolbar().addToolbarItem( item7 );
			
			ToolbarItem item8 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createClearItem();
			item8.setTooltip( "Resetta Filtro" );
			tf.getToolbar().addToolbarItem( item8 );
												
			ToolbarItem item2 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createSaveWorksheetItem();
			item2.setTooltip( "Salva" );
			tf.getToolbar().addToolbarItem( item2 );
			
			ToolbarItem item18 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createPrevPageItem();
			item18.setTooltip( "Scorri pagina indietro" );
			tf.getToolbar().addToolbarItem( item18 );
			
			ToolbarItem item17 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createNextPageItem();
			item17.setTooltip( "Scorri pagina in avanti" );
			tf.getToolbar().addToolbarItem( item17 );
			
			

			String tabella = tf.render();
			context.getRequest().setAttribute( "tabella", tabella );
			
			
			LookupList siteList = new LookupList(db, "lookup_site_id");
			siteList.addItem(-1,  "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("SiteList", siteList);

			LookupList tipoDitributore = new LookupList(db, "lookup_tipo_distributore");
			tipoDitributore.addItem(-1, getSystemStatus(context).getLabel("calendar.none.4dashes"));
			context.getRequest().setAttribute("TipoDitributore", tipoDitributore);      

			LookupList statoLab = new LookupList(db, "lookup_stato_lab");
			statoLab.addItem(-1,  "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("statoLab", statoLab);

			LookupList categoriaRischioList = new LookupList(db, "lookup_org_catrischio");
			categoriaRischioList.addItem(-1,  "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("OrgCategoriaRischioList", categoriaRischioList);

			LookupList impianto = new LookupList(db, "lookup_impianto");
			impianto.addItem(-1,  "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("impianto", impianto);



				
			
			PreparedStatement	stat_veicoli	= db.prepareStatement( "select count(*) as numero from distributori_automatici where org_id="+tempid );
			ResultSet			rs_veicoli		= stat_veicoli.executeQuery();
			int numeroDistributori=0;
			if(rs_veicoli.next())
				numeroDistributori=rs_veicoli.getInt(1);
			
			
			numeroDistributori=(numeroDistributori/15)+1;
			context.getRequest().setAttribute("numeroDistributori", numeroDistributori);

			
		} catch (Exception e) {
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		addRecentItem(context, newOrg);
		String action = context.getRequest().getParameter("action");
		if (action != null && action.equals("modify")) {
			//If user is going to the modify form
			addModuleBean(context, "Accounts", "Modify Account Details");
			return ("DetailsOK");
		} else {
			//If user is going to the detail screen
			addModuleBean(context, "View Accounts", "View Account Details");
			context.getRequest().setAttribute("OrgDetails", newOrg);
			return getReturn(context, "Details");
		}
	}
	
	
	
		
	
	
	

	public String executeCommandDetails(ActionContext context) {
		if (!hasPermission(context, "distributori-distributori-view")) {
			return ("PermissionError");
		}

		SystemStatus systemStatus = this.getSystemStatus(context);
		Organization newOrg = null;
		try {


			
			/**
			 * Contollo temporaneo 
			 */
			
	
			
			String temporgId = context.getRequest().getParameter("orgId");
			if (temporgId == null) {
				temporgId = (String) context.getRequest().getAttribute("orgId");
			}
			int tempid = Integer.parseInt(temporgId);
			db = this.getConnection(context);
			

			String  org_id=context.getRequest().getParameter("orgId");


			

			PreparedStatement	stat	= db.prepareStatement( "select * from distributori_automatici ,lookup_tipo_distributore where alimenti_distribuiti=code and org_id="+temporgId);
			ResultSet			rs		= stat.executeQuery();
	ArrayList<String> listaMatricole=new ArrayList<String>();	
while(rs.next()){
	
	listaMatricole.add(rs.getString("matricola"));
	
}


			TableFacade tf = TableFacadeFactory.createTableFacade("15", context.getRequest());
			tf.setEditable(true);
			Worksheet worksheet = tf.getWorksheet();

			
			
			
			
			String modificatipi="update distributori_automatici set alimenti_distribuiti=? where matricola=? and org_id=? ";
			int orgID_=Integer.parseInt(org_id);
			for(String s : listaMatricole){
				PreparedStatement pst=db.prepareStatement(modificatipi);
				
				String tipo=context.getRequest().getParameter("alimentiDistribuiti_"+s);
				if(tipo!=null){
				
					int tipologiaAlimenti=Integer.parseInt(tipo);
					pst.setInt(1, tipologiaAlimenti);
					pst.setString(2, s);
					pst.setInt(3, orgID_);
					pst.execute();
				
				
				}
				
					
			}
			
			if (worksheet.isSaving() || worksheet.hasChanges())
			{ 
				List<String> uniquePropertyValues = WorksheetUtils.getUniquePropertyValues(worksheet);


				String uniquePropertyName = WorksheetUtils.getUniquePropertyName(worksheet);
			



				HashMap<String, String> valoriAggiornati=null;

				for(String s : uniquePropertyValues){
					String query="update distributori_automatici set ";
					valoriAggiornati=new HashMap<String, String>();

					UniqueProperty u =new UniqueProperty("matricola",s);

					WorksheetRow row= worksheet.getRow(u);

					Collection<WorksheetColumn> columns = row.getColumns();
					for (WorksheetColumn colonna : columns) { 
						String changedValue = colonna.getChangedValue();  
						changedValue = changedValue.replaceAll("'", "''");
						String nomeColonna=colonna.getProperty();

						validateColumn(colonna, changedValue);    
						if (colonna.hasError()) {  
							context.getRequest().setAttribute("errore", colonna.getError());
							
							continue;    }

						if(!colonna.hasError()){

							valoriAggiornati.put(nomeColonna, changedValue);

						}

					}

					java.util.Iterator<String> it=valoriAggiornati.keySet().iterator();
					int c=0;
					
					PreparedStatement pst2=db.prepareStatement("select * from distributori_automatici where matricola='"+s+"' and org_id="+org_id);
					ResultSet rs2=pst2.executeQuery();
					if(!rs2.next()){
						
						
						Distrubutore dist=new Distrubutore("","","","","","","","",null,-1,"");
						int flag=0;
						while(it.hasNext()){
							
							
							String kiaveNomeColonna=it.next();
							String valore=valoriAggiornati.get(kiaveNomeColonna);
							
							
							if(kiaveNomeColonna.equals("matricola")){
								dist.setMatricola(valore);
								
							}else{
								if(kiaveNomeColonna.equals("comune")){
									dist.setComune(valore);
									
								}else{
									if(kiaveNomeColonna.equals("provincia")){
										dist.setProvincia(valore);
										
									}else{
										if(kiaveNomeColonna.equals("indirizzo")){
											dist.setIndirizzo(valore);
											
										}else{
											if(kiaveNomeColonna.equals("cap")){
												dist.setCap(valore);
												
											}else{
												if(kiaveNomeColonna.equals("latitudine")){
													dist.setLatitudine(valore);
													
												}else{
													if(kiaveNomeColonna.equals("longitudine")){
														
														dist.setLongitudine(valore);
													}else{
														if(kiaveNomeColonna.equals("descrizioneTipoAlimenti")){
														
															
														}else{
															if(kiaveNomeColonna.equals("note")){
																dist.setNote(valore);
																
															}else{
																if(kiaveNomeColonna.equals("data")){

																	SimpleDateFormat ss=new SimpleDateFormat("dd/MM/yyyy");
																	java.util.Date d=ss.parse(valore);

																dist.setData(d);
																}
																else{
																	if(kiaveNomeColonna.equals("ubicazione")){
																		dist.setUbicazione(valore);
																		
																	}
																
															}
																
															}
														}
													}
												}
											}
										}
									}
								}
								
							}



						}
					
						dist.setAlimentoDistribuito(Integer.parseInt(context.getRequest().getParameter("alimentiDistribuiti_")));
						dist.insert(db, Integer.parseInt(org_id));
						
						
						rs2.close();
					}else{
					
					
					
					int tipo=-1;
					int flag=0;
					while(it.hasNext()){
						if(c!=0){
							query+=",";
						}
						
						String kiaveNomeColonna=it.next();
						String valore=valoriAggiornati.get(kiaveNomeColonna);

						
						
						
						

						if(kiaveNomeColonna.equals("data")){

							SimpleDateFormat ss=new SimpleDateFormat("dd/MM/yyyy");
							java.util.Date d=ss.parse(valore);

							query=query+""+kiaveNomeColonna+"=to_date('"+valore+"','dd/MM/yyyy') ";
						}else{


							query=query+""+kiaveNomeColonna+"='"+valore+"' ";



						}
c++;

					}
					
					query=query+" where "+uniquePropertyName+"='"+s+"' and org_id ="+org_id;
					if(c!=0){
					
					
						
					PreparedStatement pst=db.prepareStatement(query);
					pst.execute();
					pst.close();
					
						
				}

					
					
					
					}/*else{
						if(s.equals("")){
							
							Distrubutore ddd=new  Distrubutore("","","","","","","","",null,-1);
							ddd.insert(db, Integer.parseInt(org_id));
							
							
							
							
							
							
						}
						
					}*/
					
					
					
					
					

				}

			}
			
			
			String oggettoDaEliminare=context.getRequest().getParameter("oggetto");
			if(oggettoDaEliminare!=null && oggettoDaEliminare.equals("distributore")){
				
				
				String idOggetto=context.getRequest().getParameter("id");
				
				
				Distrubutore.deleteDistributore(idOggetto,tempid, db);
			
				
				
				
				
			}
			newOrg = new Organization(db, tempid);
			//check whether or not the owner is an active User
			
		
			 Collection<Distrubutore> coll=	newOrg.getListaDistributori();
			 
			 String aggiunto=context.getRequest().getParameter("aggiunto");
			 if(context.getRequest().getParameter("add")!=null){
					
					
					
				
					
					
					}
			tf.setItems( coll);
			tf.getWorksheet().removeAllChanges();

			tf.setColumnProperties( 
					"matricola", "data", "comune", "provincia", "indirizzo",
					"cap", "descrizioneTipoAlimenti","note","ubicazione","elimina"
			);
			tf.setStateAttr("restore");					
			HtmlRow row = (HtmlRow) tf.getTable().getRow();
			row.setUniqueProperty("matricola"); // the unique worksheet properties to identify the row


			tf.getTable().getRow().getColumn( "matricola" ).setTitle( "matricola" );
			tf.getTable().getRow().getColumn( "data" ).setTitle( "data Installazione" );
			tf.getTable().getRow().getColumn( "comune" ).setTitle( "comune" );
			tf.getTable().getRow().getColumn( "provincia" ).setTitle( "provincia" );
			tf.getTable().getRow().getColumn( "indirizzo" ).setTitle( "indirizzo" );
			tf.getTable().getRow().getColumn( "cap" ).setTitle( "cap" );
		
			tf.getTable().getRow().getColumn( "descrizioneTipoAlimenti" ).setTitle( "Alimento Distribuito" );
			tf.getTable().getRow().getColumn( "note" ).setTitle( "note" );
			tf.getTable().getRow().getColumn( "ubicazione" ).setTitle( "ubicazione" );
			tf.getTable().getRow().getColumn( "elimina" ).setTitle( "Elimina" );

			
			
			HtmlColumn cg1 = (HtmlColumn) tf.getTable().getRow().getColumn("descrizioneTipoAlimenti");
			cg1.getCellRenderer().setCellEditor( 
	        		new CellEditor()
	        		{	
	        			public Object getValue(Object item, String property, int rowCount)
	        			{
	        				LookupList alimenti = null;
							try {
								alimenti = new LookupList(db,"lookup_tipo_distributore");
							} catch (SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
	        		
	        				String temp	= (String) (new HtmlCellEditor()).getValue(item, property, rowCount);
	        				String id	= (String) (new HtmlCellEditor()).getValue(item, "alimentoDistribuito", rowCount);
	        				String matricola	= (String) (new HtmlCellEditor()).getValue(item, "matricola", rowCount);
	        				temp = (temp == null || "".equals(temp.trim())) ? ("-") : (temp);
	        				return alimenti.getHtmlSelect("alimentiDistribuiti_"+matricola, id);
	        			}
	        		}
	        
	        	);
			

			Limit limit = tf.getLimit();
			if(! limit.isExported() )
			{



				HtmlColumn cg = (HtmlColumn) tf.getTable().getRow().getColumn("matricola");
				cg.getFilterRenderer().setFilterEditor(new DroplistFilterEditor());
				//cg.setFilterable( false );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("data");
				cg.setFilterable( true );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("comune");
				cg.setFilterable( true );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("provincia");
				cg.setFilterable( false );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("indirizzo");
				cg.setFilterable( true );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("cap");
				cg.setFilterable( false );

			
				cg = (HtmlColumn) tf.getTable().getRow().getColumn("descrizioneTipoAlimenti");
				cg.setFilterable( false );
				cg.setEditable(false);

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("note");
				cg.setFilterable( false );
				
				cg = (HtmlColumn) tf.getTable().getRow().getColumn("ubicazione");
				cg.setFilterable( false );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("elimina");
				cg.setEditable(false);
				cg.getCellRenderer().setCellEditor( 
		        		new CellEditor()
		        		{	
		        			public Object getValue(Object item, String property, int rowCount)
		        			{
		        				String iddef=(String) (new HtmlCellEditor()).getValue(item, "matricola", rowCount);
		        				
		        				String orgid=(String) (new HtmlCellEditor()).getValue(item, "org_id", rowCount);
		        				Comuni comune = new Comuni();
		        				
		        				if(orgid.equals("-1"))
		        					return "Elimina";
		        				else
		        		
		        				return "<a href='DistributoriListFuoriRegione.do?orgId="+orgid+"&oggetto=distributore&id="+iddef+"'>Elimina </a>";
		        			}
		        		}
		        
		        	);
				cg.setFilterable(false);

			}

			ToolbarItem item7 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createFilterItem();
			item7.setTooltip( "Filtra" );
			tf.getToolbar().addToolbarItem( item7 );
			
			ToolbarItem item8 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createClearItem();
			item8.setTooltip( "Resetta Filtro" );
			tf.getToolbar().addToolbarItem( item8 );
												
			ToolbarItem item2 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createSaveWorksheetItem();
			item2.setTooltip( "Salva" );
			tf.getToolbar().addToolbarItem( item2 );
			
			ToolbarItem item18 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createPrevPageItem();
			item18.setTooltip( "Scorri pagina indietro" );
			tf.getToolbar().addToolbarItem( item18 );
			
			ToolbarItem item17 = ( new ToolbarItemFactoryImpl( tf.getWebContext(), tf.getCoreContext() ) ).createNextPageItem();
			item17.setTooltip( "Scorri pagina in avanti" );
			tf.getToolbar().addToolbarItem( item17 );
			
			
			
			String tabella = tf.render();
			context.getRequest().setAttribute( "tabella", tabella );
			
			PreparedStatement	stat_veicoli	= db.prepareStatement( "select count(*) as numero from distributori_automatici where org_id="+tempid );
			ResultSet			rs_veicoli		= stat_veicoli.executeQuery();
			int numeroDistributori=0;
			if(rs_veicoli.next())
				numeroDistributori=rs_veicoli.getInt(1);
			
			
			numeroDistributori=(numeroDistributori/15)+1;
			context.getRequest().setAttribute("numeroDistributori", numeroDistributori);
			
			LookupList siteList = new LookupList(db, "lookup_site_id");
			siteList.addItem(-1,  "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("SiteList", siteList);

			LookupList tipoDitributore = new LookupList(db, "lookup_tipo_distributore");
			tipoDitributore.addItem(-1, getSystemStatus(context).getLabel("calendar.none.4dashes"));
			context.getRequest().setAttribute("TipoDitributore", tipoDitributore);      

			LookupList statoLab = new LookupList(db, "lookup_stato_lab");
			statoLab.addItem(-1,  "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("statoLab", statoLab);

			LookupList categoriaRischioList = new LookupList(db, "lookup_org_catrischio");
			categoriaRischioList.addItem(-1,  "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("OrgCategoriaRischioList", categoriaRischioList);

			LookupList impianto = new LookupList(db, "lookup_impianto");
			impianto.addItem(-1,  "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("impianto", impianto);



		} catch (Exception e) {
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		addRecentItem(context, newOrg);
		String action = context.getRequest().getParameter("action");
		if (action != null && action.equals("modify")) {
			//If user is going to the modify form
			addModuleBean(context, "Accounts", "Modify Account Details");
			return ("DetailsOK");
		} else {
			//If user is going to the detail screen
			addModuleBean(context, "View Accounts", "View Account Details");
			context.getRequest().setAttribute("OrgDetails", newOrg);
			return getReturn(context, "Details");
		}
	}





	private String validateColumn(WorksheetColumn colonna, String changedValue) {


		String nomeColonna=colonna.getProperty();
String errore="";
		if(nomeColonna.equals("data")){

			String changedValue1 = colonna.getChangedValue();    

			try{
				SimpleDateFormat sd=new SimpleDateFormat("dd/MM/yyyy");
				sd.parse(changedValue1);


			}catch(Exception e){
				colonna.setError("Formato data Non Valido"); 
			errore="Formato data Non Valido usare il seguente formato : (gg/mm/aaaa)";
			}
if(errore.equals(""))
	colonna.removeError();







		}
		return errore;
	}

}


