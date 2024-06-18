<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html40/strict.dtd">
<%@page import="org.aspcfs.modules.schedaMorsicatura.base.Indice"%>
<%@page import="org.aspcfs.modules.schedaMorsicatura.base.Criterio"%>
<%@page import="org.aspcfs.modules.schedaMorsicatura.base.SchedaMorsicaturaRecords"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*,org.aspcfs.modules.anagrafe_animali.base.*,java.io.IOException,org.aspcfs.modules.opu.base.*,java.util.Date,com.sun.org.apache.xerces.internal.impl.dv.util.Base64,java.io.ByteArrayOutputStream,javax.imageio.ImageIO,org.aspcfs.modules.registrazioniAnimali.base.EventoMorsicatura"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<%@ include file="../../initPage.jsp"%>
<jsp:useBean id="dati_morsicatura" class="org.aspcfs.modules.registrazioniAnimali.base.EventoMorsicatura" scope="request" />	

<link type="text/css" href="anagrafe_animali/documenti/screen.css" rel="stylesheet" />
	
<link rel="stylesheet" documentale_url="" href="anagrafe_animali/documenti/print.css" type="text/css" media="print" />

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="aslList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="thisAnimale" class="org.aspcfs.modules.anagrafe_animali.base.Animale" scope="request" />

<!-- LOOKUPS DECODIFICA -->
<jsp:useBean id="razzaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tagliaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="mantelloList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="proprietario" class="org.aspcfs.modules.opu.base.Operatore" scope="request" />
<jsp:useBean id="detentore" class="org.aspcfs.modules.opu.base.Operatore" scope="request" />
<jsp:useBean id="tipologieMorso" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipologieMorsoRipetuto" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipologieRilievi" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipologieAnalisiGestione" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="prevedibilitaEvento" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="taglieAggressore" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="categorieVittima" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="taglieVittima" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="scheda" class="org.aspcfs.modules.schedaMorsicatura.base.SchedaMorsicatura" scope="request" />


<%
LineaProduttiva linea_proprietario=null;
LineaProduttiva linea_detentore=null;%>

<% 
   Stabilimento temp = null;
   Indirizzo sedeOperativa = null;
   if (proprietario!=null)
	if (proprietario.getListaStabilimenti()!=null)
		if (!proprietario.getListaStabilimenti().isEmpty())
		{
			temp = (Stabilimento) proprietario.getListaStabilimenti().get(0); 
			sedeOperativa = temp.getSedeOperativa();
			linea_proprietario= (LineaProduttiva) temp.getListaLineeProduttive().get(0);	
		}
   Stabilimento temp2 = null;
   Indirizzo sedeOperativa2 = null;
   if (detentore!=null)
	if (detentore.getListaStabilimenti()!=null)
		if (!detentore.getListaStabilimenti().isEmpty())
		{
			temp2 = (Stabilimento) detentore.getListaStabilimenti().get(0); 
			sedeOperativa2 = temp2.getSedeOperativa();
			linea_detentore= (LineaProduttiva) temp2.getListaLineeProduttive().get(0);		
		}
			
//CATTURO INFO MICROCHIP PER SOSTITUIRLO COL TATUAGGIO NEL CASO SIA ASSENTE
String value_microchip="";
if (thisAnimale.getMicrochip()!=null && !thisAnimale.getMicrochip().equals(""))
	value_microchip = thisAnimale.getMicrochip();
else if (thisAnimale.getTatuaggio()!=null && !thisAnimale.getTatuaggio().equals(""))
	value_microchip=thisAnimale.getTatuaggio();
%>

<%-- <body onload="javascript:closeAndRefresh('<%= request.getAttribute("chiudi")%>','<%= request.getAttribute("redirect")%>')">--%>
<body>
<input type="submit" name="stampa" class="buttonClass" onclick="window.print();" value="Stampa" />
	
	  <jsp:include page="../../gestione_documenti/boxDocumentale.jsp">
      <jsp:param name="idAnimale" value="<%=thisAnimale.getIdAnimale() %>" />
      <jsp:param name="idSpecie" value="<%=thisAnimale.getIdSpecie() %>" />
      <jsp:param name="idTipo" value="PrintDocumentoMorsicatura" />
      <jsp:param name="idMicrochip" value="<%=value_microchip %>" />
