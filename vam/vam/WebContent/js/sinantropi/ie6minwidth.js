/*
** JS min-width property for internet explorer 6 & internet explorer 5.5
** By Nemesis Design http://nemesisdesign.altervista.org
*/

minWidth = function(id, width){
	docWidth = document.body.clientWidth;
    screenWidth = window.screen.width;
    if(docWidth <= width || screenWidth <= width){
        document.getElementById(id).style.width = width+"px";
    }
    else if(docWidth > 1000){
        document.getElementById(id).style.width = "100%";
    }
}

if(navigator.userAgent.indexOf("MSIE 6.0") != -1 || navigator.userAgent.indexOf("MSIE 5.5") != -1){
    window.onresize = function(){
        minWidth("container", "1000");
    }
    window.onload = window.onresize;
}
