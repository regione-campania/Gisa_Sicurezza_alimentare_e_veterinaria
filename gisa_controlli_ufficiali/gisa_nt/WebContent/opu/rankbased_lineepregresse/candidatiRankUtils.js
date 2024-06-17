function mostra_candidati_rank(nometab_ranks, nometab_sceltadazero , id_linea_associata,checkboxCandidati,indiceSequenzialeVecchiaLinea,tipoInserimento)
{

	
	//$("input#validatelp").val("true"); //sicuramente non potro' proseguire
	//svuoto la tabella eliminan le righe
	$("table#"+nometab_ranks+" tr").remove();
	//per i candidati
	
	
	 
	if(checkboxCandidati.checked)
	{
		var candidati = candidatiPerIdLineeFittizie[id_linea_associata];
		for(var i = 0; i< candidati.length; i++ )
		{
		 
			inserisciEntryCandidatoInMaschera(nometab_ranks,id_linea_associata,candidati[i],i,tipoInserimento);
			
		}
		
		
		
		
		if(candidati.length > 0)
		{
			
			//aggiungo righe per scelta campi aggiuntivi
			$("table#"+nometab_ranks).append(
					 
					"<tr name=\"tr_path_aggiuntivo\" ></tr>"+
					"<tr name=\"tr_select_aggiuntivi\" ></tr>"
					
			);
			//e oscuro la tabella della scelta da zero
			nascondiTabSceltaDaZeroEModificaNomiDateField(nometab_ranks, nometab_sceltadazero , id_linea_associata,checkboxCandidati,indiceSequenzialeVecchiaLinea);
			
			
			//dopo aver aggiunto il nuovo input, controllo
			//se è possibile sbloccare il salvataggio, (affinchè possa essere fatto, occorre che ci sia un numero di input con nome idLineaProduttiva pari al totale delle linee arrivate dal server)
			
			/*if($("input[name=numeroLinee]").val() ==$("input[name=idLineaProduttiva]").length)
			{
				$("input#validatelp").val("true"); //in questo modo non ci sarà bisogno di specificare fino al terzo livello per quella linea	
			}*/
			

		}				
	}
	else
	{
		
		
		riempiTabSceltaDaZeroENascondiRankingERisettaDate(nometab_ranks, nometab_sceltadazero , id_linea_associata,checkboxCandidati,indiceSequenzialeVecchiaLinea);
		
		
	}
	
	console.log("elimino bottone elimina");
	 
	 
	
}


 


var infosAggiuntiviCandidatoLineaVecchia = 
{ //la chiave è id linea vecchia, il valore associato è un oggetto { idlineaattivita_IIIlivello_candidato : idcandidatoIIIlivello,
		 														//    dati: { lvlAggiuntivoRaggiunto : , pathAccumulato : } }	
};




