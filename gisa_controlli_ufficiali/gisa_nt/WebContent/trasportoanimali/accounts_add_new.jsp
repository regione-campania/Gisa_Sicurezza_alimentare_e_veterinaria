<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.trasportoanimali.base.*,org.aspcfs.utils.web.*,org.aspcfs.modules.contacts.base.*" %>

<%@ include file="../utils23/initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkNumber.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkEmail.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkURL.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/setSalutation.js"></script>

<style type="text/css">
#dhtmltooltip{
position: absolute;
left: -300px;
width: 150px;
border: 1px solid black;
padding: 2px;
background-color: lightyellow;
visibility: hidden;
z-index: 100;
/*Remove below line to remove shadow. Below line should always appear last within this CSS*/
filter: progid:DXImageTransform.Microsoft.Shadow(color=gray,direction=135);
}
#dhtmlpointer{
position:absolute;
left: -300px;
z-index: 101;
visibility: hidden;
}
</style>

<script>
var offsetfromcursorX=12 
var offsetfromcursorY=10 
var offsetdivfrompointerX=10 
var offsetdivfrompointerY=14 
document.write('<div id="dhtmltooltip"></div>') //write out tooltip DIV
document.write('<img id="dhtmlpointer" src="images/arrow2.gif">') //write out pointer image
var ie=document.all
var ns6=document.getElementById && !document.all
var enabletip=false
if (ie||ns6)
var tipobj=document.all? document.all["dhtmltooltip"] : document.getElementById? document.getElementById("dhtmltooltip") : ""
var pointerobj=document.all? document.all["dhtmlpointer"] : document.getElementById? document.getElementById("dhtmlpointer") : ""
function ietruebody(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}
function ddrivetip(thetext, thewidth, thecolor){
if (ns6||ie){
if (typeof thewidth!="undefined") tipobj.style.width=thewidth+"px"
if (typeof thecolor!="undefined" && thecolor!="") tipobj.style.backgroundColor=thecolor
tipobj.innerHTML=thetext
enabletip=true
return false
}
}
function positiontip(e){
if (enabletip){
var nondefaultpos=false
var curX=(ns6)?e.pageX : event.clientX+ietruebody().scrollLeft;
var curY=(ns6)?e.pageY : event.clientY+ietruebody().scrollTop;

var winwidth=ie&&!window.opera? ietruebody().clientWidth : window.innerWidth-20
var winheight=ie&&!window.opera? ietruebody().clientHeight : window.innerHeight-20
var rightedge=ie&&!window.opera? winwidth-event.clientX-offsetfromcursorX : winwidth-e.clientX-offsetfromcursorX
var bottomedge=ie&&!window.opera? winheight-event.clientY-offsetfromcursorY : winheight-e.clientY-offsetfromcursorY
var leftedge=(offsetfromcursorX<0)? offsetfromcursorX*(-1) : -1000

if (rightedge<tipobj.offsetWidth){

tipobj.style.left=curX-tipobj.offsetWidth+"px"
nondefaultpos=true
}
else if (curX<leftedge)
tipobj.style.left="5px"
else{

tipobj.style.left=curX+offsetfromcursorX-offsetdivfrompointerX+"px"
pointerobj.style.left=curX+offsetfromcursorX+"px"
}

if (bottomedge<tipobj.offsetHeight){
tipobj.style.top=curY-tipobj.offsetHeight-offsetfromcursorY+"px"
nondefaultpos=true
}
else{
tipobj.style.top=curY+offsetfromcursorY+offsetdivfrompointerY+"px"
pointerobj.style.top=curY+offsetfromcursorY+"px"
}
tipobj.style.visibility="visible"
if (!nondefaultpos)
pointerobj.style.visibility="visible"
else
pointerobj.style.visibility="hidden"
}
}
function hideddrivetip(){
    if (ns6||ie){
    enabletip=false
    tipobj.style.visibility="hidden"
    pointerobj.style.visibility="hidden"
    tipobj.style.left="-1000px"
    tipobj.style.backgroundColor=''
    tipobj.style.width=''
    }
    }
    document.onmousemove=positiontip
</script>

<form  action="" method="post">
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="TrasportoAnimali.do"><dhv:label name="richieste">Richieste</dhv:label></a> > 
<dhv:label name="">Aggiungi Richiesta</dhv:label>
</td>
</tr>
</table>

<table cellpadding="4" cellspacing="0" border="0" width="50%" class="details">
	<tr width="100%">
		<th>
			<strong>
				<dhv:label name="">Richieste Autorizzazioni</dhv:label>
			</strong>
		</th>
	</tr>
	<tr>		
		<td>
		
			<input
      			type="submit"
      			onmouseover="ddrivetip('<dhv:label name="">Autorizzazione al trasporto TIPO 1, ai sensi del regolamento (CE) 1/2005.</dhv:label>')"
      			onmouseout="hideddrivetip()"
      			name="tipo1"
      			value="AUT. AL TRASPORTO Tipo 1"
      			onclick="javascript:this.form.action='GisaNoScia.do?command=Choose&codice_univoco_ml=TAV-TAV-X'"/>
      	
			<input
      			type="submit"
      			onmouseover="ddrivetip('<dhv:label name="">Autorizzazione al trasporto TIPO 2, ai sensi del regolamento (CE) 1/2005.</dhv:label>')"
      			onmouseout="hideddrivetip()"
      			name="tipo2"
      			value="AUT. AL TRASPORTO Tipo 2"
      			onclick="javascript:this.form.action='GisaNoScia.do?command=Choose&codice_univoco_ml=TAV-TAV-X'"/>
		</td>
	</tr>
	
</table>
<br>
<table cellpadding="4" cellspacing="0" border="0" width="50%" class="details">
	<tr>
		<th>
			<strong>
				<dhv:label name="">Autodichiarazioni</dhv:label>
			</strong>
		</th>
	</tr>
	<tr>
		<td>
			<input
      			type="submit"
      			onmouseover="ddrivetip('<dhv:label name="">Autodichirazione della registrazione come <B>produttore primario</B> ai sensi del Reg. (CE) 852/2004</dhv:label>')"
      			onmouseout="hideddrivetip()"
      			name="tipo3"
      			value="AUTODICHIARAZIONE PROD. PRIMARIO"
      			onclick="javascript:this.form.action='GisaNoScia.do?command=Choose&codice_univoco_ml=TAV-TAV-PR'"/><!-- il seguente codice_univoco-ml � fittizio -->
      			
      		<input
      			type="submit"
      			onmouseover="ddrivetip('<dhv:label name="">Autodichirazione della registrazione come trasportatore <B>conto proprio</B> di equidi</dhv:label>')"
      			onmouseout="hideddrivetip()"
          		name="tipo4"
      			value="AUTODICHIARAZIONE TRASP. EQUIDI"
      			onclick="javascript:this.form.action='GisaNoScia.do?command=Choose&codice_univoco_ml=TAV-TAV-EQ'"/>  <!-- il seguente codice_univoco-ml � fittizio -->
      			 
		</td>
	</tr>
	
</table> 

</body>
</form>





