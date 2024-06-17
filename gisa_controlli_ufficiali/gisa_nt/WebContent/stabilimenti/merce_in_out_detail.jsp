<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ include file="../utils23/initPage.jsp" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.stabilimenti.base.Organization" scope="request" />
<jsp:useBean id="merce" class="org.aspcfs.modules.stabilimenti.base.MerceInOut" scope="request" />
<jsp:useBean id="destinatario" class="org.aspcfs.modules.stabilimenti.base.Organization" scope="request" />
<jsp:useBean id="TipoMollusco" class="org.aspcfs.utils.web.LookupList" scope="request" />

<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="Stabilimenti.do"><dhv:label name="stabilimenti.stabilimenti">Accounts</dhv:label></a> > 
			<a href="Stabilimenti.do?command=Search"><dhv:label name="stabilimenti.SearchResults">Search Results</dhv:label></a> >
			<a href="Stabilimenti.do?command=Details&orgId=<%=OrgDetails.getOrgId() %>"><dhv:label name="communications.campaign.Dashboards">Scheda Stabilimento</dhv:label></a> >

			<a href="StabMerceInOut.do?command=List&orgId=<%=OrgDetails.getOrgId() %>"><dhv:label name="merce_out">Merce in Uscita</dhv:label></a> > 
			<dhv:label name="merce_in_out.detail">Scheda Merce in Ingresso/Uscita</dhv:label>
		</td>
	</tr>
</table>

<dhv:container name="<%=(OrgDetails.isMacelloUngulati()) ? ("stabilimenti_macellazioni_ungulati") : ("stabilimenti") %>" selected="merce_in_out" object="OrgDetails" param='<%= "orgId=" + OrgDetails.getOrgId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>'>

	<table cellpadding="2" cellspacing="2" border="0" width="100%">
	  <tr>
	  	<td>
	  	<dhv:permission name="stabilimenti-stabilimenti-merce_in_out-edit">
	  		<input type="button" value="Modifica" onclick="location.href='StabMerceInOut.do?command=Modify&id=<%=merce.getId() %>'" />
	  	</dhv:permission>
	  	<dhv:permission name="stabilimenti-stabilimenti-merce_in_out-delete">
	  		<input type="button" value="Cancella" onclick="if(confirm( 'Sicuro di voler eliminare?' )){location.href='StabMerceInOut.do?command=Delete&id=<%=merce.getId() %>&orgId=<%=merce.getId_stabilimento() %>'}" />
	  	</dhv:permission>
	  	</td>
	  </tr>
	  <tr>
	    <td width="50%" valign="top">
	
	      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	        
	        <tr>
	          <th colspan="2">
	            <strong><dhv:label name="moll.merce_out">Scheda Merce in Uscita</dhv:label></strong>&nbsp;
	          </th>
	        </tr>
	        
	        <tr class="containerBody">
			    <td nowrap class="formLabel">
			      <dhv:label name="stab.stab">Stabilimento</dhv:label>
			    </td>
			    <td>
			    	<%=toHtmlValue( OrgDetails.getName() ) %>&nbsp;
			    	<input type="hidden" name="orgId" value="<%=OrgDetails.getOrgId()  %>" />
			    </td>
			  </tr>
			  
			    <tr class="containerBody">
				    <td nowrap class="formLabel">
				      <dhv:label name="merce_in_out.data_invio">Data Arrivo</dhv:label>
				    </td>
				    <td>
				      <zeroio:tz showTimeZone="false" dateOnly="true" timestamp="<%=merce.getData_arrivo() %>"  timeZone="<%=User.getTimeZone() %>"  />&nbsp;
				    </td>
				 </tr>
	        
			    <tr class="containerBody">
				    <td nowrap class="formLabel">
				      <dhv:label name="merce_in_out.data_invio">Data Invio</dhv:label>
				    </td>
				    <td>
				      <zeroio:tz showTimeZone="false" dateOnly="true" timestamp="<%=merce.getData_invio() %>"  timeZone="<%=User.getTimeZone() %>"  />&nbsp;
				    </td>
				 </tr>
				 
			   <tr class="containerBody">
			    <td nowrap class="formLabel">
			      <dhv:label name="merce_in_out.moll">Specie Mollusco</dhv:label>
			    </td>
			    <td>
			      <%=TipoMollusco.getSelectedValue( merce.getId_specie_mollusco() ) %>&nbsp;
			    </td>
			  </tr>
			  
			   <tr class="containerBody">
			    <td nowrap class="formLabel">
			      <dhv:label name="merce_in_out.quantita">Quantit&agrave;</dhv:label>
			    </td>
			    <td>
			      <%=toHtmlValue( merce.getQuantita() ) %>&nbsp;
			    </td>
			  </tr>
			  
			   <tr class="containerBody">
			    <td nowrap class="formLabel">
			      <dhv:label name="merce_in_out.id_destinatario">Provenienza <%= toHtmlValue( (String)request.getAttribute( "tipo_provenienza" ) ) %></dhv:label>
			    </td>
			    <td>
			         <%= toHtml( (String)request.getAttribute( "provenienza" ) ) %>&nbsp;
			    </td>
			  </tr>
			  
				<tr class="containerBody">
			    <td nowrap class="formLabel">
			      <dhv:label name="merce_in_out.stato_regione_prvenienza">Stato/Regione Provenienza</dhv:label>
			    </td>
			    <td>
			      <%=toHtmlValue( merce.getStato_regione_provenienza() ) %>&nbsp;
			    </td>
			  </tr>
			  
			  <tr class="containerBody">
			    <td nowrap class="formLabel">
			      <dhv:label name="merce_in_out.id_destinatario">Destinatario</dhv:label>
			    </td>
			    <td>
			         <%= toHtml(destinatario.getName()) %>&nbsp;
			    </td>
			  </tr>
			  
			  <tr class="containerBody">
			    <td nowrap class="formLabel">
			      <dhv:label name="merce_in_out.id_doc_traporto">Identificativo Documento di Trasporto</dhv:label>
			    </td>
			    <td>
			      <%=toHtmlValue( merce.getIdentificativo_documento_trasporto() ) %>&nbsp;
			    </td>
			  </tr>
	        
	      </table>
	      
	      
	    </td>
	    
	  </tr>
	  
	</table>
</dhv:container>




