<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/taglib/systemcontext-taglib.tld" prefix="sc"%>

<%@ page
	import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*"%>


<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>
<jsp:useBean id="ListaLineeProduttive"
	class="org.aspcfs.modules.opu.base.LineaProduttivaList" scope="request" />
<jsp:useBean id="SearchOrgListInfo"
	class="org.aspcfs.utils.web.PagedListInfo" scope="session" />
<jsp:useBean id="AccountStateSelect"
	class="org.aspcfs.utils.web.StateSelect" scope="request" />
<jsp:useBean id="ContactStateSelect"
	class="org.aspcfs.utils.web.StateSelect" scope="request" />
<jsp:useBean id="CountrySelect"
	class="org.aspcfs.utils.web.CountrySelect" scope="request" />
<jsp:useBean id="OrgDetails"
	class="org.aspcfs.modules.accounts.base.Organization" scope="request" />
<jsp:useBean id="ComuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="regioniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="SegmentList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="StageList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="LineeProduttiveList"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="LineaProduttiva"
	class="org.aspcfs.modules.opu.base.LineaProduttiva" scope="request" />
<jsp:useBean id="animale"
	class="org.aspcfs.modules.anagrafe_animali.base.Animale"
	scope="request" />

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkNumber.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkEmail.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript"
	SRC="javascript/popLookupSelect.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/confirmDelete.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkURL.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/setSalutation.js"></script>
<%@ include file="../initPage.jsp"%>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-1.8.2.js"></script>
<script src="https://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>

<!-- DWR -->

<script type="text/javascript" src="dwr/interface/DwrUtil.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="dwr/interface/DwrUtil.js"> </script>


<style>
.ui-combobox {
	position: relative;
	display: inline-block;
}

.ui-combobox-toggle {
	position: absolute;
	top: 0;
	bottom: 0;
	margin-left: -1px;
	padding: 0;
	/* adjust styles for IE 6/7 */ *
	height: 1.7em; *
	top: 0.1em;
}

.ui-combobox-input {
	margin: 0;
	padding: 0.3em;
}
</style>

<%
	int tipologiaSoggetto=0;
	if(request.getAttribute("TipologiaSoggetto") != null  && request.getAttribute("TipologiaSoggetto")!="")
       tipologiaSoggetto=Integer.parseInt((String)request.getAttribute("TipologiaSoggetto"));
	System.out.print("************************** "+tipologiaSoggetto);
	%>

