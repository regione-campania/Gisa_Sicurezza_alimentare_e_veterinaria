package org.aspcfs.modules.campioni.base;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import org.aspcfs.modules.campioni.util.CampioniUtil;
import org.aspcfs.utils.web.LookupElement;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;

public class CampioniHtmlFields {

private int id;
private int id_piano_monitoraggio;
private String nome_campo;
private String tipo_campo;
private String label_campo;
private String tabella_lookup;
private String javascript_function;
private String javascript_function_evento;
private String link_value;
private int ordine_campo;
private String valore_campo;
private String tipo_controlli_date;
private String  label_campo_controlli_date;
private int maxlength;
private int id_specie_only;
private int only_hd;
private String label_link;
private boolean multiple;
private boolean obbligatorio;
private boolean gestione_pnaa;

private String valore_campione;
private String html;

public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public int getId_piano_monitoraggio() {
	return id_piano_monitoraggio;
}
public void setId_piano_monitoraggio(int id_piano_monitoraggio) {
	this.id_piano_monitoraggio = id_piano_monitoraggio;
}
public String getNome_campo() {
	return nome_campo;
}
public void setNome_campo(String nome_campo) {
	this.nome_campo = nome_campo;
}
public String getTipo_campo() {
	return tipo_campo;
}
public void setTipo_campo(String tipo_campo) {
	this.tipo_campo = tipo_campo;
}
public String getLabel_campo() {
	return label_campo;
}
public void setLabel_campo(String label_campo) {
	this.label_campo = label_campo;
}
public String getTabella_lookup() {
	return tabella_lookup;
}
public void setTabella_lookup(String tabella_lookup) {
	this.tabella_lookup = tabella_lookup;
}
public String getJavascript_function() {
	return javascript_function;
}
public void setJavascript_function(String javascript_function) {
	this.javascript_function = javascript_function;
}
public String getJavascript_function_evento() {
	return javascript_function_evento;
}
public void setJavascript_function_evento(String javascript_function_evento) {
	this.javascript_function_evento = javascript_function_evento;
}
public String getLink_value() {
	return link_value;
}
public void setLink_value(String link_value) {
	this.link_value = link_value;
}
public int getOrdine_campo() {
	return ordine_campo;
}
public void setOrdine_campo(int ordine_campo) {
	this.ordine_campo = ordine_campo;
}
public String getValore_campo() {
	return valore_campo;
}
public void setValore_campo(String valore_campo) {
	this.valore_campo = valore_campo;
}
public String getTipo_controlli_date() {
	return tipo_controlli_date;
}
public void setTipo_controlli_date(String tipo_controlli_date) {
	this.tipo_controlli_date = tipo_controlli_date;
}
public String getLabel_campo_controlli_date() {
	return label_campo_controlli_date;
}
public void setLabel_campo_controlli_date(String label_campo_controlli_date) {
	this.label_campo_controlli_date = label_campo_controlli_date;
}
public int getMaxlength() {
	return maxlength;
}
public void setMaxlength(int maxlength) {
	this.maxlength = maxlength;
}
public int getId_specie_only() {
	return id_specie_only;
}
public void setId_specie_only(int id_specie_only) {
	this.id_specie_only = id_specie_only;
}
public int getOnly_hd() {
	return only_hd;
}
public void setOnly_hd(int only_hd) {
	this.only_hd = only_hd;
}
public String getLabel_link() {
	return label_link;
}
public void setLabel_link(String label_linkM) {
	this.label_link = label_linkM;
}
public boolean isMultiple() {
	return multiple;
}
public void setMultiple(boolean multiple) {
	this.multiple = multiple;
}
public boolean isObbligatorio() {
	return obbligatorio;
}
public void setObbligatorio(boolean obbligatorio) {
	this.obbligatorio = obbligatorio;
}
public boolean isGestione_pnaa() {
	return gestione_pnaa;
}
public void setGestione_pnaa(boolean gestione_pnaa) {
	this.gestione_pnaa = gestione_pnaa;
}

public void buildRecord(Connection db, ResultSet rs) throws SQLException{
	this.id = rs.getInt("id");
	  this.id_piano_monitoraggio=rs.getInt("id_piano_monitoraggio");
	  this.nome_campo=  rs.getString("nome_campo");
	  this.tipo_campo=  rs.getString("tipo_campo");
	  this.label_campo=  rs.getString("label_campo");
	  this.tabella_lookup=  rs.getString("tabella_lookup");
	  this.javascript_function=  rs.getString("javascript_function");
	  this.javascript_function_evento=  rs.getString("javascript_function_evento");
	  this.link_value =  rs.getString("link_value");
	  this.ordine_campo = rs.getInt("ordine_campo");
	  this.valore_campo =  rs.getString("valore_campo");
	  this.tipo_controlli_date=  rs.getString("tipo_controlli_date");
	  this.label_campo_controlli_date=  rs.getString("label_campo_controlli_date");
	  this.maxlength = rs.getInt("maxlength");
	  this.id_specie_only = rs.getInt("id_specie_only");
	  this.only_hd=  rs.getInt("only_hd");
	  this.label_link=  rs.getString("label_link");
	  this.multiple=  rs.getBoolean("multiple");
	  this.obbligatorio =  rs.getBoolean("obbligatorio");
	  this.gestione_pnaa =  rs.getBoolean("gestione_pnaa");
	  this.valore_campione=  rs.getString("valore_campione");
	 // this.setHtml(generaHtml(db));
	  
	
}
public String getValore_campione() {
	return valore_campione;
}
public void setValore_campione(String valore_campione) {
	this.valore_campione = valore_campione;
}

private String generaHtml(Connection db) throws SQLException{
	if (tipo_campo.equalsIgnoreCase("select")){
		 LookupList l = new LookupList(db, tabella_lookup);
		 l.setJsEvent(javascript_function);
		 if (multiple){
			 l.setMultiple(true);
			 l.setSelectSize(5);
			 return  l.getHtmlSelect(nome_campo, -2);
		 }
		 else{
			 return  l.getHtmlSelect(nome_campo, valore_campione);
		 }
			 
	}
	if (tipo_campo.equalsIgnoreCase("text")){
		String text = "<input type=\"text\" id=\""+nome_campo+"\" name=\""+nome_campo+"\" value=\""+valore_campo+"\"/>";
		 return  text;
		}
	if (tipo_campo.equalsIgnoreCase("hidden")){
		String text = "<input type=\"hidden\" id=\""+nome_campo+"\" name=\""+nome_campo+"\" value=\""+valore_campo+"\"/>";
		 return  text;
		}
	if (tipo_campo.equalsIgnoreCase("data")){
		String text = "<input type=\"text\" readonly id=\""+nome_campo+"\" name=\""+nome_campo+"\" value=\""+valore_campo+"\"/>";
		String data = "<a href=\"#\" onClick=\"cal19.select2(document.forms[0]."+nome_campo+",\'anchor19\',\'dd/MM/yyyy\'); return false;\" NAME=\"anchor19\" ID=\"anchor19\"><img src=\"images/icons/stock_form-date-field-16.gif\" border=\"0\" align=\"absmiddle\"></a>";
		return text+data;
		 
	}
		
	
	return "";
}
public String getHtml() {
	return html;
}
public void setHtml(String html) {
	this.html = html;
}
	

public LinkedHashMap<String, String> costruisciHtmlDaHashMap(Connection db, LinkedHashMap<String, ArrayList<CampioniHtmlFields>> campi) throws SQLException{

	String nomeCampo="";
	String html = "";
	String nomeLabel ="";
	String valoreCampione ="";
	ArrayList<CampioniHtmlFields> campiHash = new ArrayList<CampioniHtmlFields>();
	LinkedHashMap<String, String> risultato = new LinkedHashMap<String, String>();
	
	for (Map.Entry<String, ArrayList<CampioniHtmlFields>> entry : campi.entrySet()) {
	  nomeCampo = entry.getKey();
	  campiHash = entry.getValue();
	  nomeLabel =campiHash.get(0).getLabel_campo();
	  valoreCampione=  campiHash.get(0).getValore_campione();
	  if (valoreCampione == null)
		  valoreCampione ="";
	  
	  if (!(campiHash.get(0).getTipo_campo().equals("select") && campiHash.get(0).isMultiple())){ //SE NON E' UNA SELECT MULTIPLA
		  if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("select")){
			 
			  String valore=  campiHash.get(0).getValore_campione();
			  int valoreInt=-1;
			  try {
				  valoreInt = Integer.parseInt(campiHash.get(0).getValore_campione());
				  valore = String.valueOf(valoreInt);
			  }
			  catch(Exception e){
				  if (valore!=null && valore.contains("m"))
					  valore = valore.replaceAll("m", "");
			  }
				 LookupList l = new LookupList(db, campiHash.get(0).getTabella_lookup());
				 l.setJsEvent(campiHash.get(0).getJavascript_function());
				 html =  l.getHtmlSelect(campiHash.get(0).getNome_campo(), valore);
			}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("text")){
				String text = "<input type=\"text\" id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\" value=\""+valoreCampione+"\"/>";
				 html=  text;
				}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("hidden")){
				String text = "<input type=\"text\" readonly=\"readonly\" id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\" value=\""+valoreCampione+"\"/>";
				 html=  text;
				}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("data")){
				String text = "<input type=\"text\" readonly id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\" value=\""+valoreCampione+"\"/>";
				String data = "<a href=\"#\" onClick=\"cal19.select2(document.forms[0]."+campiHash.get(0).getNome_campo()+",\'anchor19\',\'dd/MM/yyyy\'); return false;\" NAME=\"anchor19\" ID=\"anchor19\"><img src=\"images/icons/stock_form-date-field-16.gif\" border=\"0\" align=\"absmiddle\"></a>";
				html= text+data;
				 
			}
	  }
	  else{
		  LookupList l = new LookupList(db, campiHash.get(0).getTabella_lookup());
		  l.setJsEvent(campiHash.get(0).getJavascript_function());
		  l.setMultiple(true);
		  l.setSelectSize(5);
		  LookupList multipleSelects=new LookupList();
		  for (int i=0; i<campiHash.size();i++){
			  LookupElement el = new LookupElement();
			  int code = -1;
			  String valore = campiHash.get(i).getValore_campione();
			  try {
				  code = Integer.parseInt(valore);
			  }
			  catch(Exception e){
				  if (valore!=null && valore.contains("m")){
					  valore = valore.replaceAll("m", "");
					  code = Integer.parseInt(valore);
				  }		  
			  }
			  
			  if (campiHash.get(i).getValore_campione().equals(""))
				  el.setCode("-1");
			  else
			  el.setCode(code);
			   el.setDescription(campiHash.get(i).getValore_campione());
			  multipleSelects.add(el); 
		  }
		//multipleSelects.addItem(nomeCampo, campiHash.get(i).getValore_campione());
		  l.setMultipleSelects(multipleSelects);
		  html =  l.getHtmlSelect(nomeCampo, multipleSelects); 
	  }
	  risultato.put(nomeLabel, html);
	}
		
	return risultato;
}

public void gestisciUpdate (ActionContext context, Connection db, int idCampione) {
	
	Ticket t = null;
	try {
		t = new Ticket (db, idCampione);
	
	//disabilita(db, idCampione);
//	Enumeration e = context.getRequest().getParameterNames();
//	String queryInsert = "";
//	 while(e.hasMoreElements()) { 
//		 String name=(String) e.nextElement(); 
//		 String[] campi = context.getRequest().getParameterValues(name);
//			if (campi != null){
//				for (int k = 0; k < campi.length; k++) {
//					queryInsert = queryInsert + "insert into campioni_fields_value (id_campione, id_campioni_html_fields, valore_campione) VALUES ("+idCampione+", "+ t.getMotivazione_piano_campione() + "," + "'"+campi[k]+"'" + ");";
//				}
//			}
//		 } 

	 
	 CampioniUtil.insertSchedaPNA(db, t, context);
	// insert(db, queryInsert);
	} catch (SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	}
}
