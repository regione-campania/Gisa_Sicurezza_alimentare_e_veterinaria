<link rel="stylesheet" type="text/css" href="../css/jqcontextmenu.css" />

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

<script type="text/javascript" src="../javascript/jqcontextmenu.js">

/***********************************************
* jQuery Context Menu- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for this script and 100s more
***********************************************/

</script>

<script type="text/javascript">

//Usage: $(elementselector).addcontextmenu('id_of_context_menu_on_page')
//To apply context menu to entire document, use: $(document).addcontextmenu('id_of_context_menu_on_page')

jQuery(document).ready(function($){
	$('a.mylinks').addcontextmenu('contextmenu1') //apply context menu to links with class="mylinks"
})


jQuery(document).ready(function($){
	$('img').addcontextmenu('contextmenu2') //apply context menu to all images on the page
})

</script>

<p><a class="mylinks" href="http://www.dynamicdrive.com">Dynamic Drive</a></p>
<p><img src="http://img339.imageshack.us/img339/2488/redleaveslarge.jpg" /></p>


<!--HTML for Context Menu 1-->
<ul id="contextmenu1" class="jqcontextmenu">
<li><a href="#">Item 1a</a></li>
<li><a href="#">Item 2a</a></li>
<li><a href="#">Item Folder 3a</a>
	<ul>
	<li><a href="#">Sub Item 3.1a</a></li>
	<li><a href="#">Sub Item 3.2a</a></li>
	<li><a href="#">Sub Item 3.3a</a></li>
	<li><a href="#">Sub Item 3.4a</a></li>
	</ul>
</li>
<li><a href="#">Item 4a</a></li>
<li><a href="#">Item Folder 5a</a>
	<ul>
	<li><a href="#">Sub Item 5.1a</a></li>
	<li><a href="#">Item Folder 5.2a</a>
		<ul>
		<li><a href="#">Sub Item 5.2.1a</a></li>
		<li><a href="#">Sub Item 5.2.2a</a></li>
		<li><a href="#">Sub Item 5.2.3a</a></li>
		<li><a href="#">Sub Item 5.2.4a</a></li>
		</ul>
	</li>
	</ul>
</li>
<li><a href="#">Item 6a</a></li>
</ul>


<!--HTML for Context Menu 2-->
<ul id="contextmenu2" class="jqcontextmenu">
<li><a href="#">Item 1a</a></li>
<li><a href="#">Item 2a</a></li>
<li><a href="#">Item 1a</a></li>
<li><a href="#">Item 2a</a></li>
</ul>