<script>
//Regioni comuni e province per eventotrasferimentofuoriregionesoloproprietario
$(document).ready(function(){
 $('#idRegioneFr').change(function(){
  var elem = $(this).val();
  // alert(elem);
  $.ajax({
   type: 'POST',
   url:'ServletRegioniComuniProvince',
   dataType: 'json',
   data: {'idRegioneFr':elem, 'tipoRichiesta':1},
   success: function(res){
	  // alert(res);
    $('#idProvinciaFr option').each(function(){$(this).remove()});
    $('#idProvinciaFr').append('<option selected="selected">Seleziona...</option>');
    $('#searchcodeIdComuneStabilimento option').each(function(){$(this).remove()});
    $('#searchcodeIdComuneStabilimento').append('<option selected="selected">Seleziona...</option>');
    $.each(res, function(i, e){
       // alert(e.codice);
     $('#idProvinciaFr').append('<option value="' + e.codice + '">' + e.descrizione + '</option>');
    });
   }
  });
 });
  
 $('#idProvinciaFr').change(function(){
  var elem = $(this).val();
   
  $.ajax({
   type: 'POST',
   url:'ServletRegioniComuniProvince',
   dataType: 'json',
   data: {'idProvinciaFr':elem, 'tipoRichiesta':2},
   success: function(res){
    $('#searchcodeIdComuneStabilimento option').each(function(){$(this).remove()});
    $('#searchcodeIdComuneStabilimento').append('<option selected="selected">Seleziona...</option>');
    $.each(res, function(i, e){
     $('#searchcodeIdComuneStabilimento').append('<option value="' + e.codice + '">' + e.descrizione + '</option>');
    });
   }
  });
 });
  
});

    function popUp(url) {
    	  title  = '_types';
    	  width  =  '500';
    	  height =  '600';
    	  resize =  'yes';
    	  bars   =  'yes';
    	  
    	  var posx = (screen.width - width)/2;
    	  var posy = (screen.height - height)/2;
    	  
    	  var windowParams = 'WIDTH=' + width + ',HEIGHT=' + height + ',RESIZABLE=' + resize + ',SCROLLBARS=' + bars + ',STATUS=0,LEFT=' + posx + ',TOP=' + posy + 'screenX=' + posx + ',screenY=' + posy;
    	 window.open(url,'Linee Produttive',windowParams);
    	 

    	 
    	
    	   
    	  
    	}
 
   
    function DwrUtilComuni()
	{
    	
    	
    	
    	<%  	
    	if (request.getAttribute("tipoRegistrazione") == null || 
    		!"39".equals((String) request.getAttribute("tipoRegistrazione")))
    	{
				
    	if (request.getAttribute("in_regione")!=null && request.getAttribute("in_regione")!="")
    	{
    		if(request.getParameter("aslAll")==null || request.getParameter("aslAll").equals("no")){
    				if(request.getAttribute("in_regione").equals("si")){    					
%>
						idAsl = document.forms[0].searchcodeIdAsl.value;
						DwrUtil.getValoriComboComuni1Asl(idAsl,setComuniComboCallback) ;
<% 					}else{
%>
					DwrUtil.getValoriComboComuni1AslFuoriRegione('<%=((String)request.getAttribute("in_regione"))%>','<%=((String)request.getAttribute("estero"))%>',setComuniComboCallback) ;
<%
					}
    		}else{
%>
				idAsl = document.forms[0].searchcodeIdAsl.value;
 				DwrUtil.getValoriComboComuni1Asl(idAsl,setComuniComboCallback) ;
<%
    		}
		}
    	else
    	{ 
%>
		  	  idAsl = document.forms[0].searchcodeIdAsl.value;
		 	  DwrUtil.getValoriComboComuni1Asl(idAsl,setComuniComboCallback) ;
<% 
		}
    	}
%>
		
	}

    function DwrUtilAsl()
	{
    	alert('<%=request.getAttribute("tipoRegistrazione")%>');

				
    	idComune = document.forms[0].searchcodeIdComuneStabilimento.value;
		DwrUtil.getValoriAsl(idComune,setAslComboCallback) ;
	
	}   
	
    function setAslComboCallback(returnValue)
    {

       
  	  var select = document.forms[0].searchcodeIdAsl; //Recupero la SELECT
       // alert($("#searchcodeIdAsl").attr("type"));

        if ( $("#searchcodeIdAsl").attr("type") != "hidden"){ //Se ho la combo delle asl

        //Azzero il contenuto della seconda select
        for (var i = select.length - 1; i >= 0; i--)
      	  select.remove(i);

        indici = returnValue [0];
        valori = returnValue [1];
        //Popolo la seconda Select
        for(j =0 ; j<indici.length; j++){
        //Creo il nuovo elemento OPTION da aggiungere nella seconda SELECT
        var NewOpt = document.createElement('option');
        NewOpt.value = indici[j]; // Imposto il valore
        NewOpt.text = valori[j]; // Imposto il testo

        //Aggiungo l'elemento option
        try
        {
      	  select.add(NewOpt, null); //Metodo Standard, non funziona con IE
        }catch(e){
      	  select.add(NewOpt); // Funziona solo con IE
        }
        }
        var NewOpt = document.createElement('option');
        NewOpt.value = '-1'; // Imposto il valore
        NewOpt.text = 'Seleziona'; // Imposto il testo
        try
        {
      	  select.add(NewOpt, null); //Metodo Standard, non funziona con IE
        }catch(e){
      	  select.add(NewOpt); // Funziona solo con IE
        }
        }

    }

      function setComuniComboCallback(returnValue)
      {

        
    	  var select = document.forms[0].searchcodeIdComuneStabilimento; //Recupero la SELECT
          

          //Azzero il contenuto della seconda select
          for (var i = select.length - 1; i >= 0; i--)
        	  select.remove(i);

          indici = returnValue [0];
          valori = returnValue [1];
          //Popolo la seconda Select
          for(j =0 ; j<indici.length; j++){
          //Creo il nuovo elemento OPTION da aggiungere nella seconda SELECT
          var NewOpt = document.createElement('option');
          NewOpt.value = indici[j]; // Imposto il valore
          NewOpt.text = valori[j]; // Imposto il testo

          //Aggiungo l'elemento option
          try
          {
        	  select.add(NewOpt, null); //Metodo Standard, non funziona con IE
          }catch(e){
        	  select.add(NewOpt); // Funziona solo con IE
          }
          }
          
          
          var options = $('#searchcodeIdComuneStabilimento option');
          var arr = options.map(function(_, o) {
              return {
                  t: $(o).text(),
                  v: o.value
              };
          }).get();
          arr.sort(function(o1, o2) {
              return o1.t > o2.t ? 1 : o1.t < o2.t ? -1 : 0;
          });
          options.each(function(i, o) {
              console.log(i);
              o.value = arr[i].v;
              $(o).text(arr[i].t);
          });
          
          
          var NewOpt = document.createElement('option');
          NewOpt.value = '-1'; // Imposto il valore
          NewOpt.text = 'Seleziona'; // Imposto il testo
          try
          {
        	  select.add(NewOpt, null); //Metodo Standard, non funziona con IE
          }catch(e){
        	  select.add(NewOpt); // Funziona solo con IE
          }


      }
   
      (function( $ ) {
          $.widget( "ui.combobox", {
             
              _create: function() {
          	 var element = this.element;
                  var input,  
                      that = this,
                      select = this.element.hide(),
                    
                  
                      selected = select.children( ":selected" ),
                      value = selected.val() ? selected.text() : "",
                      wrapper = this.wrapper = $( "<span>" )
                          .addClass( "ui-combobox" )
                          .insertAfter( select );
   
                  function removeIfInvalid(element) {
                      var value = $( element ).val(),
                          matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( value ) + "$", "i" ),
                          valid = false;
                      select.children( "option" ).each(function() {
                          if ( $( this ).text().match( matcher ) ) {
                              this.selected = valid = true;
                              return false;
                          }
                      });
                      if ( !valid ) {
                          // remove invalid value, as it didn't match anything
                          $( element )
                              .val( "" )
                              .attr( "title", value + " Nessun Elemento Trovato" )
                              .tooltip( "open" );
                          select.val( "" );
                          setTimeout(function() {
                              input.tooltip( "close" ).attr( "title", "" );
                          }, 2500 );
                          input.data( "autocomplete" ).term = "";
                          return false;
                      }
                  }
   
                  input = $( "<input>" )
                      .appendTo( wrapper )
                      .val( value )
                      .attr( "title", "" )
                      .addClass( "ui-state-default ui-combobox-input" )
                      .autocomplete({
                          delay: 0,
                          minLength: 0,
                          source: function( request, response ) {
                              var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
                              response( select.children( "option" ).map(function() {
                                  var text = $( this ).text();
                                  if ( this.value && ( !request.term || matcher.test(text) ) )
                                      return {
                                          label: text.replace(
                                              new RegExp(
                                                  "(?![^&;]+;)(?!<[^<>]*)(" +
                                                  $.ui.autocomplete.escapeRegex(request.term) +
                                                  ")(?![^<>]*>)(?![^&;]+;)", "gi"
                                              ), "<strong>$1</strong>" ),
                                          value: text,
                                          option: this
                                      };
                              }) );
                          },
                          select: function( event, ui ) {
                              ui.item.option.selected = true;
                              that._trigger( "selected", event, {
                                  item: ui.item.option
                              });
                          },
                          change: function( event, ui ) {
                           
                              if ( !ui.item )
                                  return removeIfInvalid( this );
  							if(ui.item)
  							{
  								if(select[0].id=='searchcodeIdAsl')
  								{
  									DwrUtilComuni();

  								}
  								if(select[0].id=='searchcodeIdComuneStabilimento')
  								{

  									 if ( $("#searchcodeIdAsl").attr("type") != "hidden"){ //Se ho la combo delle asl
  											DwrUtilAsl();
  									 }

  								}
  								
  								
  							}
                              
                          }
                      })
                      .addClass( "ui-widget ui-widget-content ui-corner-left" );
   
                  input.data( "autocomplete" )._renderItem = function( ul, item ) {
                      return $( "<li>" )
                          .data( "item.autocomplete", item )
                          .append( "<a>" + item.label + "</a>" )
                          .appendTo( ul );
                  };
   
                  $( "<a>" )
                      .attr( "tabIndex", -1 )
                     
                      .tooltip()
                      .appendTo( wrapper )
                      .button({
                          icons: {
                              primary: "ui-icon-triangle-1-s"
                          },
                          text: false
                      })
                      .removeClass( "ui-corner-all" )
                      .addClass( "ui-corner-right ui-combobox-toggle" )
                      .click(function() {
                          // close if already visible
                          if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
                              input.autocomplete( "close" );
                              removeIfInvalid( input );
                              return;
                          }
   
                          // work around a bug (likely same cause as #5265)
                          $( this ).blur();
   
                          // pass empty string as value to search for, displaying all results
                          input.autocomplete( "search", "" );
                          input.focus();
                      });
   
                      input
                          .tooltip({
                              position: {
                                  of: this.button
                              },
                              tooltipClass: "ui-state-highlight"
                          });
              },
   
              destroy: function() {
                  this.wrapper.remove();
                  this.element.show();
                  $.Widget.prototype.destroy.call( this );
              }
          });
      })( jQuery );
      
    $(function() {
       // $( "#searchcodeIdComuneStabilimento" ).combobox();

        if ( $("#searchcodeIdAsl").attr("type") != "hidden"){
           // alert("combo");
       		 $( "#searchcodeIdAsl" ).combobox();
        }

       
    });
    </script>
