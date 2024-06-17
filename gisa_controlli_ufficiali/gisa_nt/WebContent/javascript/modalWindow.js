
/*  MATTEO CARELLA - modalWindow.js */
/*	locka lo schermo facendo apparire la finestra modale */

function loadModalWindow() {
		// controllo se la finestra modale � nascosta o meno
		document.getElementById('modalWindow').innerHTML="<P><img src=\"gestione_documenti/images/loading.gif\"></P>";
		var currentClass = jQuery('#modalWindow').attr('class'); 
				
		// se lo �, la attivo e disabilito il tasto f5 per il refresh della pagina
		if(currentClass=='unlocked')
		{
			jQuery('#modalWindow').removeClass('unlocked').addClass('locked');
			
			jQuery(document).bind('keydown', function(e){
				if(e.keyCode==116) 
					return false;
			});		
		}
		
	}


function loadModalWindowCustom(messaggio) {
	// controllo se la finestra modale � nascosta o meno
	document.getElementById('modalWindow').innerHTML="<P CLASS='wait'><img src=\"gestione_documenti/images/loading.gif\">"+messaggio+"</P>";
	var currentClass = jQuery('#modalWindow').attr('class'); 
			
	// se lo �, la attivo e disabilito il tasto f5 per il refresh della pagina
	if(currentClass=='unlocked')
	{
		jQuery('#modalWindow').removeClass('unlocked').addClass('locked');
		
		jQuery(document).bind('keydown', function(e){
			if(e.keyCode==116) 
				return false;
		});		
	}
	
}

function loadModalWindowCustom2(messaggio) {
	// controllo se la finestra modale � nascosta o meno
	document.getElementById('modalWindow2').innerHTML="<P CLASS='wait'><img src=\"gestione_documenti/images/loading.gif\"><br>"+messaggio+"</P>";
	var currentClass = jQuery('#modalWindow2').attr('class'); 
			
	// se lo �, la attivo e disabilito il tasto f5 per il refresh della pagina
	if(currentClass=='unlocked')
	{
		jQuery('#modalWindow2').removeClass('unlocked').addClass('locked2');
		
		jQuery(document).bind('keydown', function(e){
			if(e.keyCode==116) 
				return false;
		});		
	}
	
}

function loadModalWindowUnlock2() {
	// controllo se la finestra modale � nascosta o meno
	var currentClass = jQuery('#modalWindow2').attr('class'); 
			
	// se lo �, la attivo e disabilito il tasto f5 per il refresh della pagina
	if(currentClass=='locked2')
	{
		jQuery('#modalWindow2').removeClass('locked2').addClass('unlocked');
		
		jQuery(document).bind('keydown', function(e){
			if(e.keyCode==116) 
				return false;
		});		
	}
	
}

function loadModalWindowUnlock() {
	// controllo se la finestra modale � nascosta o meno
	var currentClass = jQuery('#modalWindow').attr('class'); 
			
	// se lo �, la attivo e disabilito il tasto f5 per il refresh della pagina
	if(currentClass=='locked')
	{
		jQuery('#modalWindow').removeClass('locked').addClass('unlocked');
		
		jQuery(document).bind('keydown', function(e){
			if(e.keyCode==116) 
				return false;
		});		
	}
	
}


function loadModalWindowAutoHide(delay) {
	// controllo se la finestra modale � nascosta o meno
	var currentClass = jQuery('#modalWindow').attr('class'); 
			
	// se lo �, la attivo e disabilito il tasto f5 per il refresh della pagina
	if(currentClass=='unlocked')
	{
		jQuery('#modalWindow').removeClass('unlocked').addClass('locked');
		
		jQuery(document).bind('keydown', function(e){
			if(e.keyCode==116) 
				return false;
		});	
		
		setTimeout(function(){
			jQuery('#modalWindow').removeClass('locked').addClass('unlocked');
		},delay);

		
		
		
		
	}
	
}


function loadModalWindowMiniGuida(messaggio) {
	// controllo se la finestra modale � nascosta o meno
	document.getElementById('modalWindow').innerHTML=messaggio;
	var currentClass = jQuery('#modalWindow').attr('class'); 
			
	// se lo �, la attivo e disabilito il tasto f5 per il refresh della pagina
	if(currentClass=='unlocked')
	{
		jQuery('#modalWindow').removeClass('unlocked').addClass('lockedminiguida');
		
		jQuery(document).bind('keydown', function(e){
			if(e.keyCode==116) 
				return false;
		});		
	}
	
}

function loadModalWindowMiniGuidaUnlock() {
	// controllo se la finestra modale � nascosta o meno
	var currentClass = jQuery('#modalWindow').attr('class'); 
			
	// se lo �, la attivo e disabilito il tasto f5 per il refresh della pagina
	if(currentClass=='lockedminiguida')
	{
		jQuery('#modalWindow').removeClass('lockedminiguida').addClass('unlocked');
		
		jQuery(document).bind('keydown', function(e){
			if(e.keyCode==116) 
				return false;
		});		
	}
	
	
	
}