</jsp:include>
	
<div class="imgRegione">
	<img style="text-decoration: none;" width="80" height="80" documentale_url="" src="anagrafe_animali/documenti/images/regionecampania.jpg" />
</div>
<div class="boxIdDocumento"></div>
<div class="boxOrigineDocumento"><%@ include file="../../hostName.jsp" %></div>

<dhv:evaluate if="<%=(thisAnimale.getIdAslRiferimento()>0) %>"> 
<div class="imgAsl">
<img style="text-decoration: none;" width="80" height="80" documentale_url="" src="anagrafe_animali/documenti/images/<%=aslList.getSelectedValue(thisAnimale.getIdAslRiferimento()) %>.jpg" />
</div>
</dhv:evaluate>

<div class="title1">DOCUMENTO MORSICATURA ANAGRAFE CANINA REGIONALE</div>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<div class="nodott_margin_low"><b><u>Dati del proprietario</u></b></div>
<div class="clear1"></div>

<div class="nodott_margin_low">Cognome e nome: </div>
<div class="dott_long_margin_low">&nbsp;<%=(proprietario.getRagioneSociale() != null) ? proprietario.getRagioneSociale() : ""%></div>
<div class="clear1"></div>
<div class="nodott_margin_low">Codice Fiscale:</div>
<div class="dott_margin_low">&nbsp; <%=(proprietario.getCodFiscale() != null && !("").equals(proprietario.getCodFiscale()))? proprietario.getCodFiscale() : "" %></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Comune di residenza:</div>
<div class="dott_long_margin_low" >&nbsp;  <%=(sedeOperativa != null) ? comuniList.getSelectedValue((sedeOperativa.getComune())) : ""%></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Indirizzo:</div>
<div class="dott_long_margin_low" >&nbsp; <%=(sedeOperativa != null) ? sedeOperativa.getVia() : ""%></div>
<div class="clear1"></div>

<div class="nodott_margin_low" ><u><b>Dati del detentore</u></b></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Cognome e nome: </div>
<div class="dott_long_margin_low" >&nbsp; <%=(detentore.getRagioneSociale() != null) ? detentore.getRagioneSociale() : ""%></div>
<div class="clear1"></div>
<div class="nodott_margin_low">Codice Fiscale:</div>
<div class="dott_margin_low" >&nbsp; <%=(detentore.getCodFiscale() != null && !("").equals(proprietario.getCodFiscale()))? detentore.getCodFiscale() : "" %></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Comune di residenza:</div>
<div class="dott_long_margin_low" >&nbsp;  <%=(sedeOperativa2 != null) ? comuniList.getSelectedValue((sedeOperativa2.getComune())) : ""%></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Indirizzo:</div>
<div class="dott_long_margin_low" >&nbsp; <%=(sedeOperativa2 != null) ? sedeOperativa2.getVia() : ""%></div>
<div class="clear1"></div>

<div class="nodott_margin_low" ><b><u>Dati del <%=thisAnimale.getNomeSpecieAnimale() %></u></b></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Microchip: </div>
<div class="dott_margin_low" >&nbsp; <%=(thisAnimale.getMicrochip() != null) ? thisAnimale.getMicrochip() : ""%> </div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Razza:</div>
<div class="dott_margin_low" >&nbsp; <%=razzaList.getSelectedValue(thisAnimale.getIdRazza()) %></div>
<div class="clear1"></div>
<% if(ApplicationProperties.getProperty("flusso_336_req1").equals("true"))
				{%>
<dhv:evaluate if="<%=(thisAnimale.getIdSpecie() != Furetto.idSpecie) %>"> <!--  SOLO PER CANI E GATTI -->
<div class="nodott_margin_low" >Incrocio:</div>
<div class="dott_margin_low" >&nbsp; <%if (thisAnimale.isFlagIncrocio() == null){ %>
					--
					<%}else if(thisAnimale.isFlagIncrocio()){ %>
					SI
					<%}else{ %>
					NO
					<%} %></div>
</dhv:evaluate>
<div class="clear1"></div>
<%} %>
<div class="nodott_margin_low" >Nome:</div>
<div class="dott_margin_low" >&nbsp; <%=thisAnimale.getNome() %></div>

