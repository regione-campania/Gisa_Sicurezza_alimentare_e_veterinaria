<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html40/strict.dtd">
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page
	import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*,org.aspcfs.modules.anagrafe_animali.base.*,java.io.IOException,org.aspcfs.modules.opu.base.*,java.util.Date,com.sun.org.apache.xerces.internal.impl.dv.util.Base64,java.io.ByteArrayOutputStream,javax.imageio.ImageIO"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<%@ include file="../../initPage.jsp"%>

<jsp:useBean id="animale" class="org.aspcfs.modules.anagrafe_animali.base.Animale" scope="request" />

<link rel="stylesheet" type="text/css" media="screen"
	href="anagrafe_animali/documenti/screen.css">
<link rel="stylesheet" href="anagrafe_animali/documenti/print.css"
	type="text/css" media="print" />

<%String nomeSpecie="animale";
if (animale!=null)
	nomeSpecie = animale.getNomeSpecieAnimale().toLowerCase();%>
<%-- <body onload="javascript:closeAndRefresh('<%= request.getAttribute("chiudi")%>','<%= request.getAttribute("redirect")%>')">--%>
<body>
<input type="submit" name="stampa" class="buttonClass"
	onclick="window.print();" value="Stampa" />

<div class="title1">Legge Regionale n. 3 del 11.4.2019 <br/>"Disposizioni volte a promuovere e a tutelare il rispetto ed il benessere degli animali d'affezione e a prevenire il randagismo"<br/>
                    Art. 6 (Banca dati regionale anagrafe degli animali d'affezione) Comma 10
</div>
<br/>
Il proprietario del cane � tenuto a segnalare per iscritto al servizio veterinario dell'ASL territorialmente competente:
<ol start="1">
	<li>la variazione della propria residenza o domicilio entro cinque giorni dall'evento;</li>
	<li>il trasferimento di propriet� del <%=nomeSpecie%> entro cinque giorni dall'evento;</li>
	<li>lo smarrimento o furto o ritrovamento del <%=nomeSpecie%> entro tre giorni dall'evento;</li>
	<li>il decesso del <%=nomeSpecie%>, entro tre giorni dall'evento;</li>
	<li>la detenzione del proprio <%=nomeSpecie%> presso luogo diverso da quello dichiarato all'atto di iscrizione in banca dati, in caso di permanenza superiore a 20 giorni.</li>
</ol>