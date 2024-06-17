<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<jsp:useBean id="anno" class="java.lang.String" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>
<script> function checkForm(form){
	loadModalWindow();
	return true;
	}
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>


<body>

<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="RegistroTrasgressori.do?command=RegistroSanzioni">Registro Trasgressori</a> > 
Ricerca
</td>
</tr>
</table>
<%-- End Trails --%>


<dhv:container name="registrotrasgressori" selected="details"  object="" >

<form name="registroSanzioni"
	action="RegistroTrasgressori.do?command=Ricerca&auto-populate=true" onSubmit=""
	method="post"><input type="hidden" name="doContinue"
	id="doContinue" value="" />

<table>
<col width="50%">
<tr><th colspan="2"><b>Ricerca in Registro sanzioni</b></th></tr>
<tr><td align="right">Anno </td>
<td><select id="anno" name="anno">
<%int year = Integer.parseInt(anno);
for (int i=0; i<10; i++){ if ((year-i)>=2015) { %>
<option value="<%=year-i%>"><%=year-i %></option>
<% } }%>
</select> 
</td></tr>
<tr><td align="right">Trasgressore </td> <td><input type="text" id="trasgressore" name="trasgressore" value=""/></td></tr>
<tr><td align="right">Obbligato in solido</td><td> <input type="text" id="obbligato" name="obbligato" value=""/></td></tr>
<tr><td align="right">Ente accertatore </td><td><input type="text" id="ente" name="ente" value=""/></td></tr>
<tr><td align="right">PV N�</td><td> <input type="text" id="pv" name="pv" value=""/></td></tr>
<tr><td colspan="2" align="center"><input type="button" value="RICERCA" onclick="if (checkForm(this.form)){this.form.submit()}"/></td></tr>



</table>

</form>


</dhv:container>
</body>
</html>