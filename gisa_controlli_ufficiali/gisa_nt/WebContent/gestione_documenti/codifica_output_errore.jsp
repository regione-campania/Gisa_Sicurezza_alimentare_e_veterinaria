<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <jsp:useBean id="error" class="java.lang.String" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Generazione documento</title>

</head>

<body>
<b><p><span style="color: #ff0000;">ERRORE NELLA GENERAZIONE DEL FILE</span> </p></b>
<dhv:evaluate if="<%=(error!=null) %>"> 
<label><%=error %></label>
</dhv:evaluate>

</body>
</html>