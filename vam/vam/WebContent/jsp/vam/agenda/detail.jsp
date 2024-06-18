	<link rel='stylesheet' type='text/css' href='js/vam/agenda/reset.css' />
	<link rel='stylesheet' type='text/css' href='js/vam/agenda/jquery.weekcalendar.css' />
		
	<script type='text/javascript' src='js/jquery/jquery-1.3.2.min.js'></script>
	<script type='text/javascript' src='js/jquery/jquery-ui-1.7.3.custom.min.js'></script>
	<script type='text/javascript' src='js/vam/agenda/jquery.weekcalendar.js'></script>
	
	<link rel='stylesheet' type='text/css' href='js/vam/agenda/calendar-us.css' />
	<script type='text/javascript' src='js/vam/agenda/calendar-us.js'></script> 
			
	<h1>Prenotazione ${sc.denominazione}</h1>				
	<div id='calendar'></div>
	<div id="event_edit_container">
<!--		<form action="vam.agenda.AddBooking.us" name="form" method="post" class="marginezero">-->
				
		<form  name="form" method="post" class="marginezero">
			<input type="hidden" />	
			<input type="hidden" value="${idStrutturaClinica}"/>				
			<ul>
				<li>
					<span>Data: </span><span class="date_holder"></span> 
				</li>
				<li>
					<label for="start">Inizio prenotazione: </label><select name="start"></select>
				</li>
				<li>
					<label for="end">Fine prenotazione: </label><select name="end"></select>
				</li>
				<li>
					<label for="title">Motivo: </label><input type="text" name="title" />
				</li>
				<li>
					<label for="body">Descrizione: </label><textarea name="body"></textarea>
				</li>
			</ul>
		</form>
	</div>
	
	