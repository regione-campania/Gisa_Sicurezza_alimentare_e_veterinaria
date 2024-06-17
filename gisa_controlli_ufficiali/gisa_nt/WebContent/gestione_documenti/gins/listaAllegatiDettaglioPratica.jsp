<%@page import="org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoGinsList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="../../utils23/initPage.jsp"%>
<%@page import="org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoGins"%>
<jsp:useBean id="listaAllegati" class="org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoGinsList" scope="request"/>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.opu.base.*, org.aspcfs.modules.base.*" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<script src="javascript/gestioneanagrafica/lista_allegati_pratica.js"></script> 
<script src="javascript/gestioneanagrafica/carica_nuovi_allegati.js"></script>
<script src="javascript/gestioneanagrafica/add.js"></script>

  <%! public static String fixData(String timestring)
  {
	  String toRet = "";
	  if (timestring == null || timestring.equals("null"))
		  return toRet;
	  String anno = timestring.substring(0,4);
	  String mese = timestring.substring(5,7);
	  String giorno = timestring.substring(8,10);
	  String ora = timestring.substring(11,13);
	  String minuto = timestring.substring(14,16);
	  String secondi = timestring.substring(17,19);
	  toRet =giorno+"/"+mese+"/"+anno+" "+ora+":"+minuto;
	  return toRet;
	  
  }%>
  <%! public static String fixStringa(String nome)
  {
	  String toRet = nome;
	  if (nome == null || nome.equals("null"))
		  return toRet;
	  toRet = nome.replaceAll("'", "");
	  toRet = toRet.replaceAll(" ", "_");
	  toRet = toRet.replaceAll("\\?","");
	
	  return toRet;
	  
  }%>

<script>

function recupera_descrizione_allegato(){
	
	var n_allegati = document.getElementById('size_allegati_pratica').value
	var codice_alleg = '';
	for (var i = 0; i < n_allegati; i++){
		codice_alleg = document.getElementById('desc_allegato_hid_'+ i).value
		for (var j = 0 in allegati){
			if(allegati[j].code == codice_alleg){
				document.getElementById("desc_allegato_"+i).innerHTML = allegati[j].desc;
			}
			
		}
	}
	
}

</script>
<body onload="recupera_descrizione_allegato()">
</body>
<center>
<% 
	DocumentaleAllegatoGinsList lista_allegati_pratica = new  DocumentaleAllegatoGinsList();
	for(int i=0;i<listaAllegati.size(); i++){
		if(!((DocumentaleAllegatoGins) listaAllegati.get(i)).getOggetto().contains("schedasup")){
			lista_allegati_pratica.add(listaAllegati.get(i));
		}
	}
%>
<input type="hidden" id="size_allegati_pratica" value="<%=lista_allegati_pratica.size() %>"/>

<br>
<input type="hidden" id="idComunePratica" value="${idComunePratica}"/>
<input type="hidden" id="stab_id" value="${stab_id}"/>
<input type="hidden" id="alt_id" value="${alt_id}"/>
<%if (lista_allegati_pratica.size()>0) { %>
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
		<tr>
			<th style="text-align:center;" colspan="5"><p>allegati</p></th>
		</tr>
		<tr>
			<th style="text-align:center; width:35%;"><p>Oggetto</p></th>
			<th style="text-align:center; width:40%;">file</th>
			<th style="text-align:center; width:5%;">Tipo</th>
			<th style="text-align:center; width:10%;">Data caricamento</th>
			<th style="text-align:center; width:10%;">Caricato/creato da</th>
		</tr>
		
		<% for (int i=0;i<lista_allegati_pratica.size(); i++){
			
			DocumentaleAllegatoGins doc = (DocumentaleAllegatoGins) lista_allegati_pratica.get(i); %>
			
			<tr class="row<%=i%2%>">
				<td align="center">
					<p>
						<strong><%= doc.getOggetto() %></strong> <br> 
						<label id="desc_allegato_<%=i%>" name="desc_allegato_<%=i%>" ></label>    
	       				<input type="hidden" id="desc_allegato_hid_<%=i%>" name="desc_allegato_hid_<%=i%>" value="<%=doc.getCodiceAllegato()%>"> 
			  		</p>
			  	</td> 
				<td align="center">
					<a href="GestioneAllegatiGins.do?command=DownloadPDF&codDocumento=<%=doc.getIdHeader()%>&idDocumento=<%=doc.getIdDocumento() %>&tipoDocumento=<%=doc.getTipoAllegato()%>&nomeDocumento=<%=fixStringa(doc.getNomeClient())%>">
					<% if (doc.getEstensione().equalsIgnoreCase("pdf")) {%>
					<img src="gestione_documenti/images/pdf_icon.png" width="20"/>
					<%} else if (doc.getEstensione().equalsIgnoreCase("csv")) { %>
					<img src="gestione_documenti/images/csv_icon.png" width="20"/>
					<%} else if (doc.getEstensione().equalsIgnoreCase("png") || doc.getEstensione().equals("gif") || doc.getEstensione().equals("jpg") || doc.getEstensione().equals("ico")) { %>
					<img src="gestione_documenti/images/img_icon.png" width="20"/>
					<%} else if (doc.getEstensione().equalsIgnoreCase("rar") || doc.getEstensione().equals("zip")) { %>
					<img src="gestione_documenti/images/rar_icon.png" width="20"/>
					<%} else if (doc.getEstensione().contains("xls")) { %>
					<img src="gestione_documenti/images/xls_icon.png" width="20"/>
					<%} else if (doc.getEstensione().contains("doc")) { %>
					<img src="gestione_documenti/images/doc_icon.png" width="20"/>
					<%} else if (doc.getEstensione().contains("p7m")) { %>
					<img src="gestione_documenti/images/p7m_icon.png" width="20"/>
					<%} else { %>
					<img src="gestione_documenti/images/file_icon.png" width="20"/>
					<%} %> 
					<%=fixStringa(doc.getNomeClient())%>
					</a>
				</td> 
				<td align="center"><%=(doc.getEstensione()!=null && !doc.getEstensione().equals("null")) ? doc.getEstensione() : "&nbsp;"%></td>
				<td align="center"><%= fixData(doc.getDataCreazione()) %></td> 
				<td align="center"> <dhv:username id="<%= doc.getUserId() %>" /></td> 
			</tr>
	
		<% } %>			
	</table>
<% } %>
<br><br>
<% 
	DocumentaleAllegatoGinsList lista_schede_supplementari = new  DocumentaleAllegatoGinsList();
	for(int i=0;i<listaAllegati.size(); i++){
		if(((DocumentaleAllegatoGins) listaAllegati.get(i)).getOggetto().contains("schedasup")){
			lista_schede_supplementari.add(listaAllegati.get(i));
		}
	}
