package org.aspcfs.modules.macellazioninewsintesis.actions;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Vector;

import org.apache.commons.beanutils.RowSetDynaClass;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.macellazioninewsintesis.base.Art17;
import org.aspcfs.modules.macellazioninewsintesis.base.Art17ErrataCorrige;
import org.aspcfs.modules.macellazioninewsintesis.base.GenericBean;
import org.aspcfs.modules.macellazioninewsintesis.base.Partita;
import org.aspcfs.modules.macellazioninewsintesis.base.PartitaAjax;
import org.aspcfs.modules.macellazioninewsintesis.utils.ConfigTipo;
import org.aspcfs.modules.macellazionisintesis.base.Capo;
import org.aspcfs.modules.sintesis.base.SintesisStabilimento;
import org.aspcfs.modules.stabilimenti.base.Organization;
import org.aspcfs.modules.stabilimenti.base.OrganizationAddress;
import org.aspcfs.modules.troubletickets.base.Ticket;
import org.aspcfs.utils.AjaxCalls;
import org.aspcfs.utils.ControlliUfficialiUtil;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.LookupList;
import org.bouncycastle.ocsp.Req;
import org.jmesa.facade.TableFacade;
import org.jmesa.facade.TableFacadeFactory;
import org.jmesa.limit.Limit;
import org.jmesa.view.editor.CellEditor;
import org.jmesa.view.html.component.HtmlColumn;
import org.jmesa.view.html.editor.HtmlCellEditor;

import com.darkhorseventures.framework.actions.ActionContext;

public final class MacellazioniDocumenti extends CFSModule
{
	
	private static final SimpleDateFormat sdf  = new SimpleDateFormat( "dd/MM/yyyy" );
	private static final SimpleDateFormat sdf2 = new SimpleDateFormat( "yyyy-MM-dd" );
	ConfigTipo configTipo = null;
	
	public String executeCommandDefault(ActionContext context)
	{		
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		return executeCommandToRegistroMacellazioni(context);
	}

