    
      <%
       int maxFileSize=-1;
	   int mb1size = 1048576;
	    maxFileSize=Integer.parseInt(it.us.web.util.properties.Application.get("MAX_SIZE_ALLEGATI"));
	   	String maxSizeString = String.format("%.2f", (double) maxFileSize/ (double) mb1size);
       %>
       
       <script>function checkFormFile(form){
	var fileCaricato = form.file1;
	var oggetto = form.subject.value;
	var errorString = '';
	if (fileCaricato.value==''){// || (!fileCaricato.value.endsWith(".pdf") && !fileCaricato.value.endsWith(".csv"))){
		errorString+='Errore! Selezionare un file!';
		form.file1.value='';
	}
// 	if (oggetto==''){
// 		errorString+='\nErrore! L\'oggetto � obbligatorio.';
// 		}
	if (!GetFileSize(form.file1))
		errorString+='\nErrore! Selezionare un file con dimensione superiore a 0 ed inferiore a <%=maxSizeString%> MB';
	if (errorString!= '')
		alert(errorString)
	else
	{
	//form.filename.value = fileCaricato.value;	
	form.uploadButton.hidden="hidden";
	form.file1.hidden="hidden";
	document.getElementById("image_loading").hidden="";
//	document.getElementById("text_loading").hidden="";
	attendere(); 
	form.submit();
	}
}</script>

<script>function GetFileSize(fileid) {
	var input = document.getElementById('file1');
        file = input.files[0];
        if (file.size == 0 || file.size> <%=it.us.web.util.properties.Application.get("MAX_SIZE_ALLEGATI")%>)
      	 	return false;
        return true;
		}
</script>


<form id="form2" action="documentale.UploadNewFile.us" method="post" name="form2" enctype="multipart/form-data">
 <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th colspan="2">
      Aggiungi <%if(idAltraDiagnosi!=null && !idAltraDiagnosi.equals("")){out.println("referto");}else{out.println("immagini");} %>
      </th>
    </tr>
    <tr class="containerBody" style="display:none">
      <td class="formLabel">
       Oggetto
      </td>
      <td>
        <input type="hidden" name="subject" size="59" maxlength="255" value=""><font color="red">*</font>
      
      </td>
    </tr>
      <tr class="containerBody">
      <td class="formLabel">
    Aggiungi <%if(idAltraDiagnosi!=null && !idAltraDiagnosi.equals("")){out.println("referto");}else{out.println("immagini");} %>
       
      </td>
      <td>
          
      <input type="file" 
      <%
      	if(idAltraDiagnosi!=null && !idAltraDiagnosi.equals(""))
      	{
      %>
      		accept="*"
      <%
      	}
      	else
      	{
      	%>
      		accept="image/*"
      <%
      	}
      %>
        id="file1" name="file1" size="45" multiple>  <input type="button" id="uploadButton" name="uploadButton" value="CARICA" onclick="checkFormFile(this.form)" />
      
          <img id="image_loading" hidden="hidden" src="images/loading.gif" height="15"/>
         </td>
    </tr>
      <input type="hidden" name="idAutopsia" id ="idAutopsia" value="<%=idAutopsia %>" />
       <input type="hidden" name="idAccettazione" id ="idAccettazione" value="<%=idAccettazione %>" />
       <input type="hidden" name="idAltraDiagnosi" id ="idAltraDiagnosi" value="<%=idAltraDiagnosi %>" />
      <input type="hidden" name="idIstopatologico" id ="idIstopatologico" value="<%=idIstopatologico %>" />
        <input type="hidden" name="readonly" id ="readonly" value="<%=readonly %>" />
  
  </table>
   </form>
 
 

 