%>
<%if (lista_schede_supplementari.size()>0) { %>
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
		<tr>
			<th style="text-align:center;" colspan="5"><p>schede supplementari</p></th>
		</tr>
		<tr>
			<th style="text-align:center; width:35%;"><p>Oggetto</p></th>
			<th style="text-align:center; width:40%;">file</th>
			<th style="text-align:center; width:5%;">Tipo</th>
			<th style="text-align:center; width:10%;">Data caricamento</th>
			<th style="text-align:center; width:10%;">Caricato/creato da</th>
		</tr>
	
		<% for (int i=0;i<lista_schede_supplementari.size(); i++){
			
			DocumentaleAllegatoGins doc_schede_sup = (DocumentaleAllegatoGins) lista_schede_supplementari.get(i); %>
			
			<tr class="row<%=i%2%>">
				<td align="center">
					<p>
						<strong>SCHEDA SUPPLEMENTARE</strong> <br> 
			  		</p>
			  	</td> 
				<td align="center">
					<a href="GestioneAllegatiGins.do?command=DownloadPDF&codDocumento=<%=doc_schede_sup.getIdHeader()%>&idDocumento=<%=doc_schede_sup.getIdDocumento() %>&tipoDocumento=<%=doc_schede_sup.getTipoAllegato()%>&nomeDocumento=<%=fixStringa(doc_schede_sup.getNomeClient())%>">
					<% if (doc_schede_sup.getEstensione().equalsIgnoreCase("pdf")) {%>
					<img src="gestione_documenti/images/pdf_icon.png" width="20"/>
					<%} else if (doc_schede_sup.getEstensione().equalsIgnoreCase("csv")) { %>
					<img src="gestione_documenti/images/csv_icon.png" width="20"/>
					<%} else if (doc_schede_sup.getEstensione().equalsIgnoreCase("png") || doc_schede_sup.getEstensione().equals("gif") || doc_schede_sup.getEstensione().equals("jpg") || doc_schede_sup.getEstensione().equals("ico")) { %>
					<img src="gestione_documenti/images/img_icon.png" width="20"/>
					<%} else if (doc_schede_sup.getEstensione().equalsIgnoreCase("rar") || doc_schede_sup.getEstensione().equals("zip")) { %>
					<img src="gestione_documenti/images/rar_icon.png" width="20"/>
					<%} else if (doc_schede_sup.getEstensione().contains("xls")) { %>
					<img src="gestione_documenti/images/xls_icon.png" width="20"/>
					<%} else if (doc_schede_sup.getEstensione().contains("doc")) { %>
					<img src="gestione_documenti/images/doc_icon.png" width="20"/>
					<%} else if (doc_schede_sup.getEstensione().contains("p7m")) { %>
					<img src="gestione_documenti/images/p7m_icon.png" width="20"/>
					<%} else { %>
					<img src="gestione_documenti/images/file_icon.png" width="20"/>
					<%} %> 
					<%=fixStringa(doc_schede_sup.getNomeClient())%>
					</a>
				</td> 
				<td align="center"><%=(doc_schede_sup.getEstensione()!=null && !doc_schede_sup.getEstensione().equals("null")) ? doc_schede_sup.getEstensione() : "&nbsp;"%></td>
				<td align="center"><%= fixData(doc_schede_sup.getDataCreazione()) %></td> 
				<td align="center"> <dhv:username id="<%= doc_schede_sup.getUserId() %>" /></td> 
			</tr>
	
	<%} %>	
			
	</table>
<% } %>
<br><br>
</center>