	public String executeCommandToRegistroMacellazioni(ActionContext context)
	{		
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		getConfigTipo(context);
		
		Connection db = null;
		
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ), true );
			context.getRequest().setAttribute( "OrgDetails", org );
			
			//Recupero date di macellazione per riempire la combo
			ArrayList<String> listaDateMacellazione = GenericBean.loadDateMacellazioneByStabilimento( context.getParameter( "altId" ), db, configTipo );
			context.getRequest().setAttribute( "listaDateMacellazione", listaDateMacellazione );
			
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		return "ToRegistroMacellazioniOK";
	}
	
	public String executeCommandToArt17(ActionContext context)
	{
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		getConfigTipo(context);
		
		Connection db = null;
	
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ),true );
			context.getRequest().setAttribute( "OrgDetails", org );
			
			//Recupero date di macellazione per riempire la combo
			ArrayList<String> listaDateMacellazione = GenericBean.loadDateMacellazioneByStabilimento( context.getParameter( "altId" ), db, configTipo );
			context.getRequest().setAttribute( "listaDateMacellazione", listaDateMacellazione );
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		return "ToArt17OK";
	}
		
	public String executeCommandToModello10(ActionContext context) throws Exception{
		
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
		
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ) , true);
			context.getRequest().setAttribute( "OrgDetails", org );
			
			//Recupero date di macellazione per riempire la combo
			//ArrayList<String> listaDateMacellazione = Capo.loadDateMacellazioneByStabilimento( context.getParameter( "altId" ), db );
			ArrayList<String> listaDateMacellazione = Capo.loadDateMacellazioneByStabilimentoTamponi( context.getParameter( "altId" ), db );
			context.getRequest().setAttribute( "listaDateMacellazione", listaDateMacellazione );
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		
		/* post - controllo */
		
		getConfigTipo(context);
			
		String dataSeduta;
		String numeroSeduta;
		
		dataSeduta = context.getParameter("dataSeduta");
		numeroSeduta = context.getParameter("numeroSeduta");
		
		context.getRequest().setAttribute("dataSeduta", dataSeduta);
		context.getRequest().setAttribute("numeroSeduta", numeroSeduta);
		
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ),true );
			context.getRequest().setAttribute( "OrgDetails", org );
			  
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}

		
		return "toMod10_rev9_OK";
	}
	
	public String executeCommandEsercentiArt17(ActionContext context)
	{
	    getConfigTipo(context);
		
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
		
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ),true );
			context.getRequest().setAttribute( "OrgDetails", org );
			
			String data = context.getParameter( "comboDateMacellazione" );
			Timestamp d = null;
			try
			{
				d = new Timestamp( sdf.parse( data ).getTime() );
			}
			catch ( Exception e )
			{
				e.printStackTrace();
				context.getRequest().setAttribute( "messaggio", "Selezionare una data valida" );
				return executeCommandToArt17(context);
			}
			
			String suffissoVista = configTipo.getSuffissoViste();
			String select = "select distinct id_esercente, id_macello, esercente, data_macellazione, sum(numero_capi) as numero_capi from ( " +
            " SELECT * FROM m_esercenti_macellazioni" + suffissoVista + " WHERE id_macello = ? AND data_macellazione = ? union " +
		    " SELECT * FROM m_esercenti_macellazioni_sedute WHERE id_macello = ? AND data_macellazione = ?  ) as t " +
            " group by t.id_esercente,id_macello, esercente, data_macellazione ";
			PreparedStatement stat = db.prepareStatement( select );
					
			stat.setInt( 1, org.getAltId() );
			stat.setTimestamp( 2, d );
			stat.setInt( 3, org.getAltId() );
			stat.setTimestamp( 4, d );
			
			ResultSet		res		= stat.executeQuery();
			RowSetDynaClass	rsdc	= new RowSetDynaClass( res );
			
			if( rsdc.getRows().size() == 0 )
			{
				context.getRequest().setAttribute( "messaggio", "Nessun " + configTipo.getDescrizioneBean().toLowerCase() + " macellato il " + data );
				return executeCommandToArt17(context);
			}
			
			TableFacade tf = TableFacadeFactory.createTableFacade( "2", context.getRequest() );
			tf.setItems( rsdc.getRows() );
			tf.setColumnProperties( "esercente", "numero_capi"  );
			tf.setStateAttr("restore");

			Limit limit = tf.getLimit();
			if( limit.isExported() )
			{
				tf.render();
				return null;
			}
			else
			{
				HtmlColumn cg = (HtmlColumn) tf.getTable().getRow().getColumn("esercente");
				cg.setTitle( "Destinatario Carni" );
				cg.getCellRenderer().setCellEditor( 
		        		new CellEditor()
		        		{	
		        			public Object getValue(Object item, String property, int rowCount)
		        			{
		        				String ret = "";
		        				String temp		= (String) (new HtmlCellEditor()).getValue(item, property, rowCount);
		        				String id_eserc	= (String) (new HtmlCellEditor()).getValue(item, "id_esercente", rowCount);
		        				String id_mac	= (String) (new HtmlCellEditor()).getValue(item, "id_macello", rowCount);
		        				String data		= (String) (new HtmlCellEditor()).getValue(item, "data_macellazione", rowCount);
		        				try
		        				{
									data = sdf.format( sdf2.parse( data ) );
								}
		        				catch (ParseException e)
		        				{
									e.printStackTrace();
								}
		        				//COSA ZOZZA APPARATA
		        				temp = (temp == null || "".equals(temp.trim())) ? ("-") : (temp);
//		        				if(id_eserc.equals("-999")){
//		        						
//		        						
//										ret = "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&nomeEsercente=" + temp.replaceAll("&amp;", "u38") +"&orgId=" + id_mac + "&data=" 
//										+ data + "\">" + temp + "</a></div>";
//		        				}
//		        				else{
//		        					ret = "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&orgId=" + id_mac + "&data=" 
//		        							+ data + "\">" + temp + "</a></div>";
//		        				}
		        				
//		        				if(id_eserc.equals("-999")){
//	        						
//	        						
//									ret = "<a target=\"_blank\" href=\"MacellazioniDocumentiNew.do?command=Art17&esercente=" + id_eserc + "&nomeEsercente=" + temp.replaceAll("&amp;", "u38") +"&orgId=" + id_mac + "&data=" 
//									+ data + "\">" + temp + "</a></div>";
//	        				}
//	        				else{
//	        					ret = "<a target=\"_blank\" href=\"MacellazioniDocumentiNew.do?command=Art17&esercente=" + id_eserc + "&orgId=" + id_mac + "&data=" 
//	        							+ data + "\">" + temp + "</a></div>";
//	        				}
		        		
		        		// aggiunti link nuova gestione		
		        				if(id_eserc.equals("-999")){
        							ret = ret+ "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&nomeEsercente=" + temp.replaceAll("&amp;", "u38") +"&altId=" + id_mac + "&data=" 
										+ data + "\">" + temp + " </a></div>";
        				}
        				else{
        					ret = ret + "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&altId=" + id_mac + "&data=" 
		       							+ data + "\">"+ temp + " </a></div>";
        				}
		        		//fine nuova gestione	
		        				
		        				return ret;
		        			}
		        		}
		        
		        	);
				
				cg = (HtmlColumn) tf.getTable().getRow().getColumn("numero_capi");
				cg.setTitle( configTipo.getLabelCapiMacellati() );
				cg.setFilterable( false );
			}

			String tabella = tf.render();
			context.getRequest().setAttribute( "tabella", tabella );
			
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
				
		return "EsercentiArt17OK";
	}

	
		public String executeCommandViewModuleErrataCorrigeArt17(ActionContext context) throws Exception{
		
		getConfigTipo(context);
		
		String idPartita = context.getRequest().getParameter(configTipo.getNomeVariabileIdJsp());
		int altId = -1;
		String tipoMacello = context.getRequest().getParameter("tipoMacello");
		if (tipoMacello == null)
			tipoMacello = (String) context.getRequest().getAttribute("tipoMacello");
		
		Partita p = null;
		
		String altIdString = context.getRequest().getParameter("altId");
		if (altIdString == null)
			 altIdString = (String) context.getRequest().getAttribute("altId");
		
		if (altIdString!=null && !altIdString.equals(""))
			altId = Integer.parseInt(altIdString);
		
		Connection db = null;
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento (db, altId, true);
			context.getRequest().setAttribute("OrgDetails", org);
			
			p = (Partita) Partita.load(idPartita, db, configTipo);
			//p = GenericBean.load(idPartita, db, configTipo);
			
			context.getRequest().setAttribute(configTipo.getNomeBeanJsp(), p);
			
			if (p.getErrata_corrige_generati()>=10){
				context.getRequest().setAttribute("Error", "Numero massimo moduli Errata Corrige generati raggiunto per questo capo.");
				return "errorPage";
				}
			
			LookupList aslList	= new LookupList( db, "lookup_site_id" );
			context.getRequest().setAttribute("aslList", aslList);
			
			LookupList specieList	= new LookupList( db, "m_lookup_specie" );
			context.getRequest().setAttribute("specieList", specieList);
			
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			String ip = context.getIpAddress();
			String user_name = user.getUserRecord().getUsername();
			context.getRequest().setAttribute("userIp", ip);
			context.getRequest().setAttribute("userName", user_name);
			
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
			Date date = new Date();
			context.getRequest().setAttribute("timeNow",dateFormat.format(date));
			
			String numArt17 = "";
			
			Art17 art17 = null;
			
			art17 = Art17.find( org.getAltId(), p.getDestinatario_1_id(), p.getDestinatario_1_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+ " "+ p.getDestinatario_1_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_2_id(), p.getDestinatario_2_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+ " " + p.getDestinatario_2_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_3_id(), p.getDestinatario_3_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+ " "+ p.getDestinatario_3_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_4_id(), p.getDestinatario_4_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+ " "+ p.getDestinatario_4_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_5_id(), p.getDestinatario_5_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_5_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_6_id(), p.getDestinatario_6_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_6_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_7_id(), p.getDestinatario_7_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_7_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_8_id(), p.getDestinatario_8_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_8_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_9_id(), p.getDestinatario_9_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_9_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_10_id(), p.getDestinatario_10_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_10_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_11_id(), p.getDestinatario_11_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_11_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_12_id(), p.getDestinatario_12_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_12_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_13_id(), p.getDestinatario_13_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_13_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_14_id(), p.getDestinatario_14_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_14_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_15_id(), p.getDestinatario_15_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_15_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_16_id(), p.getDestinatario_16_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_16_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_17_id(), p.getDestinatario_17_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_17_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_18_id(), p.getDestinatario_18_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_18_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_19_id(), p.getDestinatario_19_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_19_nome()+"; ";
			art17 = Art17.find( org.getAltId(), p.getDestinatario_20_id(), p.getDestinatario_20_nome(),p.getVpm_data(),  db);
			if (art17!=null)
				numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_20_nome()+"; ";
			context.getRequest().setAttribute("art17", numArt17);
			
			HashMap<String,ArrayList<Contact>> listaUtentiAttiviV =ControlliUfficialiUtil.getUtentiAttiviperaslVeterinari(db, user.getSiteId());
			context.getRequest().setAttribute("listaVeterinari", listaUtentiAttiviV);
			
			int idMacello = -1;
			String nomeMacello = "";
			String comuneMacello = "";
			int aslMacello = -1;
			String approvalNumber = "";
			int orgId = -1;
		
				idMacello = altId;
				SintesisStabilimento macello = new SintesisStabilimento(db, idMacello, true);
				nomeMacello = macello.getOperatore().getRagioneSociale();
				approvalNumber = macello.getApprovalNumber();
				aslMacello = macello.getIdAsl();
				comuneMacello = macello.getIndirizzo().getDescrizioneComune() + " ("+  macello.getIndirizzo().getDescrizioneComune()+")";
			
			context.getRequest().setAttribute("nomeMacello", nomeMacello);	
			context.getRequest().setAttribute("approvalNumber", approvalNumber);	
			context.getRequest().setAttribute("comuneMacello", comuneMacello);	
			context.getRequest().setAttribute("aslMacello", String.valueOf(aslMacello));
				
//			String nomeEsercente ="";
//			String indirizzoEsercente="";
//			
//			if (art17.getId_esercente()>0 && art17.getId_esercente()<20000000){
//				Organization esercente = new Organization(db, art17.getId_esercente());
//				nomeEsercente = esercente.getName();
//				Iterator iaddressM = esercente.getAddressList().iterator();
//			    while (iaddressM.hasNext()) {
//			      OrganizationAddress thisAddress = (OrganizationAddress)iaddressM.next();
//			      if (thisAddress.getType()==5)
//			    	  indirizzoEsercente = " - "+ thisAddress.getStreetAddressLine1()+", "+  thisAddress.getCity() + " ("+ thisAddress.getState()+")";
//			}
//			}
//			else{
//				SintesisStabilimento esercente = new SintesisStabilimento(db, art17.getId_esercente(), true);
//				nomeEsercente =esercente.getOperatore().getRagioneSociale();
//		    	  indirizzoEsercente = " - "+ esercente.getIndirizzo().getDescrizioneToponimo() + " " + esercente.getIndirizzo().getVia()+ " "+esercente.getIndirizzo().getCivico()+", "+  esercente.getIndirizzo().getDescrizione_provincia() + " ("+ esercente.getIndirizzo().getDescrizione_provincia()+")";
//			}
//			context.getRequest().setAttribute("nomeEsercente", nomeEsercente);
//			context.getRequest().setAttribute("indirizzoEsercente", indirizzoEsercente);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			this.freeConnection(context, db);
		}
		
		if (context.getRequest().getAttribute("ErrataCorrige")!=null)
			return "art17erratacorrigeStampaOk";
		
		return "art17erratacorrigeOk";
		
	}
	
