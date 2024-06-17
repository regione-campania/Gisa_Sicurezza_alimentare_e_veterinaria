<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<center>
	<input type="hidden" id="stabId" value="${stabId}"> 
	<input type="hidden" id="altId" value="${altId}"> 
	<input type="hidden" id="flagApicoltura" value="${flagApicoltura}">
	<input type="hidden" id="numeroPratica" value="${numeroPratica}"> 
	<input type="hidden" id="tipoPratica" value="${tipoPratica}"> 
	<input type="hidden" id="dataPratica" value="${dataPratica}">
	<input type="hidden" id="tipo_output" value="${tipo_output}">
	<input type="hidden" id="comunePratica" value="${comunePratica}">
	<input type="hidden" id="causalePratica" value="1">
</center>


<script>

  var stabId = document.getElementById("stabId").value; 
  var altId = document.getElementById("altId").value; 
  var flagApicoltura = document.getElementById("flagApicoltura").value;
  var numeroPratica = document.getElementById("numeroPratica").value; 
  var tipoPratica = document.getElementById("tipoPratica").value; 
  var dataPratica = document.getElementById("dataPratica").value;
  var tipo_output = document.getElementById("tipo_output").value;
  var comunePratica = document.getElementById("comunePratica").value;
  var causalePratica = document.getElementById("causalePratica").value;
 
  
 if (tipo_output == '3' && flagApicoltura != '1'){
	  loadModalWindowCustom('ATTENDERE PREGO');
	  window.location.href='GestionePraticheAction.do?command=ListaPraticheStabilimenti';
  } else if (tipo_output == '3' && flagApicoltura == '1'){
	  loadModalWindowCustom('ATTENDERE PREGO');
	  window.location.href='GestionePraticheAction.do?command=ListaPraticheApicoltura';
  } else if(tipo_output == '1' && flagApicoltura == '1'){ 
	  //se salva e continua e pratica apicoltura si passa a scheda di inserimento OSA
	  //inserisci osa ex novo
	  loadModalWindowCustom('ATTENDERE PREGO');
	  var link = 'GestioneAnagraficaAction.do?command=Choose&numeroPratica='+numeroPratica
			  												+'&tipoPratica='+tipoPratica
			  												+'&dataPratica='+dataPratica
			  												+'&comunePratica='+comunePratica
			  												+'&causalePratica='+causalePratica
			  												+'&apicoltura=1';
	  window.location.href=link;
  } else if(flagApicoltura != '1'){
	  
	  if(tipoPratica == '1'){
		  //inserisci osa ex novo
		  loadModalWindowCustom('ATTENDERE PREGO');
		  var link = 'GestioneAnagraficaAction.do?command=Choose&numeroPratica='+numeroPratica+'&tipoPratica='+tipoPratica+'&dataPratica='+dataPratica+'&comunePratica='+comunePratica+'&causalePratica='+causalePratica;
		  window.location.href=link;
	  } else {
		  //vai a maschera per ricerca/selezione osa
		 loadModalWindowCustom('ATTENDERE PREGO');
		  var link = 'GestioneAnagraficaAction.do?command=GestioneGisaDellaPratica&numeroPratica='+numeroPratica+'&tipoPratica='+tipoPratica
				  		+'&dataPratica='+dataPratica+'&comunePratica='+comunePratica+'&causalePratica='+causalePratica+'&altId='+altId;
		  window.location.href=link;
	  }
	  
  }

  
  
  

</script>