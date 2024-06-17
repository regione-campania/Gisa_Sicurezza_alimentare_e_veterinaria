package org.aspcf.modules.controlliufficiali.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import org.aspcfs.utils.web.LookupElement;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;

public class CuHtmlFields {

private int id;
private String codice_interno;
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

private String valore="";
private String html;

public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getCodice_interno() {
	return codice_interno;
}
public void setCodice_interno(String codice_interno) {
	this.codice_interno = codice_interno;
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


public void buildRecord(Connection db, ResultSet rs) throws SQLException{
	this.id = rs.getInt("id");
	  this.codice_interno=rs.getString("codice_interno");
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
	  setValore(rs.getString("valore"));
	 // this.setHtml(generaHtml(db));
	  
	
}
public String getValore() {
	return valore;
}
public void setValore(String valore) {
	if (valore!=null)
		this.valore = valore;
}

//private String generaHtml(Connection db) throws SQLException{
//	if (tipo_campo.equalsIgnoreCase("select")){
//		 LookupList l = new LookupList(db, tabella_lookup);
//		 l.setJsEvent(javascript_function);
//		 if (multiple){
//			 l.setMultiple(true);
//			 l.setSelectSize(5);
//			 return  l.getHtmlSelect(nome_campo, -2);
//		 }
//		 else{
//			 return  l.getHtmlSelect(nome_campo, valore);
//		 }
//			 
//	}
//	if (tipo_campo.equalsIgnoreCase("text")){
//		String text = "<input type=\"text\" id=\""+nome_campo+"\" name=\""+nome_campo+"\" value=\""+valore_campo+"\"/>";
//		 return  text;
//		}
//	if (tipo_campo.equalsIgnoreCase("hidden")){
//		String text = "<input type=\"hidden\" id=\""+nome_campo+"\" name=\""+nome_campo+"\" value=\""+valore_campo+"\"/>";
//		 return  text;
//		}
//	if (tipo_campo.equalsIgnoreCase("data")){
//		String text = "<input type=\"text\" readonly id=\""+nome_campo+"\" name=\""+nome_campo+"\" value=\""+valore_campo+"\"/>";
//		String data = "<a href=\"#\" onClick=\"cal19.select2(document.forms[0]."+nome_campo+",\'anchor19\',\'dd/MM/yyyy\'); return false;\" NAME=\"anchor19\" ID=\"anchor19\"><img src=\"images/icons/stock_form-date-field-16.gif\" border=\"0\" align=\"absmiddle\"></a>";
//		return text+data;
//		 
//	}
//		
//	
//	return "";
//}
public String getHtml() {
	return html;
}
public void setHtml(String html) {
	this.html = html;
}
	
public static ArrayList<String> getPianiEstesi(Connection db){
	ArrayList<String> pianiEstesi = new ArrayList<String>();
	
	return pianiEstesi;
}

public LinkedHashMap<String, String> costruisciHtmlDaHashMap(Connection db, LinkedHashMap<String, ArrayList<CuHtmlFields>> campi) throws SQLException{

	String nomeCampo="";
	String html = "";
	String nomeLabel ="";
	ArrayList<CuHtmlFields> campiHash = new ArrayList<CuHtmlFields>();
	LinkedHashMap<String, String> risultato = new LinkedHashMap<String, String>();
	
	for (Map.Entry<String, ArrayList<CuHtmlFields>> entry : campi.entrySet()) {
	  nomeCampo = entry.getKey();
	  campiHash = entry.getValue();
	  nomeLabel =campiHash.get(0).getLabel_campo();
	  
	  if (!(campiHash.get(0).getTipo_campo().equals("select") && campiHash.get(0).isMultiple())){ //SE NON E' UNA SELECT MULTIPLA
		  if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("select")){
				 LookupList l = new LookupList(db, campiHash.get(0).getTabella_lookup());
				 l.setJsEvent(campiHash.get(0).getJavascript_function());
				 html =  l.getHtmlSelect(campiHash.get(0).getNome_campo(), campiHash.get(0).getValore());
			}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("text")){
				String text = "<input type=\"text\" id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\" value=\""+campiHash.get(0).getValore()+"\"/>";
				 html=  text;
				}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("hidden")){
				String text = "<input type=\"hidden\" id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\" value=\""+campiHash.get(0).getValore()+"\"/>";
				 html=  text;
				}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("data")){
				String text = "<input type=\"text\" readonly id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\" value=\""+campiHash.get(0).getValore()+"\"/>";
				String data = "<a href=\"#\" onClick=\"cal19.select2(document.forms[0]."+campiHash.get(0).getNome_campo()+",\'anchor19\',\'dd/MM/yyyy\'); return false;\" NAME=\"anchor19\" ID=\"anchor19\"><img src=\"images/icons/stock_form-date-field-16.gif\" border=\"0\" align=\"absmiddle\"></a>";
				html= text+data;
			}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("checkbox")){
			  	String checked ="";
			  	if (campiHash.get(0).getValore()!=null && campiHash.get(0).getValore().equals("on"))
			  		checked="checked=\"checked\"";
				String cb = "<input type=\"checkbox\" id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\" "+checked+"\"/>";
				html= cb;
			}
		  else
			  html ="";
	  }
	  else{
		  LookupList l = new LookupList(db, campiHash.get(0).getTabella_lookup());
		  l.setJsEvent(campiHash.get(0).getJavascript_function());
		  l.setMultiple(true);
		  l.setSelectSize(5);
		  LookupList multipleSelects=new LookupList();
		  for (int i=0; i<campiHash.size();i++){
			  LookupElement el = new LookupElement();
			  el.setCode(campiHash.get(i).getValore());
			   el.setDescription(campiHash.get(i).getValore());
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

public LinkedHashMap<String, String> costruisciHtmlDettaglioDaHashMap(Connection db, LinkedHashMap<String, ArrayList<CuHtmlFields>> campi) throws SQLException{

	String nomeCampo="";
	String html = "";
	String nomeLabel ="";
	ArrayList<CuHtmlFields> campiHash = new ArrayList<CuHtmlFields>();
	LinkedHashMap<String, String> risultato = new LinkedHashMap<String, String>();
	
	for (Map.Entry<String, ArrayList<CuHtmlFields>> entry : campi.entrySet()) {
	  nomeCampo = entry.getKey();
	  campiHash = entry.getValue();
	  nomeLabel =campiHash.get(0).getLabel_campo();
	 
	  
	  if (!(campiHash.get(0).getTipo_campo().equals("select") && campiHash.get(0).isMultiple())){ //SE NON E' UNA SELECT MULTIPLA
		  if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("select")){
			  String tabella =  (String)campiHash.get(0).getTabella_lookup();
			  LookupList tab = new LookupList(db, tabella);
			  String val = campiHash.get(0).getValore();
			  html =  "<label>"+tab.getElementfromValue(Integer.parseInt(val)).getDescription()+"</label>";
			}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("text")){
				String text = "<label id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\">"+campiHash.get(0).getValore()+"</label>";
				 html=  text;
				}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("data")){
				String text = "<label id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\">"+campiHash.get(0).getValore()+"</label>";
				html= text;
			}
		  else if (campiHash.get(0).getTipo_campo().equalsIgnoreCase("checkbox")){
			  	String checked ="";
			  	if (campiHash.get(0).getValore()!=null && campiHash.get(0).getValore().equals("on"))
			  		checked="checked=\"checked\"";
				String cb = "<input type=\"checkbox\" disabled id=\""+campiHash.get(0).getNome_campo()+"\" name=\""+campiHash.get(0).getNome_campo()+"\" "+checked+"\"/>";
				html= cb;
			}
		  else
			  html ="";
		  
		  if (campiHash.get(0).getValore().equals(""))
			  html = "";
	  }
	  else{
		 String valori ="";
		  for (int i=0; i<campiHash.size();i++){
			  valori=valori+campiHash.get(i).getValore()+";";
			   
		  }
		//multipleSelects.addItem(nomeCampo, campiHash.get(i).getValore_campione());
		 
		  html =  "<label>"+valori+"</label>";
	  }
	  
	  if (!html.equals(""))
		  risultato.put(nomeLabel, html);
	}
		
	return risultato;
}

public void gestisciUpdate (ActionContext context, Connection db, int idControllo) {

 //CheckListAllevamenti.insertListaRiscontro(db, idControllo, specie, context);

	}

public static ArrayList<String> getCodiciEstesi(Connection db){
	ArrayList<String> pianiEstesi = new ArrayList<String>();
	String sql = "SELECT distinct codice_interno from cu_html_fields where codice_interno is not null";
	PreparedStatement ps;
	try {
		ps = db.prepareStatement(sql);
	
	ResultSet rs = ps.executeQuery();
	while (rs.next())
		pianiEstesi.add(rs.getString("codice_interno"));
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return pianiEstesi;
}
}