<%
	if (thisAnimale.getIdSpecie() ==1) 
	{ 
%>
		<div class="nodott_margin_low" >Taglia:</div>
		<div class="dott_margin_low" >&nbsp; <%=tagliaList.getSelectedValue((thisAnimale).getIdTaglia())%> </div>
<%
	} 
%>

<div class="nodott_margin_low" >Sesso:</div>
<div class="dott_short_margin_low" >&nbsp; <%=(thisAnimale.getSesso() != null) ? thisAnimale.getSesso() : "-" %></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Mantello:</div>
<div class="dott_margin_low" >&nbsp; <%=mantelloList.getSelectedValue(thisAnimale.getIdTipoMantello()) %></div>
<div class="clear1"></div>

<div class="nodott_margin_low" ><b><u>Dati della registrazione di morsicatura</u></b></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Data morso:</div>
<div class="dott_margin_low" >&nbsp;<%=(dati_morsicatura.getDataMorso() != null) ? toDateasString(dati_morsicatura.getDataMorso()) : "-" %></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Luogo morso:</div>
<div class="dott_margin_low" >&nbsp;<%= comuniList.getSelectedValue(dati_morsicatura.getIdComuneMorsicatura()) %></div>
<div class="clear1"></div>

<div class="nodott_margin_low" >Tipologia</div>
<div class="dott_margin_low" >&nbsp;<%=tipologieMorso.getSelectedValue(dati_morsicatura.getTipologia())%></div>
	
<%
	if(dati_morsicatura.getTipologia()==1)
	{
%>
	<div class="nodott_margin_low" >Prevedibilit� evento</div>
	<div class="dott_margin_low" >&nbsp;<%=prevedibilitaEvento.getSelectedValue(dati_morsicatura.getPrevedibilitaEvento())%></div>
	
<%
	}
%>

	<div class="clear1"></div>
<% 


	if(dati_morsicatura.getTipologia()==2)
	{

		ArrayList<SchedaMorsicaturaRecords> records = scheda.getRecords();		
		int i=0;
		
		while(i<records.size())
		{
			SchedaMorsicaturaRecords record = (SchedaMorsicaturaRecords)records.get(i);
			Criterio criterio = record.getIndice().getCriterio();
			Indice indice = record.getIndice();
			SchedaMorsicaturaRecords recordSuccesivo = null;
%>
				<div class="nodott_margin_low" ><%=criterio.getNome().toUpperCase()%></div>
			    <div class="dott_margin_low" >&nbsp;<%=indice.getNome().toUpperCase() + ((indice.isValoreManuale())?(": " + record.getValoreManuale()):(""))%>

<%
				if(criterio.getFormulaCalcoloPunteggio().equals("divisione_indice"))
				{
						i++;
						recordSuccesivo = (SchedaMorsicaturaRecords)records.get(i);
						Criterio criterioSuccessivo = recordSuccesivo.getIndice().getCriterio();
						while(record.getIndice().getCriterio().getId()==criterioSuccessivo.getId())
						{
							recordSuccesivo = (SchedaMorsicaturaRecords)records.get(i);
							criterioSuccessivo = recordSuccesivo.getIndice().getCriterio();
							Indice indiceSuccessivo = recordSuccesivo.getIndice();
							if(record.getIndice().getCriterio().getId()==criterioSuccessivo.getId())
							{
								out.println("<br/>" + indiceSuccessivo.getNome().toUpperCase() + ": " + recordSuccesivo.getValoreManuale());
								i++;
							}
							else
							{
								i--;
								recordSuccesivo = (SchedaMorsicaturaRecords)records.get(i);
								criterioSuccessivo = recordSuccesivo.getIndice().getCriterio();
								break;
							}
						}
						
				}
%>
				</div>
<%
			i++;

%>				
				<div class="clear1"></div>	
<% 			
		}	
	}
