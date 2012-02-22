
jQuery.fn.back_button_function = function(){
  $(this).live("click", function(){
	$('.spinning').show();
	
	$(".inner").animate({left:0, duration:500});
	
	
});
};
baseurl = location.protocol + '//' + location.host + location.pathname;


$(function() {
	
	
	old_url = $.param.fragment(baseurl, location.href, 2);
	var text = old_url.match(/customers/i) || old_url.match(/projects/i) || old_url.match(/archive/i) || old_url.match(/users/i) ||  old_url.match(/statistics/i) ||  old_url.match(/logs/i);
	var text2 = old_url.match(/reports/i) || old_url.match(/timesheets/i) || old_url.match(/account/i) || old_url.match(/home_user/i) ||  old_url.match(/statistics/i) ||  old_url.match(/firm_edit/i)||  old_url.match(/timesheet_logs_day/i);
	if (!(text2 == null)){
		var tab_text = text2.toString().charAt(0).toUpperCase() + text2.toString().substr(1);
		$("#html_tabs a.current_link").removeClass("current_link");	
		$("#html_tabs a:contains(" + tab_text + ")").addClass("current_link");
		if(tab_text == "Home_user" ){$("#html_tabs a:contains(User)").addClass("current_link");}
		if(tab_text == "Firm_edit" ){$("#html_tabs a:contains(Account)").addClass("current_link");}
		if(tab_text == "Timesheet_logs_day" ){$("#html_tabs a:contains(Timesheets)").addClass("current_link");}
	}
	
	
	
	if (text == null){
		$("#pointer-text").text("Statistics");
		var pos = "0"
		var cssObj = {'top': pos + 'px'}
 		$("#pointer").css(cssObj);
 		
		
		
	}else{
	
	var cap_text = text.toString().charAt(0).toUpperCase() + text.toString().substr(1);
	$("#pointer-text").text(cap_text);
	if(cap_text == "Statistics")
	{var pos = "0"
	
	} 
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
	$("#pointer").css(cssObj);
	}
  $('#navigation li').live('click', function(e) { 
  	
  	var href =	$(this).find("a").attr("href");
   
	$(".indicator").show(); // show loading spinner
	var text = $(this).text();
	var pos = $(this).attr("pos")
	
 	var cssObj = {'top': pos + 'px'}
 		$("#pointer").animate(cssObj);
 		$("#pointer-text").text(text);
			
			
		
  });
  $("#active_projects").button();
  $("#archive").button().live('click', function(e) { 
  	var href =	$(this).attr("href");
  	$("#pointer-text").text(text);
  });
  $(".view-tabs-list").live("click", function(){
		$('.spinning').show();
		$(".inner").animate({left:-980, duration:500});
		
	});
	

    
	$(".back_button").button().back_button_function();
	
});


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