public String executeCommandSalvaModuleErrataCorrigeArt17(ActionContext context) throws Exception{
		
		Art17ErrataCorrige ErrataCorrige = new Art17ErrataCorrige(context);
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		String ip = context.getIpAddress();
		Connection db = null;
		int result1 = -1;
		int result2 = -1;
	//	int result3 = -1;
		try
		{
			db = this.getConnection( context );
			
			db.setAutoCommit(false);
			
			ErrataCorrige.setIdUtente(user.getUserId());
			ErrataCorrige.setIpUtente(ip);
			ErrataCorrige.setNomeUtente(user.getUsername());
			
			//Controllo su identificativo gia' esistente
			Partita p = (Partita) Partita.load(String.valueOf(ErrataCorrige.getIdPartita()), db, configTipo);
			AjaxCalls ac = new AjaxCalls();
			String identificativo = p.getCd_partita();
			if (ErrataCorrige.isNumeroModificato()){
				identificativo = ErrataCorrige.getNumeroCorretto();
				try {
					long numeroPartita = Long.parseLong(identificativo);
				}
				catch (Exception e){
				//	this.freeConnection(context, db);
					context.getRequest().setAttribute( "messaggio", "Numero partita non conforme." );
					context.getRequest().setAttribute("altId", String.valueOf(ErrataCorrige.getIdMacello()));
					return executeCommandViewModuleErrataCorrigeArt17( context );
				}
			}
			PartitaAjax ca = ac.isCapoEsistenteUpdateSintesis(ErrataCorrige.getIdPartita(),identificativo,p.getCd_codice_azienda_provenienza(),p.getCd_num_capi_ovini(),p.getCd_num_capi_caprini());
			if( ca.isEsistente() ){
			//	this.freeConnection(context, db);
				context.getRequest().setAttribute( "messaggio", "Numero partita gia' presente." );
				context.getRequest().setAttribute("altId", String.valueOf(ErrataCorrige.getIdMacello()));
				return executeCommandViewModuleErrataCorrigeArt17( context );
			}
			
			
			
			result1 = ErrataCorrige.insert(db);
			result2 = ErrataCorrige.aggiornaPartita(db);
			//result3 = ErrataCorrige.aggiornaArt17(db);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			db.rollback();
			e.printStackTrace();
			String errore = "Errore su ";
			if (result1==-1)
				errore = errore + "inserimento modulo Errata Corrige.";
			if (result2==-1)
				errore = errore + "modifica partita. Modulo errata corrige NON inserito.";
//			if (result3==-1)
//				errore = errore + "modifica info art17. Modulo errata corrige NON inserito.";
				
			context.getRequest().setAttribute("Error", errore);
			return "errorPage";
		}
		finally
		{
			db.setAutoCommit(true);
			db.close();
			this.freeConnection(context, db);
		}
		
		context.getRequest().setAttribute("definitivoDocumentale", "true");
		context.getRequest().setAttribute("tipoMacello", "2");
		context.getRequest().setAttribute("altId", context.getRequest().getParameter("idMacello"));
		context.getRequest().setAttribute(configTipo.getNomeVariabileIdJsp(), context.getRequest().getParameter(configTipo.getNomeVariabileIdJsp()));
		context.getRequest().setAttribute("idPartita", context.getRequest().getParameter("idPartita"));
		
		context.getRequest().setAttribute("ErrataCorrige", ErrataCorrige);
		context.getRequest().setAttribute("idErrataCorrige", ErrataCorrige.getId());
		//return executeCommandViewModuleErrataCorrigeArt17(context);
		return "art17erratacorrigeSalvaOk";
		
	}


	
