<%@page import="it.us.web.action.GenericAction"%>
<%@page import="it.us.web.action.Index"%>

<%
	session.setAttribute("system","sinantropi");
    session.setAttribute("entrypointSinantropi",request.getParameter("entrypointSinantropi"));
    //Per fare in modo che andando alla home page si venga sloggati dal sistema � stata messa la seguente istruzione : GenericAction.redirectTo("login.Logout.us", request, response);
    //Questa per� non va bene perch� ti caccia dal sistema non appena si fa 'accesso bdr -> sinantropi'
    //Se si rimette l'istruzione come prima l'obiettivo descritto all'inizio viene comunque raggiunto perch� viene sempre chiamata indexV.jsp
    GenericAction.redirectTo("Index.us", request, response);
	//GenericAction.forwardToAction( new Index("sinantropi"), request, request );
%>
