<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "org.json.JSONArray, org.json.JSONObject" %>
<%@ page import="java.util.ArrayList, java.util.Iterator" %>
<%@page import="org.aspcfs.modules.opu.base.*, java.util.HashMap"%>
<jsp:useBean id="lookupListTipoImpresa" class="org.aspcfs.utils.web.LookupList"  scope ="request" />



<style type="text/css">
        select:not([disabled]) { border-color: lightblue; background-color: #EEFFEE; }
 </style>

	<%
	HashMap<Integer,ArrayList<Integer>> lookupTipoImpresaToTipoSocieta =(HashMap<Integer,ArrayList<Integer>>) request.getAttribute("lookupTipoImpresaToTipoSocieta");
	%><script>
		window.jsLookupTipoImpresaToTipoSocieta = {};
	</script><%
	for(Integer idTipoImpresa : lookupTipoImpresaToTipoSocieta.keySet())
	{
		%>
			<script>window.jsLookupTipoImpresaToTipoSocieta[<%=idTipoImpresa%>]=[];</script>
		<%
		ArrayList<Integer> tipiSocieta = lookupTipoImpresaToTipoSocieta.get(idTipoImpresa);
		for(Integer tipoSocieta : tipiSocieta)
		{
			if(tipoSocieta == 11)
				tipoSocieta = 0;
		  %>
			<script>window.jsLookupTipoImpresaToTipoSocieta[<%=idTipoImpresa%>].push(<%=tipoSocieta%>)</script>
		<%}
	}
	
	%>
	
	
	
	




	<!-- per ogni proprieta del bean che rappresenta operatore duplicato, devo salvare tutti i possibili valori che esistono -->
	<% 
		
		//LookupList lookupSelectTipoImpresa = request.getAttribute("lookupTipoImpresa");
	
		ArrayList<OperatorePerDuplicati> entries = (ArrayList<OperatorePerDuplicati>)request.getAttribute("entriesChecked");
		HashMap<String,ArrayList<String[]>> allValues = new HashMap<String,ArrayList<String[]>>();
		//scarico tutte le proprieta dal bean della singola entry
		for(OperatorePerDuplicati t : entries)
		{
			
			HashMap<String,String[]> propValues = t.getValuesPerForm();
			
			for(String nomeProp : propValues.keySet())
			{
				if(!nomeProp.equals("tipoImpresa"))
					continue;
				/*if(propValues.get(nomeProp)[0].matches(" *")) //se l'entry � un valore fatto solo di spazi vuoti
					continue;*/
				if(propValues.get(nomeProp)[0] == null)
					continue;
				if(!allValues.containsKey(nomeProp)) //prima entry sicuramente
				{
					allValues.put(nomeProp,new ArrayList<String[]>());
				}
				else
				{
					boolean haveToAdd = true;
					for(String[] alreadyAdded : allValues.get(nomeProp))
					{
						/*String already = alreadyAdded[0];
						String toComp = propValues.get(nomeProp)[0];
						*/
						
						if( alreadyAdded[0].equals(propValues.get(nomeProp)[0]) )
						{
							haveToAdd = false;
							break;
						}
					}
					if(!haveToAdd)
						continue;
					//if( allValues.get(nomeProp).contains( propValues.get(nomeProp)  ) )
						//continue;
				}
				
				allValues.get(nomeProp).add(propValues.get(nomeProp));
				
			}
		}
	
	%> 


	 <form id="example-advanced-form" name="convergiImprese"  action="#" enctype="multipart/form-data">
	        
	       
	        <h3>TIPO IMPRESA</h3>
	        <fieldset>
	                <legend style="background-color:lightblue;">TIPOLOGIA IMPRESA</legend>
					<!-- NON mostro tutti i possibili tipoImpresa se � verificato che:
					il size dei tipoImpresa ricevuti � > 0 e non accade che ce n'e' soltanto uno che � fatto da uno o piu' spazi vuoti soltanto -->
					<%if(allValues.get("tipoImpresa").size() != 0  && !(allValues.get("tipoImpresa").size()==1 && allValues.get("tipoImpresa").get(0)[0].matches(" *") ) )
					{%>
						<!-- inoltre se � solo 1 non � attivata la scelta della select -->
		                <select id="selTipoImpresa">
		                <%
		                 
		                  for(String[] tipoImpresa : allValues.get("tipoImpresa")) 
		                  {
		                  	if(tipoImpresa[0].matches(" *"))
		                  		continue; 
		                  %><!-- in realt� stampo il tipo impresa ma il valore associato � l'd -->
		                	<option <%= !tipoImpresa[0].matches(" *") ? "selected=\"selected\"" : "" %> value=<%=tipoImpresa[1] %>><%=tipoImpresa[0] %></option> 
		                <%} 
		                   %>
		                </select>
		                
		                <script>
		                	($("#selTipoImpresa option").size()==1)
		                	{
		                		$("#selTipoImpresa").attr("disabled","disabled");
		                	}
		                </script>
		                
		           <%} 
					else //uso la lookup
					{
						out.print(lookupListTipoImpresa.getHtmlSelect("selTipoImpresa",-1)); 
						
					}
		           %>
		           <!-- evento per il change della selezione tipo impresa (perch� condiziona il tipo societa) -->
		           <!-- deve partire nel caso in cui sia possibile scegliere qualunque tipo di impresa -->
						           
		           <script>
		           
		           
		           	$("#selTipoImpresa").change(function()
		           			{
		           		
		           				
		           					var tipoImpresa = $(this).val();
		           					var tipiSocietaValidi = jsLookupTipoImpresaToTipoSocieta[tipoImpresa];
		           					//rimetto selezionato quello -1
		           					$("#selTipoSocieta option").removeAttr("selected");
		           					$('#selTipoSocieta option[value="-1"]').attr("selected",true);
		           					
		           					//disattivo prima tutti
		           					$("#selTipoSocieta option").attr("disabled",true);
		           					//e poi disattivo tutti quelli che sono in...
		           					for(i in tipiSocietaValidi)
		           					{
		           						
		           						var tipoSocieta = tipiSocietaValidi[i];
		           						console.log("attivo select per tipoImpresa: "+tipoImpresa+ " tipo societa " +tipoSocieta + " "+$("#selTipoSocieta option[value="+tipoSocieta+""));
		           						//disattivo l'option che ha come value quel tipo societa, nel select delle societa
		           						$("#selTipoSocieta option[value="+String(tipoSocieta)+"]").attr("disabled",false);
		           					}
		           			
		           				
		           			});
		           </script>
		           
	        </fieldset>
	        
	                
	        <h3>IMPRESA</h3>
	        <fieldset>
	               <jsp:include page="formDatiImpresa.jsp"/>
	        </fieldset>
	        
	        
	</form>


</body>
</html>