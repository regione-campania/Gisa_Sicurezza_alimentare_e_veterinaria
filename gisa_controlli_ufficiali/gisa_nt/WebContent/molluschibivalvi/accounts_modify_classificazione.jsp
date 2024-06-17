
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.molluschibivalvi.base.*"%>

<%@page import="java.util.Date"%><jsp:useBean id="OrgDetails" class="org.aspcfs.modules.molluschibivalvi.base.Organization" scope="request" />
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="ZoneProduzione" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Classificazione" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application" />
<jsp:useBean id="systemStatus" class="org.aspcfs.controller.SystemStatus" scope="request" />
<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script>

function checkForm()
{
	formtest = true ;
	msg ='Controllare di aver selezionato i seguenti campi : \n';
	if(document.addAccount.classe.value =='-1')
	{
		formtest = false ;
		msg += 'Il campo classificazione deve essere popolato\n'
	}
	/*if(document.addAccount.numClassificazione.value =='')
	{
		formtest = false ;
		msg += 'Il campo num. descreto deve essere popolato\n'
	}*/
	if(document.addAccount.dataClassificazione.value =='' )
	{
		formtest = false ;
		msg += 'Il campo data classificazione deve essere popolato\n'
	}
	if(document.addAccount.tipoMolluschi.value =='-1' )
	{
		formtest = false ;
		msg += 'Il campo Tipologia Zona deve essere popolato\n'
	}
	
	var select = document.getElementById('molluschi');
	for (i = 0 ; i < select.length ; i ++)
	{
		if(select.options[i].value ==  '-1' &&  select.options[i].selected==true)
		{
			formtest = false ;
			msg += 'Il campo Mollusci non deve contenere seleziona voce\n' ;
			break ;
		}
	}
	
	if(formtest==true){
		loadModalWindow();
		document.addAccount.submit();
	}
	else
	{
		alert(msg);
		return false ;
	}
	
}

function showCampi()
{
value = document.getElementById('tipoMolluschi').value;
if(value == '1') // specchio acquo
{
	document.getElementById('classeId').style.display= "";
	document.getElementById('abusivi').style.display= "none";
}
else
{
	
	if(value == '4') // specchio acquo
	{
		document.getElementById('abusivi').style.display= "";
		document.getElementById('classeId').style.display= "none";
		
	}
	else
	{
		document.getElementById('abusivi').style.display= "none";
		document.getElementById('classeId').style.display= "none";
	}
	
}
}
var campoLat;
var campoLong;
	function showCoordinate(address,city,prov,cap,campo_lat,campo_long)
	{
   campoLat = campo_lat;
   campoLong = campo_long;
   Geocodifica.getCoordinate(address,city,prov,cap,'','','',setGeocodedLatLonCoordinate);
   }
function setGeocodedLatLonCoordinate(value)
{
	campoLat.value = value[1];;
	campoLong.value =value[0];
	
}
function openTreeMatrici()
{

	window.open('Tree.do?command=DettaglioTree&nomeTabella=matrici&nodo=289&campoId=matrice_id&campoPadre=id_padre&campoDesc=nome&campoLivello=livello&campoEnabled=nuova_gestione&sel=true');

}
</script>

<%
if(request.getAttribute("updateOk")!=null)
{
%>
<script>
opener.location.reload();
window.close();

</script>

<%	

}
%>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
<%@ include file="../utils23/initPage.jsp"%>

<form id="addAccount" name="addAccount"
	action="MolluschiBivalvi.do?command=UpdateClassificazione&auto-populate=true&id=<%=OrgDetails.getId() %>"
	method="post">

<table class="trails" cellspacing="0">
	<tr>
		<td width="100%"><a href="MolluschiBivalvi.do">Molluschi
		Bivalvi</a> > Classificazione Scheda <%=OrgDetails.getName() %></td>
	</tr>
</table>

<input type="button"
	value="Aggiorna"
	name="button" onClick="checkForm()"> <input type="button"
	value="Annulla"
	onClick="window.close();">





<%
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>	
 <br>
<table cellpadding="4" cellspacing="0" border="0" width="100%"class="details" id = "zc">
	<tr>
		<th colspan="2"><strong><dhv:label name=""><%=(OrgDetails.getTipoMolluschi()==5) ? "Dettagli Classificazione" : "Dettagli Riclassificazione"  %></dhv:label></strong></th></tr>
	

	<tr id = "classeId">
		<td nowrap class="formLabel" name="orgname1" id="orgname1">Classe</td>
		<td><%=Classificazione.getHtmlSelect("classe",OrgDetails.getClasse()) %><font color="red">*</font></td>
	</tr>
	<tr id = "zc1">
		<td nowrap class="formLabel" >Numero Decreto</td>
		<td><input type = "text" name = "numClassificazione" value = "" required="required">
		Attenzione in caso di riclassificazione temporanea non compilare il numero di decreto
		</td>
	</tr>
	
	<tr id = "zc2">
		<td nowrap class="formLabel" > Data Decreto</td>
		<td>
		<%String dataClassificazione = "" ;%>
		<%if(OrgDetails.getDataClassificazione()!=null){
			dataClassificazione = sdf.format(new Date(OrgDetails.getDataClassificazione().getTime())) ;
		}
		%>
			<input readonly type="text" id="dataClassificazione" name="dataClassificazione" value = "<%=dataClassificazione %>" size="10" />
		<a href="#" onClick="cal19.select(document.forms[0].dataClassificazione,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
       <font color="red">*</font>
       </td>
	</tr>
	
	
	<tr >
		<td nowrap class="formLabel" > Tipologia Zona</td>
		<td>
		
		<%=ZoneProduzione.getHtmlSelect("tipoMolluschi",-1) %>
	
       <font color="red">*</font>
       </td>
	</tr>
	
	
	  <tr>
      <td name="tipoCampione1" id="tipoCampione1" nowrap class="formLabel">
        <dhv:label name="">Specie Molluschi</dhv:label>
      </td>
      <td>
  		<%HashMap<Integer,String> molluschi = (HashMap<Integer,String>)request.getAttribute("Molluschi");
  		HashMap<Integer,String> molluschiPresenti =  OrgDetails.getTipoMolluschiInZone();
  		
  		%>
  		<select name = "molluschi" id = "molluschi" multiple="multiple">
  		<%
  		
  		Iterator<Integer> it = molluschi.keySet().iterator();
  		while (it.hasNext())
  		{
  			int idMoll = it.next();
  			String path = molluschi.get(idMoll);
  			%>
  			<option value = "<%=idMoll %>" <%if(idMoll > 0 && molluschiPresenti.containsKey(idMoll)){%>selected="selected" <%} %>><%=path %></option>
  			<%
  		}
  		%>
  		
  		</select>
    	</td>
     	</tr>
	
	
</table>



<br>
<input type="button"
	value="Aggiorna"
	name="Save" onClick="checkForm()">
	
	 <input type="button"
	value="Annulla"
	onClick="window.close();">


</form>

