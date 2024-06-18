<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>

<c:choose>
	<c:when test="${cc.accettazione.animale.necroscopiaNonEffettuabile==false && cc.autopsia==null}">

		<input id="aggiungi_richiesta" type="button" value="Aggiungi Richiesta" 
			<c:if test="${cc.autopsia==null}">
				onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.autopsie.ToAdd.us'}
    				}else{location.href='vam.cc.autopsie.ToAdd.us'}"
			</c:if>
			<c:if test="${cc.autopsia!=null}">
				onclick="alert('Esame necroscopico gi� inserito per questa CC')"
			</c:if>
		>
		<c:if test="${cc.dataChiusura==null}">
			<input type="button" id="necroscopia_non_effettuabile" value="Esame Necroscopico Non Effettuabile" 
			onclick="if(${cc.dataChiusura!=null})
			        { 
				       if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?'))
				       {
				          location.href='vam.izsm.autopsie.NecroscopiaNonEffettuabile.us?flag=true';
				       }
				    }
				    else
				    {
				        if(myConfirm('Sicuro di voler procedere?'))
				        {
				           location.href='vam.izsm.autopsie.NecroscopiaNonEffettuabile.us?flag=true';
				        }
				    }"/>
		</c:if>
	</c:when>
	<c:when test="${cc.accettazione.animale.necroscopiaNonEffettuabile==true}">
		<script>
			document.getElementById("aggiungi_richiesta").disabled=true;
			document.getElementById("necroscopia_non_effettuabile").disabled=true;
		</script>
		<br><b>Esame Necroscopico dichiarato non effettuabile</b>
		<c:if test="${cc.dataChiusura==null}">
			<input type="button" id="necroscopia_non_effettuabile_riapri" value="Rendi effettuabile" onclick="if(myConfirm('Sicuro di voler procedere?')){location.href='vam.izsm.autopsie.NecroscopiaNonEffettuabile.us?flag=false';}"/><br>
		</c:if>
	</c:when>
</c:choose>

<h4 class="titolopagina">
     		Richieste Esami Necroscopici
</h4>

<div class="area-contenuti-2">
	<form action="vam.izsm.autopsie.List.us" method="post">
		
		<jmesa:tableModel items="${autopsie}" id="a" var="a" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>
					<jmesa:htmlColumn property="dataAutopsia" 		filterable="false" title="Data richiesta" 	pattern="dd/MM/yyyy" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate pattern="dd/MM/yyyy" value="${a.dataAutopsia}"  />
					</jmesa:htmlColumn>
					<jmesa:htmlColumn property="dataEsito" 		filterable="false" title="Data Necroscopia" 	pattern="dd/MM/yyyy" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate pattern="dd/MM/yyyy" value="${a.dataEsito}"  />
					</jmesa:htmlColumn>
					<jmesa:htmlColumn property="lass" 		filterable="false" title="Sala settoria Destinazione"/>
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a href="vam.izsm.autopsie.Detail.us?id=${a.id}" onclick="attendere();">Dettaglio</a>
								<c:if test="${cc.accettazione.animale.necroscopiaNonEffettuabile==false}">
								<c:if test="${(utenteStrutturaNecroscopia || utente.ruoloByTalos=='HD1' || utente.ruoloByTalos=='HD2') && canEditRichiesta}">
									<a id="ie" href="vam.cc.autopsie.ToEditRichiesta.us?id=${a.id}"  onclick="if(${cc.dataChiusura!=null}){ 
			    				return myConfirm('Cartella Clinica chiusa. Vuoi procedere?');
	    						}else{attendere();return true;}">Modifica</a>
	    						</c:if>
								</c:if>
								<c:if test="${cc.accettazione.animale.necroscopiaNonEffettuabile==false}">
									<c:if test="${utenteStrutturaNecroscopia || utente.ruoloByTalos=='HD1' || utente.ruoloByTalos=='HD2'}">
									<a id="ie" href="vam.izsm.autopsie.ToEdit.us?id=${a.id}"  onclick="if(${cc.dataChiusura!=null}){ 
			    				return myConfirm('Cartella Clinica chiusa. Vuoi procedere?');
	    						}else{attendere();return true;}">
	    						<c:if test="${a.dataEsito!=null}">
									Modifica Necroscopia
								</c:if>
								<c:if test="${a.dataEsito==null}">
									Inserisci Necroscopia
								</c:if>
	    						</a>
	    							</c:if>
								</c:if>
					</jmesa:htmlColumn>
					
				</jmesa:htmlRow>
			</jmesa:htmlTable>
		</jmesa:tableModel>
	</form>
	
	<script type="text/javascript">
		function onInvokeAction(id)
		{
			setExportToLimit(id, '');
			createHiddenInputFieldsForLimitAndSubmit(id);
		}
		function onInvokeExportAction(id)
		{
			var parameterString = createParameterStringForLimit(id);
			location.href = 'vam.izsm.autopsie.List.us?' + parameterString;
		}
	</script>
</div>