
<%@page import="org.aspcfs.modules.macellazioninewsintesis.utils.ConfigTipo"%>
<%
ConfigTipo configTipo = (ConfigTipo) request.getSession().getAttribute("configTipo");
String fileToInclude = "istopatologico_visualizza_esito" + configTipo.getIdTipo() + ".jsp";
%>


<jsp:include page="<%=fileToInclude%>"/>