<script language="JavaScript">
  function clearForm() {
    <%-- Account Filters --%>
    document.forms[0].searchRagioneSociale.value="";
    document.forms[0].CodiceFiscale.value="";
    document.forms[0].PartitaIva.value = '';
	
	i=1 ;

	//alert(document.getElementById('idLineaProduttiva1').value);

	

	while(document.getElementById('idLineaProduttiva'+i)!=null)
	{
				document.getElementById('desc'+i).innerHTML= "";
		
		document.getElementById('idLineaProduttiva'+i).value= "-1";
		document.getElementById('descrizioneLineaProduttiva'+i).value= "-1";
		document.getElementById('idLineaProduttiva').parentNode.removeChild(document.getElementById('descrizioneLineaProduttiva'+i));
	  	document.getElementById('idLineaProduttiva').parentNode.removeChild(document.getElementById('idLineaProduttiva'+i));

				i++ ;
	}
	

	
	
	
      }



  function doCheck(form) {

	  select = true ;

	  
	  
	  return select;
  }
	  
	     
	 
	
</script>

<body onLoad="">

	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td>
				<%
					String label = (request.getAttribute("TipologiaSoggetto") != null) ? "opu.operatore.intestazione_"
							+ (String) request.getAttribute("TipologiaSoggetto") : "opu.operatore.intestazione";
				%> <dhv:label name="<%=label%>"></dhv:label> > <dhv:label name="">Ricerca </dhv:label>
			</td>
		</tr>
	</table>
	<%-- End Trails --%>


	<form name="searchOperatoreNegozioFuoriRegione"
		action="OperatoreAction.do?command=SearchOperatoreNegozioFuoriRegione<%=addLinkParams(request, "popup|popupType|actionId")%>"
		method="post">
		<input type="hidden" name="tipologiaSoggetto"
			value="<%=(request.getAttribute("TipologiaSoggetto") != null) ? (String) request
					.getAttribute("TipologiaSoggetto") : ""%>">
		<input type="hidden" name="idLineaProduttiva1"
			value="<%=(request.getAttribute("idLineaProduttiva1") != null) ? (String) request
					.getAttribute("idLineaProduttiva1") : ""%>">
		<input type="hidden" name="aslAll" id="aslAll"
			value="<%=(request.getParameter("aslAll") != null)
					? (String) request.getParameter("aslAll")
					: ""%>">

		<%
			if (request.getAttribute("in_regione") == null || ((String) request.getAttribute("in_regione")).equals("")
					|| ((String) request.getAttribute("in_regione")).equals("si")) {
		%>
		<input type="hidden" id="in_regione" name="in_regione"
			value='<%=(String) request.getAttribute("in_regione")%>' />
		<%
			}
		%>

		<table cellpadding="2" cellspacing="2" border="0" width="100%">
			<tr>
				<td width="50%" valign="top">
					<table cellpadding="4" cellspacing="0" border="0" width="100%"
						class="details">
						<tr>
							<th colspan="2"><strong><dhv:label
										name="opu.stabilimento.linea_produttiva"></dhv:label></strong></th>
						</tr>
							<tr>
								<td class="formLabel"><dhv:label name="opu.stabilimento.comune"></dhv:label></td>
								<td>
										<%=ComuniList.getHtmlSelect("searchcodeIdComuneStabilimento", SearchOrgListInfo.getSearchOptionValue("searchcodeIdComuneStabilimento"))%>
								</td>
							</tr>
			
					</table>
		<input type="hidden" name="doContinue" id="doContinue" value="">
		<input type="hidden" name="popup" id="popup" value=""> <input
			type="button" onclick="if(doCheck(this.form)){this.form.submit()};"
			value="<dhv:label name="button.search">Search</dhv:label>">
		<%
			if (request.getParameter("idLineaProduttiva1") == null) {
		%>
		<input type="button"
			value="<dhv:label name="button.clear">Clear</dhv:label>"
			onClick="javascript:clearForm();">
		<%
			}
		%>
		<input type="hidden" name="source" value="searchForm">
	</form>





</body>

<script>
	if (document.getElementById('searchcodeIdComuneStabilimento') != null) {
<%if (request.getAttribute("in_regione") != null && request.getAttribute("in_regione") != "") {%>
	DwrUtilComuni();
<%}%>
	}

	function pulisciCampo(input) {
		//Inserire le prime 4 lettere

		if (input.value == 'Cognome,Nome o solo Cognome') {
			input.value = '';
		}
	}
	function ripristinaCampo(input) {
		if (input.value == '') {
			input.value = 'Cognome,Nome o solo Cognome';
		}
	}
</script>

