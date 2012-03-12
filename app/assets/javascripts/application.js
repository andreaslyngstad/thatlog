//= require jquery
//= require jquery_ujs
//= require jquery.ui.draggable
//= require jquery.ui.droppable
//= require jquery.ui.button
//= require jquery.ui.dialog
//= require jquery.ui.slider
//= require jquery.ui.datepicker
//= require jquery.ui.selectmenu
//= require jquery.validate
//= require jquery.ba-bbq.min
//= require jquery.quicksearch
//= require navigation
//= require logs
//= require raphael-min
//= require elycharts.min
//= require tabs
//= require employees
//= require charts

//= require jquery.jclock

//= require_self

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
//display help
jQuery.fn.display_help = function(){
  $(this).click(function(){
    $(".page_help").slideToggle()
   
    });
  
};

//submitting forms with ajax
jQuery.fn.submitWithAjax = function() {
  this.submit(function() { 
    $.post(this.action, $(this).serialize(), null, "script");
    $('.spinning').show();
    return false;
  })
  return this;
};
//submitting dialog forms with ajax
jQuery.fn.submit_dialog_WithAjax = function() {
    $.post(this.attr("action"), $(this).serialize(), null, "script");
    $('.spinning').show(); 
    $(".dialog_form").dialog("close")
    return false;
};

jQuery.fn.mark_todo_done = function (){
  this.live('click', function() { 
    $('.spinning').show();
    var todo_id =  $(this).attr("id");
  
  $.getScript("/mark_todo_done/" + todo_id)
    })
};
jQuery.fn.membership = function (){
  this.live('click', function() { 
    $('.spinning').show();
    var user_id =  $(this).attr("id");
    var project_id = $(this).attr("project_id")
  
  $.getScript("/membership/" + user_id + "/" + project_id)
    })
};

jQuery.fn.highlight = function (className)
{
    return this.addClass(className);
};


jQuery.fn.UIdialogs = function(){
  $(this).dialog({
      autoOpen: false,
      resizable: false,
      width: 400,
      modal: true,
      close: function(event, ui) { 
      	
      	$(this).find(".hasDatepicker").datepicker( "destroy" );
    	$(this).find("select").selectmenu( "destroy" );

      	$(this).dialog("destroy"); 
      	
      },
  });
};
jQuery.fn.disableUIdialogs = function(){
  $(this).dialog("destroy");
};


jQuery.fn.validateWithErrors = function(){
    $(this).validate({
     submitHandler: function(form) {  
    $(form).submit_dialog_WithAjax();
    $(form).parent().disableUIdialogs();
   },
   		errorElement: "div",
        wrapper: "div",  // a wrapper around the error message
     	errorPlacement: function(error, element) {
        element.before(error);
        offset = element.offset();
        error.css('left', offset.left);
        error.css('top', offset.top - element.outerHeight());
     }
   }); 
};
jQuery.fn.validateNoSubmit = function(){
    $(this).validate({
   		errorElement: "em",    
     	errorPlacement: function(error, element) {
     	$(".signup-form-field-subdomain em").remove();
         error.appendTo( element.parent("div"));
         element.css("border:1px solid red;");
     }
   }); 
};

jQuery.fn.UIdialogs_links = function(){
  var form = '#' + $(this).attr('id') + '_form'
  var date = '#' + $(this).attr('id') + '_date'
  var object = $(this).attr("data-object")
 
  $(this).button().click(function(){
  	$(form).UIdialogs();
      $(date).datepicker({ dateFormat: "yy-mm-dd" }).attr( 'readOnly' , 'true' );
       $(form).children(".new_" + object).validateWithErrors();
      $(form).find("select").selectmenu({width:369});
      $(form).dialog( "open" );
    });

}; 
jQuery.fn.activate_projects = function(){
	$(this).button().click(function(){
		$('.spinning').show();
		var id = $(this).attr("data-id")
  	$.get("/activate_projects/" + id)
    });
	
};
jQuery.fn.activate_projects_no_button = function(){
	$(this).click(function(){
		$('.spinning').show();
		var id = $(this).attr("data-id")
  	$.get("/activate_projects/" + id)
    });
	
};


jQuery.fn.UIdialogs_edit_links = function(){
  $(this).click(function(){
    var data_id = $(this).attr('data-id')
    var object = $(this).attr("data-object")
    var form_id = '#' + $(this).attr('id') + '_' + data_id + '_form'
    
    $(form_id).find("#date" + '_' + object + '_' + data_id).datepicker().attr( 'readOnly' , 'true' );
    $(form_id).children(".edit_" + object).validateWithErrors();
    $(form_id).find("select").selectmenu({width:369});
    $(form_id).UIdialogs();
    $(form_id).dialog( "open" );
    });

};

jQuery.fn.current_link = function(){
  $(this).click(function(){
  $("#html_tabs a.current_link").removeClass("current_link")
  $(this).addClass("current_link")
    
    });

};

jQuery.fn.timeheet_user_select = function(){
		this.change(function(){
  $('.spinning').show();
  var id = this.value
  $.get("/timesheets/" + id)
  
  });
};  


//ok
  
///////////////////////////////////////////////////////////////document.ready///////////////////////////////////////////////////////


  
  