public String executeCommandViewListaModuleErrataCorrigeArt17(ActionContext context) throws Exception{
	getConfigTipo(context);
	String idPartita = context.getRequest().getParameter("idPartita");
	int altId = -1;
	String tipoMacello = context.getRequest().getParameter("tipoMacello");
	if (tipoMacello == null)
		tipoMacello = (String) context.getRequest().getAttribute("tipoMacello");
	
	Partita p = null;
	
	
	String altIdString = context.getRequest().getParameter("altId");
	if (altIdString == null)
		 altIdString = (String) context.getRequest().getAttribute("altId");
	
	if (altIdString!=null && !altIdString.equals(""))
		altId = Integer.parseInt(altIdString);
	
	Connection db = null;
	try
	{
		db = this.getConnection( context );
		SintesisStabilimento org = new SintesisStabilimento (db, altId, true);
		context.getRequest().setAttribute("OrgDetails", org);
		
		p = (Partita) Partita.load(idPartita, db, configTipo);
		context.getRequest().setAttribute("Partita", p);
		
		Art17ErrataCorrige ec = new Art17ErrataCorrige();
		ec.setIdMacello(altId);
		ec.setIdPartita(idPartita);
		
		Vector ecList = new Vector();
		ecList = ec.load(db);
		context.getRequest().setAttribute("ecList", ecList);
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally
	{
		this.freeConnection(context, db);
	}
	
		return "art17erratacorrigeListaOk";
	}

public String executeCommandViewErrataCorrigeArt17(ActionContext context) throws Exception{
	getConfigTipo(context);
	String idErrataCorrige = context.getRequest().getParameter("idErrataCorrige");
	String idPartita = context.getRequest().getParameter("idPartita");
	int altId = Integer.parseInt(context.getRequest().getParameter("altId"));
	
	Connection db = null;
	Partita p = null;
	try
	{
		db = this.getConnection( context );
		SintesisStabilimento org = new SintesisStabilimento (db, altId, true);
		context.getRequest().setAttribute("OrgDetails", org);
		
			p = (Partita) Partita.load(idPartita, db, configTipo);
		
		context.getRequest().setAttribute("Partita", p);
		
		LookupList aslList	= new LookupList( db, "lookup_site_id" );
		context.getRequest().setAttribute("aslList", aslList);
		
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		String ip = context.getIpAddress();
		String user_name = user.getUserRecord().getUsername();
		context.getRequest().setAttribute("userIp", ip);
		context.getRequest().setAttribute("userName", user_name);
		
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		Date date = new Date();
		context.getRequest().setAttribute("timeNow",dateFormat.format(date));
		
//		String numArt17 = "";
//		
//		Art17 art17 = null;
//		
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_1_id(), p.getDestinatario_1_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+ " "+ p.getDestinatario_1_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_2_id(), p.getDestinatario_2_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+ " " + p.getDestinatario_2_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_3_id(), p.getDestinatario_3_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+ " "+ p.getDestinatario_3_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_4_id(), p.getDestinatario_4_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+ " "+ p.getDestinatario_4_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_5_id(), p.getDestinatario_5_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_5_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_6_id(), p.getDestinatario_6_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_6_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_7_id(), p.getDestinatario_7_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_7_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_8_id(), p.getDestinatario_8_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_8_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_9_id(), p.getDestinatario_9_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_9_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_10_id(), p.getDestinatario_10_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_10_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_11_id(), p.getDestinatario_11_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_11_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_12_id(), p.getDestinatario_12_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_12_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_13_id(), p.getDestinatario_13_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_13_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_14_id(), p.getDestinatario_14_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_14_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_15_id(), p.getDestinatario_15_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_15_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_16_id(), p.getDestinatario_16_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_16_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_17_id(), p.getDestinatario_17_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_17_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_18_id(), p.getDestinatario_18_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_18_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_19_id(), p.getDestinatario_19_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_19_nome()+"; ";
//		art17 = Art17.find( org.getOrgId(), p.getDestinatario_20_id(), p.getDestinatario_20_nome(),p.getDataSessioneMacellazione(),  db);
//		if (art17!=null)
//			numArt17 += art17.getProgressivo() + "/" + art17.getAnno() + "/" + org.getApprovalNumber()+" "+ p.getDestinatario_20_nome()+"; ";
//		context.getRequest().setAttribute("art17", numArt17);
		
		HashMap<String,ArrayList<Contact>> listaUtentiAttiviV =ControlliUfficialiUtil.getUtentiAttiviperaslVeterinari(db, user.getSiteId());
		context.getRequest().setAttribute("listaVeterinari", listaUtentiAttiviV);
		
		String nomeEsercente ="";
		String indirizzoEsercente="";
		
		if (p.getDestinatario_1_id()>0 && DatabaseUtils.getTipologiaPartizione(db, p.getDestinatario_1_id()) == Ticket.ALT_ORGANIZATION){
			Organization esercente = new Organization(db, p.getDestinatario_1_id());
			nomeEsercente = esercente.getName();
			Iterator iaddressM = esercente.getAddressList().iterator();
		    while (iaddressM.hasNext()) {
		      OrganizationAddress thisAddress = (OrganizationAddress)iaddressM.next();
		      if (thisAddress.getType()==5)
		    	  indirizzoEsercente = " - "+ thisAddress.getStreetAddressLine1()+", "+  thisAddress.getCity() + " ("+ thisAddress.getState()+")";
		}
		}
		else if (p.getDestinatario_1_id()>0 && DatabaseUtils.getTipologiaPartizione(db, p.getDestinatario_1_id()) == Ticket.ALT_SINTESIS){
			SintesisStabilimento esercente = new SintesisStabilimento(db, p.getDestinatario_1_id(), true);
			nomeEsercente =esercente.getOperatore().getRagioneSociale();
	    	  indirizzoEsercente = " - "+ esercente.getIndirizzo().getDescrizioneToponimo() + " " + esercente.getIndirizzo().getVia()+ " "+esercente.getIndirizzo().getCivico()+", "+  esercente.getIndirizzo().getDescrizione_provincia() + " ("+ esercente.getIndirizzo().getDescrizione_provincia()+")";
		}
		context.getRequest().setAttribute("nomeEsercente", nomeEsercente);
		context.getRequest().setAttribute("indirizzoEsercente", indirizzoEsercente);
		
		
		int idMacello = -1;
		String nomeMacello = "";
		String comuneMacello = "";
		int aslMacello = -1;
		String approvalNumber = "";
		
			idMacello = altId;
			SintesisStabilimento macello = new SintesisStabilimento(db, idMacello, true);
			nomeMacello = macello.getOperatore().getRagioneSociale();
			approvalNumber = macello.getApprovalNumber();
			aslMacello = macello.getIdAsl();
			comuneMacello = macello.getIndirizzo().getDescrizioneComune() + " ("+  macello.getIndirizzo().getDescrizioneComune()+")";
		
			context.getRequest().setAttribute("nomeMacello", nomeMacello);	
			context.getRequest().setAttribute("approvalNumber", approvalNumber);	
			context.getRequest().setAttribute("comuneMacello", comuneMacello);	
			context.getRequest().setAttribute("aslMacello", String.valueOf(aslMacello));	
		
		int id = Integer.parseInt(idErrataCorrige);
		Art17ErrataCorrige ec = new Art17ErrataCorrige(db, id);
		context.getRequest().setAttribute("ErrataCorrige", ec);
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally
	{
		this.freeConnection(context, db);
	}
		return "art17erratacorrigeStampaOk";
}
	
private void getConfigTipo(ActionContext context)
{
	if(context.getSession().getAttribute("configTipo")!=null){
		Object o = context.getSession().getAttribute("configTipo");
		
		try {
			configTipo = (ConfigTipo) context.getSession().getAttribute("configTipo");
			}
		catch (Exception e){
			org.aspcfs.modules.macellazioninewsintesis.utils.ConfigTipo configTipo2 = (org.aspcfs.modules.macellazioninewsintesis.utils.ConfigTipo) context.getSession().getAttribute("configTipo");
			final int tipo = configTipo2.getIdTipo();
			configTipo = new ConfigTipo(tipo);
			context.getSession().setAttribute("configTipo", configTipo);
		}
}
}	
	
	public String executeCommandEsercentiArt17Sedute(ActionContext context)
	{
	    getConfigTipo(context);
		
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
		
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ),true );
			context.getRequest().setAttribute( "OrgDetails", org );
			
			String data = context.getParameter( "comboDateMacellazione" );
			Timestamp d = null;
			try
			{
				d = new Timestamp( sdf.parse( data ).getTime() );
			}
			catch ( Exception e )
			{
				e.printStackTrace();
				context.getRequest().setAttribute( "messaggio", "Selezionare una data valida" );
				return executeCommandToArt17(context);
			}
			
			int idSeduta = Integer.parseInt(context.getRequest().getParameter("idSeduta"));
			
			String suffissoVista = configTipo.getSuffissoViste()+"_sedute";
			String select = "SELECT * FROM m_esercenti_macellazioni" + suffissoVista + " WHERE id_seduta = ? AND data_macellazione = ?";
			PreparedStatement stat = db.prepareStatement( select );
					
			stat.setInt( 1, idSeduta );
			stat.setTimestamp( 2, d );
					
			ResultSet		res		= stat.executeQuery();
			RowSetDynaClass	rsdc	= new RowSetDynaClass( res );
			
			if( rsdc.getRows().size() == 0 )
			{
				context.getRequest().setAttribute( "messaggio", "Nessuna seduta macellata il " + data );
				return executeCommandToArt17(context);
			}
			
			TableFacade tf = TableFacadeFactory.createTableFacade( "2", context.getRequest() );
			tf.setItems( rsdc.getRows() );
			tf.setColumnProperties( "esercente", "numero_capi"  );
			tf.setStateAttr("restore");

			Limit limit = tf.getLimit();
			if( limit.isExported() )
			{
				tf.render();
				return null;
			}
			else
			{
				HtmlColumn cg = (HtmlColumn) tf.getTable().getRow().getColumn("esercente");
				cg.setTitle( "Destinatario Carni" );
				cg.getCellRenderer().setCellEditor( 
		        		new CellEditor()
		        		{	
		        			public Object getValue(Object item, String property, int rowCount)
		        			{
		        				String ret = "";
		        				String temp		= (String) (new HtmlCellEditor()).getValue(item, property, rowCount);
		        				String id_eserc	= (String) (new HtmlCellEditor()).getValue(item, "id_esercente", rowCount);
		        				String id_mac	= (String) (new HtmlCellEditor()).getValue(item, "id_macello", rowCount);
		        				String data		= (String) (new HtmlCellEditor()).getValue(item, "data_macellazione", rowCount);
		        				try
		        				{
									data = sdf.format( sdf2.parse( data ) );
								}
		        				catch (ParseException e)
		        				{
									e.printStackTrace();
								}
		        				//COSA ZOZZA APPARATA
		        				temp = (temp == null || "".equals(temp.trim())) ? ("-") : (temp);
//		        				if(id_eserc.equals("-999")){
//		        						
//		        						
//										ret = "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&nomeEsercente=" + temp.replaceAll("&amp;", "u38") +"&orgId=" + id_mac + "&data=" 
//										+ data + "\">" + temp + "</a></div>";
//		        				}
//		        				else{
//		        					ret = "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&orgId=" + id_mac + "&data=" 
//		        							+ data + "\">" + temp + "</a></div>";
//		        				}
		        				
//		        				if(id_eserc.equals("-999")){
//	        						
//	        						
//									ret = "<a target=\"_blank\" href=\"MacellazioniDocumentiNew.do?command=Art17&esercente=" + id_eserc + "&nomeEsercente=" + temp.replaceAll("&amp;", "u38") +"&orgId=" + id_mac + "&data=" 
//									+ data + "\">" + temp + "</a></div>";
//	        				}
//	        				else{
//	        					ret = "<a target=\"_blank\" href=\"MacellazioniDocumentiNew.do?command=Art17&esercente=" + id_eserc + "&orgId=" + id_mac + "&data=" 
//	        							+ data + "\">" + temp + "</a></div>";
//	        				}
		        		
		        		// aggiunti link nuova gestione		
		        				if(id_eserc.equals("-999")){
        							ret = ret+ "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&nomeEsercente=" + temp.replaceAll("&amp;", "u38") +"&orgId=" + id_mac + "&data=" 
										+ data + "&idSeduta="+idSeduta + "\">" + temp + " </a></div>";
        				}
        				else{
        					ret = ret + "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&orgId=" + id_mac + "&data=" 
		       							+ data + "&idSeduta="+idSeduta + "\">"+ temp + " </a></div>";
        				}
		        		//fine nuova gestione	
		        				
		        				return ret;
		        			}
		        		}
		        
		        	);
				
				cg = (HtmlColumn) tf.getTable().getRow().getColumn("numero_capi");
				cg.setTitle( configTipo.getLabelCapiMacellati() );
				cg.setFilterable( false );
			}

			String tabella = tf.render();
			context.getRequest().setAttribute( "tabella", tabella );
			
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
				
		return "EsercentiArt17OK";
	}
	
}
