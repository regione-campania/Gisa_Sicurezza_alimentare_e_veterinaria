<%@ page contentType="text/html; charset=windows-1252" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Lista Esami Fip
</h4>

<input type="button" value="Aggiungi Esame Fip" onclick="if(${cc.dataChiusura!=null}){ 
	if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.fip.ToAddEdit.us'}
	}else{location.href='vam.cc.fip.ToAddEdit.us'}">

<div class="area-contenuti-2">
	<form action="vam.cc.fip.List.us" method="post">
		
		<jmesa:tableModel items="${cc.fips }" id="fip" var="fip" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap">
			<jmesa:htmlTable styleClass="tabella">
				<jmesa:htmlRow>

					<jmesa:htmlColumn property="dataRichiesta" 			title="Data Richiesta" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate value="${fip.dataRichiesta}" pattern="dd/MM/yyyy" var="dataRichiesta"/>
    			 		<c:out value="${dataRichiesta}"></c:out>					
					</jmesa:htmlColumn>		
					
					<jmesa:htmlColumn property="dataEsito" 			title="Data Esito" filterEditor="it.us.web.util.jmesa.DateFilterEditor">
						<fmt:formatDate value="${fip.dataEsito}" pattern="dd/MM/yyyy" var="dataEsito"/>
    			 		<c:out value="${dataEsito}"></c:out>					
					</jmesa:htmlColumn>
					
					<jmesa:htmlColumn property="esito" 	title="Esito" sortable="false" cellEditor="it.us.web.util.jmesa.NegativoPositivoCellEditor" filterEditor="it.us.web.util.jmesa.NegativoPositivoDroplistFilterEditor"/>
													
					<jmesa:htmlColumn sortable="false" filterable="false" title="Operazioni">
							<a id="mod" href="vam.cc.fip.ToAddEdit.us?modify=on&idFip=${fip.id}" onclick="if(${cc.dataChiusura!=null}){ 
			    				return myConfirm('Cartella Clinica chiusa. Vuoi procedere?');
	    						}else{return true;}">Modifica</a>
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
			location.href = 'vam.cc.fip.List.us?' + parameterString;
		}
	</script>
</div>