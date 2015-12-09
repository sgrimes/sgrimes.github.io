var menuTop = 45;
var menuLeft = 400;

var domSMenu = null;
var oldDomSMenu = null;
var t = 0;
var lDelay = 10;
var lCount = 0;
var pause = 100;

function popMenu(menuNum, frameName){
	if (isDHTML) {
///// Sets the previous menu's visibility to hidden
		t = 2;
		if (oldDomSMenu) {
			oldDomSMenu.visibility = 'hidden'; 
			oldDomSMenu.zIndex = '0'; 
			t = 2; 
			lCount = 0;
		}

///// Defines the DOMs	of the menu objects
		var idMenu = 'menuHead';
		var domMenu = findDOM(idMenu,0);

		var idMenuOpt = 'menuHead' + menuNum;
		var domMenuOpt = findDOM(idMenuOpt,0);		

		var idSMenu = 'menu' + menuNum;
		var domSMenu = findDOMFrame(idSMenu,frameName,1);

///// Defines the positions of the sub-menus
	if (isID || isAll) { 	
				var menuLeft = (domMenu.offsetLeft) + (domMenuOpt.offsetHeight)- 10;
				var menuTop = (domMenu.offsetTop) + (domMenu.offsetHeight) - 30;
			}
		if (isLayers) {
				var menuLeft = document.layers[idMenu].layers[idMenuOpt].pageX;
				var menuTop = domMenu.pageY + domMenu.clip.height - 5;
		}

///// Positions and shows the menu
		if (oldDomSMenu != domSMenu) {	
			domSMenu.left = menuLeft; 
			domSMenu.top = menuTop;
			domSMenu.visibility = 'visible';
			domSMenu.zIndex = '100';
			oldDomSMenu = domSMenu;
		}

///// Resets oldDom if it is the same as the current DOM
		else { oldDomSMenu = null; }
	}

////// Returns a 'null' value for non-DHTML Browsers 
	else { return null; }
}

function delayHide() {
///// Checks to see if there is a menu showing and whether 
///// the global variable 't' has been set to 0
    if ((oldDomSMenu) && (t == 0)) {

///// Hides the old menu, resets menu conditions, 
///// and stops the function running
        oldDomSMenu.visibility = 'hidden'; 
        oldDomSMenu.zIndex = '0';
        oldDomSMenu = null;
        lCount = 0; 
        return false;
    }

///// Interupts the function if another menu is opened
    if (t == 2) { lCount = 0; return false; }

///// Repeats the function adding 1 to lCount each time until 
///// lCount is equal to lDelay and then sets 't' to 0 so that 
///// the menu will hide when it runs again
/////    if (t == 1) { 
/////        lCount = lCount + 1;
/////        if (lDelay <= lCount) { t = 0; }
/////        if (lDelay >= lCount) { setTimeout('delayHide(' + t + ')',pause); }
/////    }
}