function ottieniSoloAttivitaProduttiveOltreTerzoLivello(nomeTabella,livello,idvecchialinea,idcandidatoIIILiv,idSelezionato,tipoInserimento,nomeradioinput)
{
	var idTipoAttivita = -1 ;
	if (document.getElementById("tipoAttivita")!=null)
		 idTipoAttivita = document.getElementById("tipoAttivita").value;
	
	SuapDwr.mostraAttivitaProduttive(livello,idSelezionato,tipoInserimento,idTipoAttivita,-1,{async:false,callback:
		
		function(attivita)
		{
			 
			/*if(livello > 4 && livello < 7 )
				attivita.listaItem.push( {id : '1111', descrizione :'dummy'+livello } );*/
			
			if(attivita.listaItem.length > 1) //1 perchè c'e' sempre una dummy label inserita dal server
			{
				$("input#validatelp").val("false"); //sicuramente non potro' proseguire
				preparaPerRiempimentoCampiSceltaLivelliAggiuntiviRanked(nomeTabella,idvecchialinea,idcandidatoIIILiv)
				//svuoto la select
				$("table#"+nomeTabella+" select[name='select_agg']").html("");
				//la riempio
				//metto etichetta "sceglimi"
				$("table#"+nomeTabella+" select[name='select_agg']").append(
						$("<option>",{
	 							value : -1,
	 							text : 'scegli valore'
								}
						)
				);
				
				
				
				for (i=0;i<attivita.listaItem.length;i++)
		  		{
					if(attivita.listaItem[i].descizione == undefined || attivita.listaItem[i].descizione.trim() == '') 
						continue; //perchè questa è una dummy del tipo "scegliere valore" inserita dal server, mentre io usero' la mia dummy label, quindi questa la salto
					
					$("table#"+nomeTabella+" select[name='select_agg']").
							append(
							$('<option>',{
										value : attivita.listaItem[i].id,
										text : attivita.listaItem[i].descizione.toUpperCase()
										  }
							));
		  		}
				
				//metto handler sulla selezione 
				$("table#"+nomeTabella+" select[name='select_agg']").change(
						function()
						{
							
							var idNuovoScelto = $(this).val();
							var textLab = $(this).find("option:selected").text();
							console.log(idNuovoScelto + " " + textLab);
							
							if(idNuovoScelto == '-1')
								return;
							
							//aggiorno i dati nella struttura
							infosAggiuntiviCandidatoLineaVecchia[idvecchialinea].dati.lvlAggiuntivoRaggiunto = livello;
							var vecchioPath = infosAggiuntiviCandidatoLineaVecchia[idvecchialinea].dati.pathRaggiunto;
							
							infosAggiuntiviCandidatoLineaVecchia[idvecchialinea].dati.pathRaggiunto = vecchioPath + ( (vecchioPath != "-") ? "-" : "") + textLab;
							//aggiorno la gui
							$("table#"+nomeTabella+" span[name='span_path_aggiuntivo']").html("<B>LIVELLI AGGIUNTIVI: </B>"+infosAggiuntiviCandidatoLineaVecchia[idvecchialinea].dati.pathRaggiunto);
							
							
							//lancio richiesta per aggiornamento livello successivo
							ottieniSoloAttivitaProduttiveOltreTerzoLivello(nomeTabella,livello+1,idvecchialinea,idcandidatoIIILiv,idNuovoScelto,tipoInserimento,nomeradioinput);
						}
				
				);
				
				
			}
			else
			{	
				//ho terminato il ramo
				
				
				/*if($("table#"+nomeTabella+" input[type='hidden'][name='idLineaProduttiva']").length == 0)
				{ //solo se non era stato già creato
				*/
					$("table#"+nomeTabella).append("<tr>"+
		 				"<input type=\"hidden\" name= \"idLineaProduttiva\" value= \"-1\" />"+
		 				"</tr>"); // come id della linea scelta -1 (in questo modo il server sa che non va inserita questa linea) poichè viene usato un candidato
				/*}*/		
				
				
				
				
				if(livello > 4) //livello è quello per cui ho fatto la query, quindi se livello è = 4, allora il ramo si esaurisce al terzo ilvelilo quindi non devo farci niente
				{//altrimenti se livello > 4 --aggiorno il valore dell'input del ranked scelto che arriverà (metto id foglia invece del terzo livello)
					
					$("table#"+nomeTabella+" select[name='select_agg']").remove(); //rimuovo la select
					 
					 
					
					//aggiorno l'id che arriverà al server
					$("table#"+nomeTabella+" input[name='"+nomeradioinput+"']:checked").val(idSelezionato); 
					//se sono arrivato alla fine del ramo, ed ero almeno un livello oltre il terzo, nascondo solo la select per la scelta dei livelli aggiuntivi
					//ma non il bottone annulla nè quello che mostra il path accumulato
					
					//il bottone annulla viene spostato sopra
					var bottone0 = $("table#"+nomeTabella+" tr[name='tr_select_aggiuntivi'] button[name='btn_annulla_agg']");
					bottone0.detach();
					bottone0.appendTo($("table#"+nomeTabella+" tr[name='tr_path_aggiuntivo'] td").append("&nbsp;"));
				}
				else
				{
					//se sono arrivato alla fine del ramo, senza neanche un livello aggiuntivo
					//metto un messaggio al path
					$("table#"+nomeTabella+" tr[name='tr_path_aggiuntivo']").html("<td colspan=\"5\"><span name=\"span_path_aggiuntivo\"><i>NON SONO RICHIESTI LIVELLI AGGIUNTIVI</i></span></td>");
					//allora nascondo i bottoni annulla e select per il candidato
					$("table#"+nomeTabella+" tr[name='tr_select_aggiuntivi']").html(""); //levo la riga contenente la select e l'annulla 
				}
				
				//PARTE DEI CAMPI ESTESI
				
				$("table#"+nomeTabella+" tr:last").after(
						$("<tr></tr>").attr("id","id_tr_campi_estesi_"+idvecchialinea+"-"+idcandidatoIIILiv).addClass("tr_campi_estesi")
						.html(
								 
									$("<td></td>").html(
												
												$("<table></table>").attr("id","id_table_campi_estesi_"+idvecchialinea+"-"+idcandidatoIIILiv)
												.html($("<tr style=\"display:none\"><td>&nbsp;</td></tr>")) 
												
									)
								 
						)
				); 
				
				
				//NB ovviamente l'id passato come primo parametro per la ricerca dei campi estesi
				//e' quello dell'ultimo livello foglia, non del terzo 
				aggiungiCampiEstesi({idAttivita : idSelezionato},"id_table_campi_estesi_"+idvecchialinea+"-"+idcandidatoIIILiv,{
					callback_terminazione : function()
					{
						//se la tabella campi estesi non è stata popolata (perchè non ce ne sono) la elimino
						if($("table#id_table_campi_estesi_"+idvecchialinea+"-"+idcandidatoIIILiv+" tr").length == 1) //se c'e' quindi solo la dummy row
						{
							$("table#"+nomeTabella+" tr#id_tr_campi_estesi_"+ idvecchialinea+"-"+idcandidatoIIILiv).remove();
						}
					}
				});
				
				
				//FINE PARTE DEI CAMPI ESTESI
				
				
				if($("input[name=numeroLinee]").val() ==$("input[name=idLineaProduttiva]").length)
				{
					$("input#validatelp").val("true"); //in questo modo non ci sarà bisogno di specificare fino al terzo livello per quella linea	
					console.log("VALIDATELP ATTIVATO");
				}
				
				 
				
				
				
			}
		
			
		
		
		
		}});
}




