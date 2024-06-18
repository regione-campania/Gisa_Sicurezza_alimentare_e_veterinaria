<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<h4 class="titolopagina">
     		Esami citologici
</h4>

<div class="area-contenuti-2">

 
	<form action="vam.diagnosiCitologica.ListLLPP.us" method="post">		
		<jmesa:tableModel items="${esamiCitologici}" id="ei" var="ei" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap" columnSort="it.us.web.util.jmesa.CustomColumnSort">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

<jmesa:htmlColumn property="numero" 			title="Numero Esame" filterable="false" sortable="false"/>
					
					
					<jmesa:htmlColumn property="identificativoAnimale"     title="Microchip">
						${ei.getIdentificativoAnimale() }
					</jmesa:htmlColumn>					
					<jmesa:htmlColumn property="dataRichiesta" 		title="Data Richiesta" 	pattern="dd/MM/yyyy" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate pattern="dd/MM/yyyy" value="${ei.dataRichiesta}"  />
					</jmesa:htmlColumn>
				    <jmesa:htmlColumn property="dataEsito" 			title="Data Esito" 		pattern="dd/MM/yyyy" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate pattern="dd/MM/yyyy" value="${ei.dataEsito}"  />
					</jmesa:htmlColumn>
					<jmesa:htmlColumn property="" title="Diagnosi" filterable="false" sortable="false">
						<c:choose>
    						<c:when test="${ei.idDiagnosiPadre==1}">
    							Sospetto benigno<br/>
			    			</c:when>
			    			<c:when test="${ei.idDiagnosiPadre==2}">
			    				Sospetto maligno<br/>
			    				${ei.diagnosi.padre} -> ${ei.diagnosi}
			    			</c:when>
			    			<c:when test="${ei.idDiagnosiPadre==3}">
			    				Non diagnostico<br/>
			    			</c:when>
			    		</c:choose>
					</jmesa:htmlColumn>
														
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a href="vam.diagnosiCitologica.DetailLLPP.us?id=${ei.id}" onclick="attendere()">Dettaglio</a>
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
			location.href = 'vam.izsm.esamiIstopatologici.ToFind.us?' + parameterString;
		}
	</script>
</div>