$(document).ready(function() {
		
	  $(".draggable").draggable(
	  	{
	  		containment: '#users_list',
	  		
	  		revert: true,
	  		opacity: 0.7
	  	}
	  );
    $("#members").droppable({
  		
		accept: ".not_member",
      	drop: function(event,ui) { 
	      	$('.spinning').show();
	      	ui.draggable.addClass("member")
	      	ui.draggable.removeClass("not_member") 
	      	ui.draggable.draggable( 'option', 'revert', false );
		    var user_id =  ui.draggable.attr("user_id");
		    var project_id = ui.draggable.attr("project_id");
		  	$.getScript("/membership/" + user_id + "/" + project_id);
          	 }
    });
    $("#not_members").droppable(
    	{
    		accept: ".member",
      		drop: function(event,ui) { 
	      	$('.spinning').show(); 
	      	ui.draggable.addClass("not_member")
	      	ui.draggable.removeClass("member")  
	      	ui.draggable.draggable( 'option', 'revert', false );
	      	$("#not_members").find(".user_info:last")
		    var user_id =  ui.draggable.attr("user_id");
		    var project_id = ui.draggable.attr("project_id"); 
		  	$.getScript("/membership/" + user_id + "/" + project_id);
    		}
    	}
    );
	$('.left_slider').click(function(){
	  $(".milestone_slider").animate({"left": "+=122px"}, "slow");
	});
	
	$('.right_slider').click(function(){
	  $(".milestone_slider").animate({"left": "-=122px"}, "slow");
	});
	var p = $(".milestone_slider").find(".upcomming:first").position()
	if (p != null){
	$('.milestone_slider').animate({"left": "-=" + (parseInt(p.left) - 122)}, "slow");
	}
   $('.jclock').jclock();
   
   $("#html_tabs a").current_link();
   $(".display_help").display_help();
//jquery UI dialogs

  $("#dialog_milestone").UIdialogs_links();
  
  $("#dialog_task").UIdialogs_links();
  

  
  $("#dialog_project").UIdialogs_links();
 
  $("#dialog_customer").UIdialogs_links();
 
  $("#dialog_user").UIdialogs_links();
 
  $("#activate_project").button().click(function(){
  	var id = $(this).attr("data-id")
  	
  	alert(id);
    });

  
  $(".open_project_update").UIdialogs_edit_links();
  $(".open_user_update").UIdialogs_edit_links();
  $(".open_customer_update").UIdialogs_edit_links();
  $(".open_milestone_update").UIdialogs_edit_links();
  $(".open_todo_update").UIdialogs_edit_links();
	
	
 
  $(".small_selector").selectmenu({width:200});
  $(".range").find(":submit").button();
  $(".date").datepicker().attr( 'readOnly' , 'true' );
  
  $(".show_avatar_upload").click(function(){
  	$(".avatar_upload").show();
  	$(".avatar_show_page").hide();
  	return false	
  });
  $(".hide_avatar_upload").click(function(){
  	$(".avatar_upload").hide();
  	$(".avatar_show_page").show();
  	return false	
  });
  
//submitting new_project
  $(".new_project_form").validateWithErrors();

//submitting new_employee   
    $(".new_employee").validateWithErrors();
//    $(".edit_employee").validateWithErrors();
//submitting new_milestone  
   $(".new_milestone").validateWithErrors();
   $("#employee_formtastic").validateWithErrors();
//submitting new_project
   $(".new_project").validateWithErrors();
//   $(".edit_project").validateWithErrors();
//submitting new_todo
   	$(".new_todo").validateWithErrors();
   	$(".edit_todo").validateWithErrors(); 
//submitting new_log
   	$(".new_log").validateWithErrors();
 	$(".tracking_log").submitWithAjax();
	$("#form_holder").find(".edit_log").submitWithAjax();
	
	$(".activate_project").activate_projects();
	$(".activate_projects_no_button").activate_projects_no_button();
	
//timesheet begin
$("select#timeheet_user_select").timeheet_user_select();
$("table.timesheet_table tbody tr td.number input").focusout(function(){
	var val_input 	= this.value
	var project 	= $(this).attr("data-project")
	var date 		= $(this).attr("data-date")
	var regexp1 	= /^[0-9,:]+$/  // test denne => /[0-9,:]+(?:\.[0-9]*)?/
	var regexp2		= /^[:]+$/
	
	if (regexp1.test(val_input)){
		this.value = project
		alert (project + date )
		
	}else{
		this.value = "no"
	var val_input = this.value

		setTimeout(function(){
	      
		},0);}
	
	
	
	
  });
//timesheet end
 $(".background_style_color").css({"background-color":$("input.background_style").val()})
  $(".text_style_color").css({"background-color":$("input.text_style").val()})
  $(".background_style").keyup(function(){
  	var val_input = this.value
  $(".background_style_color").css({"background-color":val_input})
  
	});
  $(".text_style").keyup(function(){
  	var val_input = this.value
  $(".text_style_color").css({"background-color":val_input})
  
	});

 $("input.done_box").mark_todo_done();
 $("input.membership").membership();
 $(".register_firm").validateNoSubmit();
 $(".first_user").validateNoSubmit();
$(".range_date").datepicker().attr( 'readOnly' , 'true' );
   
   $(".slider_range").slider({
        range: true,
        min: 0,
        max: 1439,
        values: [ 740, 1020 ],
        step:10,
        slide: slideTime
    });

//non-ajax search
   $("input#id_search_list").quicksearch('ul#cus_pro_us_listing li'); 

})