function preparaPerRiempimentoCampiSceltaLivelliAggiuntiviRanked(nometab_ranks,idvecchialineaI,idcandidatoIIIliv)
{
	var pathPregresso = "";
	try
	{
		pathPregresso = infosAggiuntiviCandidatoLineaVecchia[idvecchialineaI].dati.pathRaggiunto;
		console.log("path preg"+pathPregresso);
	}
	catch(ecc)
	{
		pathPregresso = "";
	}
	console.log("path preg"+pathPregresso);
	
	$("table#"+nometab_ranks+" tr[name='tr_path_aggiuntivo']").html("<td colspan=\"5\"><span style=\"background-color: rgba(20,255,20,0.5)\" name=\"span_path_aggiuntivo\">"+(pathPregresso.length > 0 ? pathPregresso+"<br>" : "")+"<i>LIVELLI AGGIUNTIVI RICHIESTI...</i></span></td>"); 
	$("table#"+nometab_ranks+" tr[name='tr_select_aggiuntivi']").html("<td colspan = \"5\" ><select name=\"select_agg\"></select><button type=\"button\" name=\"btn_annulla_agg\">ANNULLA</button></td>");
	
	//posso mettere l'handler sul bottone annulla già da qui
	$("table#"+nometab_ranks).on("click"," button[name='btn_annulla_agg']",{ nometab : nometab_ranks , idvecchialinea : idvecchialineaI , idcandidatoIIIlivello : idcandidatoIIIliv },clickBtnAnnulla);

}

function clickBtnAnnulla(evento)
{
	var nomeTab = evento.data.nometab;
	var idcandIII = evento.data.idcandidatoIIIlivello;
	
	
	
	$("table#"+nomeTab+" input[type='hidden'][name='idLineaProduttiva']").remove();
	//setto a false la possibilità di proseguire
	$("input#validatelp").val("false");
	//elimino l'entry nella struttura dati
	delete infosAggiuntiviCandidatoLineaVecchia[evento.data.idvecchialinea];
	//risimulo il check su quello che era il candidato già attualmente selezionato, questo lo farà resettare
	
	console.log(nomeTab+" "+idcandIII); 
	 
	$("table#"+nomeTab+" input#"+evento.data.idvecchialinea+"-"+idcandIII+"[type='radio']:checked").trigger("click");
	//risetto come value del radio button il valore del candidato del III livello (in realtà non serve a nulla poichè verrà di nuovo risovrascritto, ma per un fatto di pulizia...)
	$("table#"+nomeTab+" input#"+evento.data.idvecchialinea+"-"+idcandIII+"[type='radio']:checked").val(idcandIII);
	 
	//cancello la riga che contiene la tabella in cui avrei dovuto mettere i campi estesi
	$("table#"+nomeTab+" tr#id_tr_campi_estesi_"+evento.data.idvecchialinea+"-"+idcandIII).remove();
	 
	
}

