<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html40/strict.dtd">
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page
	import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*,org.aspcfs.modules.anagrafe_animali.base.*,org.aspcfs.modules.opu.base.*, java.util.Date"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<%@ include file="../../initPage.jsp"%>

<link rel="stylesheet" type="text/css" media="screen"
	href="anagrafe_animali/documenti/screen.css">
<link rel="stylesheet" documentale_url="" href="anagrafe_animali/documenti/print.css"
	type="text/css" media="print" />

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<jsp:useBean id="aslList" class="org.aspcfs.utils.web.LookupList" scope="request" />



<%-- <body onload="javascript:closeAndRefresh('<%= request.getAttribute("chiudi")%>','<%= request.getAttribute("redirect")%>')">--%>
<body>
<input type="submit" name="stampa" class="buttonClass"
	onclick="window.print();" value="Stampa" />
<div class="imgRegione">
<img style="text-decoration: none;" width="80" height="80" documentale_url="" src="anagrafe_animali/documenti/images/regionecampania.jpg" />
</div>

<dhv:evaluate if="<%=(User.getSiteId()>0) %>"> 
<div class="imgAsl">
<img style="text-decoration: none;" width="80" height="80" documentale_url="" src="anagrafe_animali/documenti/images/<%=aslList.getSelectedValue(User.getSiteId()) %>.jpg" />
</div>
</dhv:evaluate>
<div class="Section1">
 </br></br>
<div class="title1">RICHIESTA DI ADOZIONE DA RIFUGIO
REGIONALE</div>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;


<div class="nodott">Il sottoscritto</div>
<div class="dott_long">&nbsp;</div>
<div class="clear1"></div>
<div class="nodott" style="margin-top: 0px;">Codice Fiscale</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="nodott" style="margin-top: 0px;">Nato a</div>
<div class="dott" style="margin-top: 0px;">&nbsp;</div>
<div class="clear1"></div>


<div class="nodott" style="margin-top: 0px;">il</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="nodott" style="margin-top: 0px;">e residente in</div>
<div class="dott" style="margin-top: 0px;">&nbsp;</div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">alla via</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="nodott" style="margin-top: 0px;">cap</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="nodott" style="margin-top: 0px;">tel.</div>
<div class="dott" style="margin-top: 0px;">&nbsp;</div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">chiede l'adozione del cane randagio di propriet� del Comune di</div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">comune di</div>
<div class="dott_long" style="margin-top: 0px;">&nbsp;</div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">razza</div>
<div class="dott" style="margin-top: 0px;">&nbsp;</div>
<div class="nodott" style="margin-top: 0px;">sesso</div>
<div class="dott" style="margin-top: 0px;">&nbsp;</div>
<div class="nodott" style="margin-top: 0px;">data di nascita</div>
<div class="dott" style="margin-top: 0px;">&nbsp;</div>
<div class="clear1"></div>


<div class="nodott" style="margin-top: 0px;">taglia</div>
<div class="dott" style="margin-top: 0px;">&nbsp;</div>
<div class="nodott" style="margin-top: 0px;">mantello</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="clear1"></div>




<div class="nodott" style="margin-top: 0px;">segni particolari</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">sterilizzato *</div>
<div class="nodott" style="margin-top: 0px;">&nbsp; NO &nbsp; &nbsp; &nbsp; &nbsp;   SI  &nbsp; &nbsp; &nbsp; &nbsp;
					
</div>


<div class="nodott" style="margin-top: 0px;">il</div>
<div class="nodott" style="margin-top: 0px;">&nbsp; 
</div>

<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">nome del cane</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="nodott" style="margin-top: 0px;">adottato dal rifugio</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">sito in via</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="nodott" style="margin-top: 0px;">Comune</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="nodott" style="margin-top: 0px;">Prov</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="clear1"></div>

<div class="nodott" style="margin-top: 0px;">data di adozione</div>
<div class="dott" style="margin-top: 0px;">&nbsp; </div>
<div class="clear1"></div>
</br>

<div class="nodott" style="margin-top: 0px;">
* Nel caso di cessione di cuccioli di et� inferiore ai 6 mesi il sottoscritto si impegna a provvedere alla sterilizzazione
del cane una volta raggiunta l'et� idonea all'intervento. La sterilizzazione pu� essere effettuata o presso i servizi
veterinari territoriali (procedura di richiamo) o da un medico veterinario libero professionista, esibendo
certificazione di avvenuta sterilizzazione alla ASL per la registrazione in banca dati.

</div>
<div class="clear1"></div>
</br>

<div class="nodott" style="margin-top: 0px;">Dichiara di essere a conoscenza dei seguenti obblighi di legge (L.R. 3/19 e ss.mm.ii.)<br>
- denunciare entro tre giorni la morte o lo smarrimento/furto del cane;<br>
- denunciare entro cinque giorni il trasferimento di propriet� del cane, la variazione della propria residenza;<br>
</div>
<div class="clear1"></div>

</br>
</br>

<div class="data">DATA</div>
<br>
<div class="datavalore"></div>
</BR></BR>
<div class="firma_left">FIRMA E TIMBRO DEL TITOLARE DEL RIFUGIO</div>
</br></br></br>
<div class="firmavalore_left"></div>
<div class="clear1"></div>


<div class="firma">FIRMA DEL NUOVO PROPRIETARIO</div>
</br></br></br>
<div class="firmavalore"></div>
<div class="clear1"></div>
</br>
</br>
<div class="nodott" style="margin-top: 0px;">Documento di riconoscimento</div>
<div class="dott" style="margin-top: 0px;">&nbsp; 
</div>
<div class="clear1"></div>
</br>
<div class="nodott" style="margin-top: 0px;">Microchip assegnato</div>
<div class="dott" style="margin-top: 0px;">&nbsp; 
</div>
<div class="clear1"></div>
</br></br>

<br><br><br>
<%@ include file="/gestione_documenti/gdpr_footer.jsp" %>
<br/>


</div>
</body>

