<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>

<style type="text/css">
#Copia ed adattamento del css contenuto in css > vam > homePage
#content
{
margin:0 auto;
width:899px;
}
#content p
{
font:normal 12px/18px Arial, Helvetica, sans-serif;
padding:10px;
color:#333333;
}
#content_right
{
margin:0 auto;
width:860px;
padding:5px;
}
#content h3
{
font:bold 12px/20px Arial, Helvetica, sans-serif;
color:#607B35;
}
#content_row1
{
margin:0 auto;
width:670px;
height:175px;
background:url('images/homePage/pets_clinic_08.gif') no-repeat 0 0;
padding-left:250px
}
#content_row2
{
margin:0 auto;
width:625px;
}

</style>

<div id="content">
  <table>
    <tr>
      <td >
		<div id="content_right">
        <table >
        	<tr>
        		<td>
        			<strong>
        				<font color="red">
        					<c:if test="${fn:length(trasferimentiDaAccettare) == 1}">
        						C'&egrave; un trasferimento in ingresso da accettare
        					</c:if>
        					<c:if test="${fn:length(trasferimentiDaAccettare) > 1}">
        						Ci sono ${fn:length(trasferimentiDaAccettare)} trasferimenti in ingresso da accettare
        					</c:if>
        					<br/>
        					<c:if test="${fn:length(trasferimentiRientranti) == 1}">
        						<!--  E' rientrato un animale nell'ultima settimana -->
        					</c:if>
        					<c:if test="${fn:length(trasferimentiRientranti) > 1}">
        						<!--  Sono rientrati ${fn:length(trasferimentiRientranti)} animali nell'ultima settimana-->
        					</c:if>
        				</font>
        			</strong>
        		</td>
        	</tr>
          <tr>
            <td><h3>VAM</h3>
            
              <div id="content_row1">
                <p>
                </p>
                </div>
                
                </td>
          </tr>
        </table>
      </div>
</td>
</tr>
</table>
</div>