/**
 * 
 */

window.onload = function () {
    var lis = document.getElementById('ul1').children;
    for (var i = 0, len = lis.length; i < len; i++) {
        lis[i].onclick = this.myFunction;
    }
}

function myFunction(elem) {
    var img = elem.target;
    var width = img.clientWidth;
    var x = document.images;
    var txt = "<img src="+ "\""+img.src+"\" style=\"width: "+width*2+"px\";>";
    document.getElementById("p2").innerHTML = txt;
}


function getCookie(elem) {
	var name = elem + "=";
	var cookieString = decodeURIComponent(document.cookie);
	var cookies = cookieString.split(';');
	for (var i = 0; i < cookies.length; i++) {
		var cookie = cookies[i];
		
		// now trim the cookie
		while (cookie.charAt(0) == ' ') {
      		cookie = cookie.substring(1);
    	}
    	// check the name 
    	if (cookie.indexOf(name) == 0) {
      		return cookie.substring(name.length, cookie.length);
    	}
    	
    	return null;
	}
}

function deleteCookie(elem) {
	document.cookie = elem + "=; expires=Thu, 01 Jan 1970 00:00:01 GMT";
}