function candidatoScelto(nometab_ranks,idLineaOrg,idLineaIIILivelloCandidato,tipoInserimento,nomeradioinput)
{
	 
	 console.log(infosAggiuntiviCandidatoLineaVecchia);
	 if(infosAggiuntiviCandidatoLineaVecchia[idLineaOrg] != undefined )
	 {
		 
		 var idCandidatoPrecedente = infosAggiuntiviCandidatoLineaVecchia[idLineaOrg].idlineaattivita_IIIlivello_candidato;
		 if( idLineaIIILivelloCandidato === idCandidatoPrecedente)
		 {
			 console.log("hai riscelto stesso candidato per stessa linea vecchia, non faccio nulla !");
			 return;
		 }
		
	 }
	 
	 
	
	console.log("candidato nuovo !");
	//cancello la riga che contiene la tabella in cui avrei dovuto mettere i campi estesi
	$("table#"+nometab_ranks+" tr.tr_campi_estesi").remove();
	
	$("table#"+nometab_ranks+" input[type='hidden'][name='idLineaProduttiva']").remove();
	
	infosAggiuntiviCandidatoLineaVecchia[idLineaOrg] = {
			
			idlineaattivita_IIIlivello_candidato : idLineaIIILivelloCandidato,
			dati : {lvlAggiuntivoRaggiunto : 3 , pathRaggiunto : ""}
		
	}; 
	
	console.log(infosAggiuntiviCandidatoLineaVecchia[idLineaOrg].idlineaattivita_IIIlivello_candidato);
	//resetto il contenuto delle righe per scelta livelli aggiuntivi e display path
	//preparaPerRiempimentoCampiSceltaLivelliAggiuntiviRanked(nometab_ranks,idLineaOrg,idLineaIIILivelloCandidato);
	
	
	//mando richiesta per ottenere linee oltre il terzo livello
	ottieniSoloAttivitaProduttiveOltreTerzoLivello(nometab_ranks,4,idLineaOrg,idLineaIIILivelloCandidato,idLineaIIILivelloCandidato,tipoInserimento,nomeradioinput);
	
	//cambio opacity a seconda che sia quella selezionata o meno
	$("table#"+nometab_ranks+" tr.trEntryCandidato").css("opacity",0.5);
	$("table#"+nometab_ranks+" tr.trEntryCandidato").css("background-color","#ffffff");
	$("table#"+nometab_ranks+" tr#trPerEntryCandidato"+idLineaOrg+"-"+idLineaIIILivelloCandidato).css("opacity","1.0");
	$("table#"+nometab_ranks+" tr#trPerEntryCandidato"+idLineaOrg+"-"+idLineaIIILivelloCandidato).css("background-color","rgba(20,255,20,0.5");
	 
	
	  
}

function inserisciEntryCandidatoInMaschera(nometab_ranks,id_linea_associata,candidato,indiceCandidato,tipoInserimento)
{
	
	$("table#"+nometab_ranks).append(
	 "<tr class=\"trEntryCandidato\" id=\"trPerEntryCandidato"+id_linea_associata+"-"+candidato.idLinea+"\" style=\"opacity:0.5\" >"
		+"<td><b>MACROAREA</b>: "+candidato.macroarea+"</td>"
		+"<td><b>AGGREGAZIONE</b>: "+candidato.aggregazione+"</td>"
		+"<td><b>ATTIVITA</b>: "+candidato.attivita+"</td>"
		+"<td>&nbsp;</td>"
		+"<td><input id=\""+id_linea_associata+"-"+candidato.idLinea+"\" type=\"radio\" name=\"candidato-"+id_linea_associata+"\" value =\""+candidato.idLinea+"\" " + ( (indiceCandidato==0) ? "checked" : "" )  +" /></td>"
	+"</tr>"
	);
	
	//registro handler per il cambio del radio button
	$("table#"+nometab_ranks+" input#"+id_linea_associata+"-"+candidato.idLinea+"[type='radio'][name='candidato-"+id_linea_associata+"']").click(
			function(event)
			{
				candidatoScelto(nometab_ranks,id_linea_associata,candidato.idLinea,tipoInserimento,'candidato-'+id_linea_associata);
			}
	);
	if(indiceCandidato==0)
	{
		console.log(indiceCandidato+"entro per --->" +candidato.idLinea);
		setTimeout(function(){
			$("table#"+nometab_ranks+" input#"+id_linea_associata+"-"+candidato.idLinea+"[type='radio'][name='candidato-"+id_linea_associata+"']").trigger("click");
		},500);
		
	}
	 


}



