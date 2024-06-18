<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
         
   
    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
   	<h4 class="titolopagina">
     		Lista delle Terapie in Degenza
    </h4>
    

<INPUT type="button" value="Aggiungi Terapia Farmacologica" 
	<c:choose>
		<c:when test="${esisteMagazzinoFarmaci!=null && esisteMagazzinoFarmaci==false}">
			onclick="alert('Non � possibile aggiungere una terapia farmacologica se il magazzino dei farmaci � vuoto.\nCaricare i farmaci prima di proseguire.');"		
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${numeroTerapieFarmacologiche==0}">
					onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.terapieDegenza.Add.us'}
    				}else{location.href='vam.cc.terapieDegenza.Add.us'}"		
				</c:when>
				<c:otherwise>
				    onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){
    					if( myConfirm('Attenzione: inserendo questa terapia, l\'attuale terapia farmacologica aperta sar� chiusa e non pi� modificabile') ){location.href='vam.cc.terapieDegenza.Add.us'}
    				}
    				}else{if( myConfirm('Attenzione: inserendo questa terapia, l\'attuale terapia farmacologica aperta sar� chiusa e non pi� modificabile') ){location.href='vam.cc.terapieDegenza.Add.us'}}"
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
>

<INPUT type="button" value="Aggiungi Altra Terapia" 
		<c:choose>
			<c:when test="${numeroAltreTerapie==0}">
				onclick="location.href='vam.cc.terapieDegenza.AddAltra.us'"		
			</c:when>
			<c:otherwise>
			    onclick="if( myConfirm('Attenzione: inserendo questa terapia, l\'attuale terapia aperta sar� chiusa e non pi� modificabile') ){location.href='vam.cc.terapieDegenza.AddAltra.us'}"
			</c:otherwise>
		</c:choose>
>


	 
<div class="area-contenuti-2">
	<form action="vam.cc.terapieDegenza.List.us" method="post">
		
		<jmesa:tableModel items="${tdList}" id="td" var="td" filterMatcherMap="it.us.web.util.jmesa.MyFilterMatcherMap" >
			<jmesa:htmlTable styleClass="tabella" >
				<jmesa:htmlRow>	
					
					<jmesa:htmlColumn property="data" title="Data Apertura" filterable="false">
						<fmt:formatDate value="${td.data}" pattern="dd/MM/yyyy HH:mm" var="data"/>
    			 		<c:out value="${data}"></c:out>		
    			 	</jmesa:htmlColumn>
    			 	
    			 	<jmesa:htmlColumn property="dataChiusura" title="Data Chiusura" filterable="false">
						<fmt:formatDate value="${td.dataChiusura}" pattern="dd/MM/yyyy HH:mm" var="data"/>
    			 		<b><c:out value="${data}"></c:out></b>		
    			 	</jmesa:htmlColumn>
    			 	
    			 	<jmesa:htmlColumn title="Tipo" property="tipo"/>
										
					<jmesa:htmlColumn property="enteredBy" title="Effettuata da" sortable="false" filterable="false" />
					
					<jmesa:htmlColumn sortable="false" filterable="false" 				title="Dettaglio">
							<c:if test="${td.tipo=='Farmacologica'}">
								<a href="vam.cc.terapieDegenza.Detail.us?idTerapiaDegenza=${td.id}">Dettaglio</a>	
							</c:if>
							<c:if test="${td.tipo=='Altra'}">
								<a href="vam.cc.terapieDegenza.DetailAltra.us?idTerapiaDegenza=${td.id}">Dettaglio</a>	
							</c:if>
							<a href="vam.cc.terapieDegenza.Delete.us?idTerapiaDegenza=${td.id}">Elimina</a>
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
			location.href = 'vam.cc.terapieDegenza.List.us?' + parameterString;
		}
	</script>
</div>	
	