%>
	<div class="nodott_margin_low" >Morso ripetuto</div>
	<div class="dott_margin_low" >&nbsp;<%=tipologieMorsoRipetuto.getSelectedValue(dati_morsicatura.getMorsoRipetuto())%></div>
	<div class="clear1"></div>	
<%
	if(dati_morsicatura.getTipologia()==1)
	{
%>
	<div class="nodott_margin_low" >Taglia aggressore</div>
	<div class="dott_margin_low" >&nbsp;<%=taglieAggressore.getSelectedValue(dati_morsicatura.getTagliaAggressore())%></div>
	
	<div class="nodott_margin_low" >Categoria vittima</div>
	<div class="dott_margin_low" >&nbsp;<%=categorieVittima.getSelectedValue(dati_morsicatura.getCategoriaVittima())%></div>
	<div class="clear1"></div>
	
	<div class="nodott_margin_low" >Taglia vittima</div>
	<div class="dott_margin_low" >&nbsp;<%=taglieVittima.getSelectedValue(dati_morsicatura.getTagliaVittima())%></div>
	<div class="clear1"></div>
		
<%
	}
%>
	<div class="nodott_margin_low" >Rilievi sull'aggressore: Patologie</div>
	<div class="dott_margin_low" >&nbsp;<%=tipologieRilievi.getSelectedValue(dati_morsicatura.getPatologie())%></div>
	<div class="clear1"></div>

	<div class="nodott_margin_low" >Rilievi sull'aggressore: Alterazioni comportamentali</div>
	<div class="dott_margin_low" >&nbsp;<%=tipologieRilievi.getSelectedValue(dati_morsicatura.getAlterazioniComportamentali())%></div>
	<div class="clear1"></div>
	
	<div class="nodott_margin_low" >Analisi gestione</div>
	<div class="dott_margin_low" >&nbsp;<%=tipologieAnalisiGestione.getSelectedValue(dati_morsicatura.getAnalisiGestione())%></div>
	<div class="clear1"></div>	
	
	<div class="nodott_margin_low" >Veterinari</div>
	<div class="dott_margin_low" >&nbsp;<%=dati_morsicatura.getVeterinariEstesi()%></div>
	<div class="clear1"></div>	
	
	<div class="nodott_margin_low" >Controllo ufficiale</div>
	<div class="dott_margin_low" >&nbsp;<%=dati_morsicatura.getIdCu()%></div>
	<div class="clear1"></div>
	
	
<div class="nodott_margin_low" >Misure formative</div>
<div class="dott_long_margin_low" ><%=dati_morsicatura.getMisureFormative()%></div>
<div class="clear1"></div>
<div class="nodott_margin_low" >Misure riabilitative</div>
<div class="dott_long_margin_low" ><%=dati_morsicatura.getMisureRiabilitative()%></div>
<div class="clear1"></div>
<div class="nodott_margin_low" >Misure restrittive</div>
<div class="dott_long_margin_low" ><%=dati_morsicatura.getMisureRestrittive()%></div>
<div class="clear1"></div>





<div class="nodott_margin_low" >Data rilascio certificato:</div>
<%	
java.sql.Date timeNow = new java.sql.Date(Calendar.getInstance().getTimeInMillis()); %>
<div class="dott_margin_low" >&nbsp;<%=dataToString( timeNow ) %> </div>



<div class="firma">TIMBRO E FIRMA DEL VETERINARIO</div>

<div class="firmavalore">&nbsp;</div>

</body>