function nascondiTabSceltaDaZeroEModificaNomiDateField(nometab_ranks, nometab_sceltadazero , id_linea_associata,checkboxCandidati,indiceSequenzialeVecchiaLinea)
{
	//document.querySelector("table#"+nometab_sceltadazero).style.display = 'none';
	//la tabella originale dovrebbe contenere un hidden input con l'id della foglia scelta da zero
	//questo id è necessario, poichè la pagina prosegue solo se si è arrivati al livello finale per ogni linea, in quanto arrivando
	//al livello finale, viene settato l'id linea produttiva
	$("table#"+nometab_sceltadazero).html(""); //la svuoto 
	
	
	console.log($("table#"+nometab_ranks).closest("tr").siblings(":has(td.formLabel)").find("td.formLabel"));
	$("table#"+nometab_ranks).closest("tr").siblings(":has(td.formLabel)").find("td.formLabel").html(""); //levo l'etichetta LINEA
	$("table#"+nometab_ranks).closest("tr").siblings(":has(td.formLabel)").find("td.formLabel").css("display","none");
	/*
	//e cambio i nomi degli input della data cessazione/inizio, facendogli contenere non più l'indice sequenziale della linea
	//ma un identificativo della linea vecchia
	var vecchioNameData = indiceSequenzialeVecchiaLinea == 0 ? 'dataInizioLinea' : 'dataInizioLinea'+indiceSequenzialeVecchiaLinea; // se è la 0esima, è la principale e il nome dell'input da cambiare non concatena l'indice
	var nuovoNameData = "dataInizioLineaRankedAssociatoIdVecchia"+id_linea_associata;
	//allora il nome dell'input della data è dataInizioLineaRankedAssociatoIdVecchia concatenato all'id della vecchia linea (non l'indice sequenziale)
	//document.forms[0].elements[nomeDataAssociata].name = 'dataInizioLineaRankedAssociatoIdVecchia'+id_linea_associata;
	$("input[name='"+vecchioNameData+"']").attr("name",nuovoNameData);
	//inoltre setto come classe delle date il valore del vecchio nome, cosi' che possano essere risettate in "bulk"
	$("input[name='"+nuovoNameData+"']").addClass(vecchioNameData);
	
	//per la data di fine
	vecchioNameData = indiceSequenzialeVecchiaLinea == 0 ? 'dataFineLinea' : 'dataFineLinea'+indiceSequenzialeVecchiaLinea; // se è la 0esima, è la principale e il nome dell'input da cambiare non concatena l'indice
	nuovoNameData = "dataFineLineaRankedAssociatoIdVecchia"+id_linea_associata;
	//document.forms[0].elements[nomeDataFineAssociata].name = 'dataFineLineaRankedAssociatoIdVecchia'+id_linea_associata;
	$("input[name='"+vecchioNameData+"']").attr("name",nuovoNameData);
	$("input[name='"+nuovoNameData+"']").addClass(vecchioNameData);
	*/
	
	

}


