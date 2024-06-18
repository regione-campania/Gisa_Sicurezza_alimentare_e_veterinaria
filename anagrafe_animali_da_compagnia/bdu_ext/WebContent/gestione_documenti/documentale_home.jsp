<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form id="form1" action="GestioneDocumenti.do?command=DownloadPDF" method="post" name="form1">
<p style="text-align: center;"><span style="font-size: medium; font-family: trebuchet ms,geneva;">Inserire identificativo del documento (XXX-XXXXX)
<input type="text" maxlength="9" size="9" name="codDocumento" id="codDocumento" value=""></input>
<input type="button" onClick="if(form1.codDocumento.value.length!=9){alert('Inserire identificativo nel formato corretto')}else{form1.submit()};" value="INVIA"></input>
</form>
</body>
</html>