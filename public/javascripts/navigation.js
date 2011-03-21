

   	
  // 	$(".indicator").show();
 // 	var text = $(this).text();
 // 	var pos = $(this).attr("pos")
 // 	var href =	$(this).find("a").attr("href")
 // 	var cssObj = {'display': 'inline',
 // 					'top': pos + 'px'}
 // $("#pointer").animate(cssObj)
 // $("#pointer-text").text(text)
   	 

//////////////////////////////////////////////////////////////////////////////////////////////////////
// AJAX pagination support with will_paginate and jQuery; history fix via jQuery-BBQ

baseurl = location.protocol + '//' + location.host + location.pathname;


$(function() {
	
	old_url = $.param.fragment(baseurl, location.href, 2);
	var text = old_url.match(/customers/i) || old_url.match(/projects/i) || old_url.match(/archive/i) || old_url.match(/users/i) ||  old_url.match(/statistics/i) ||  old_url.match(/logs/i);
	if (text == null){
		$("#pointer-text").text("Statistics");
		var pos = "0"
		var cssObj = {'top': pos + 'px'}
 		$("#pointer").css(cssObj);
		$.getScript( "/statistics") ;
		
	}else{
	
	var cap_text = text.toString().charAt(0).toUpperCase() + text.toString().substr(1);
	$("#pointer-text").text(cap_text);
	if(cap_text == "Statistics")
	{var pos = "0"} 
	else if (cap_text == "Logs")
	{var pos = "75"} 
	else if (cap_text == "Customers")
	{var pos = "225"} 
	else if (cap_text == "Projects")
	{var pos = "150"}
	else if (cap_text == "Archive")
	{var pos = "150"}
	else if (cap_text == "Users")
	{var pos = "300"}
	var cssObj = {'top': pos + 'px'}
	$("#pointer").animate(cssObj);
	}
  $('#navigation li').live('click', function(e) { 
  	
  	var href =	$(this).find("a").attr("href");
    params = $.deparam.querystring(href);
		new_url = $.param.fragment( baseurl, href, 2);
			$(".indicator").show(); // show loading spinner
			var text = $(this).text();
	var pos = $(this).attr("pos")
	var href =	$(this).find("a").attr("href")
 	var cssObj = {'top': pos + 'px'}
 		$("#pointer").animate(cssObj);
 		$("#pointer-text").text(text);
			
			location.hash = $.param.fragment( new_url ); // set the new hash, which will trigger the hashchange event
			
		return false;
  });
  $("#archive").live('click', function(e) { 
  	var href =	$(this).attr("href");
  
    params = $.deparam.querystring(href);
  	archive_url = $.param.fragment( baseurl, href, 2);
  	location.hash = $.param.fragment( archive_url );
  	return false;
  });
});

$(window).bind( 'hashchange', function(e) {
	params = e.fragment; // pre-jQuery1.4: $.deparam.fragment(document.location.href);
	
	var text = params.match(/customers/i) || params.match(/projects/i) || params.match(/archive/i) || params.match(/users/i) ||  params.match(/statistics/i) ||  params.match(/logs/i);
	if (text == null){
		$("#pointer-text").text("Statistics");
		var pos = "0"
		var cssObj = {'top': pos + 'px'}
 		$("#pointer").animate(cssObj);
		$.getScript( "/statistics") ;
		
	}else{
	
	var cap_text = text.toString().charAt(0).toUpperCase() + text.toString().substr(1);
	$("#pointer-text").text(cap_text);
	if(cap_text == "Statistics")
	{var pos = "0"} 
	else if (cap_text == "Logs")
	{var pos = "75"} 
	else if (cap_text == "Customers")
	{var pos = "225"} 
	else if (cap_text == "Projects")
	{var pos = "150"}
	else if (cap_text == "Archive")
	{var pos = "150"}
	else if (cap_text == "Users")
	{var pos = "300"}
	var cssObj = {'top': pos + 'px'}
	$("#pointer").animate(cssObj);
	
	$.getScript( params) ;
}
});
if (location.hash) {

  $(window).trigger( 'hashchange' );
  
 
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