function riempiTabSceltaDaZeroENascondiRankingERisettaDate(nometab_ranks, nometab_sceltadazero , id_linea_associata,checkboxCandidati,indiceSequenzialeVecchiaLinea)
{
	
	
	//nel caso in cui viene chiamato per un tab dove già non c'e' unchecked la checkbox che indica di usare il ranked, ritorna semplicemente
	//questo perchè questo metodo potrebbe essere chiamato per tutte le linee vecchie, senza far distinzione
	if(checkboxCandidati.checked)
		return;
	
	 
		
	
	mostraAttivitaProduttive(nometab_sceltadazero,1,-1, false,-1); //questo la fa riempire di nuovo
	$("table#"+nometab_ranks).closest("tr").siblings(":has(td.formLabel)").find("td.formLabel").html("<dhv:label name=\"\">Linea</dhv:label>"); //metto l'etichetta LINEA
	$("table#"+nometab_ranks).closest("tr").siblings(":has(td.formLabel)").find("td.formLabel").removeAttr("style").prop("nowrap");
	//document.querySelector("table#"+nometab_sceltadazero).style.display = 'block';
	//devo eventualmente riaggiustare il nome dell'input di data, ridandogli un nome che concatena dataInizioLinea con l'indice sequenziale della linea
	//document.forms[0].elements['dataInizioLineaRankedAssociatoIdVecchia'+id_linea_associata].name = 'dataInizioLinea'+ (indiceSequenzialeVecchiaLinea == 0) ? "" : indiceSequenzialeVecchiaLinea;
	/*
	var nuovoNome = 'dataInizioLinea' + ( parseInt(indiceSequenzialeVecchiaLinea) == 0 ? '' : indiceSequenzialeVecchiaLinea );
	var vecchioNome = 'dataInizioLineaRankedAssociatoIdVecchia'+id_linea_associata; 
	
		//console.log(nuovoNome);
	$("input[name='"+vecchioNome+"']").attr("name", nuovoNome);
	$("input[name='"+nuovoNome+"']").removeClass(nuovoNome); //elimino la classe che conteneva vecchi onome
	
	//e lo stesso per la data fine
	//document.forms[0].elements['dataFineLineaRankedAssociatoIdVecchia'+id_linea_associata].name = 'dataFineLinea'+ (indiceSequenzialeVecchiaLinea == 0) ? "" : indiceSequenzialeVecchiaLinea;
	nuovoNome = 'dataFineLinea' + ( parseInt(indiceSequenzialeVecchiaLinea) == 0 ? '' : indiceSequenzialeVecchiaLinea );
	vecchioNome = "dataFineLineaRankedAssociatoIdVecchia"+id_linea_associata;
	
	
	$("input[name='"+ vecchioNome + "']").attr("name", nuovoNome);
	$("input[name='"+nuovoNome+"']").removeClass(nuovoNome);
		
	$("input#validatelp").val("false"); //in questo modo non ci sarà bisogno di specificare fino al terzo livello per quella linea
	*/
	//elimino dalla struttura dei livelli aggiuntivi eventuali per i ranked
	delete infosAggiuntiviCandidatoLineaVecchia[id_linea_associata];

}


function resetInBulkTutteLineeCandidatiRanked()
{

	/*
	var numeroLinee = $("input[name='numeroLinee']").val();
	var nomeTabellaNormale;
	var nomeTabellaRanked;
	var checkboxCandidato;
	
	for(var p = 0; p< numeroLinee; p++)
	{
		if(p==0)
		{
			nomeTabellaNormale = 'attprincipale';
			nomeTabellaRanked = 'attprincipale_ranked';
			checkboxCandidato = $("input[name='usa_rank_linea_principale']");
		}
		else 
		{
			 nomeTabellaNormale = 'attprincipale'+p;
			 nomeTabellaRanked = 'attprincipale_ranked'+p;
			 checkboxCandidato = $("input[name='usa_rank_linea-"+p+"']");
		}
		
		riempiTabSceltaDaZeroENascondiRankingERisettaDate(nomeTabellaRanked, nomeTabellaNormale , -1, checkboxCandidato,p);
		
	}*/
	
	$("input[type='checkbox'].checkbox_rank:checked").trigger("click");
	
	
}



 



 $(function()
	 {
			//per tenere nascosti tutti i bottoni elimina (che non dovrebbero mai comparire in questa pagina e che appaiono ogni volta che è chiamata la funzione centralizzata mostralineeattivitaproduttive di suapcittadinoutils.js)
			//devo creare uno stile che si applichi anche agli elementi creati dinamicamente
			if($("head style").length > 0)
			{
				$("head style").append("input[type='button'][value='Elimina']{display:none}"); 
			}
			else
			{
				$("head").append("<style>input[type='button'][value='Elimina']{display:none} </style>"); 
			}
			
			
			//creo un flag per distinguere tra aggiornamento linee pregresse e pratica suap (visto che suapcittadinoutils.js è condiviso)
			window.isAggiornaLineePregresse = true;
			
	 });
