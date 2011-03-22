jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

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

jQuery.fn.UIdialogs_log_links = function(){
  var form = '#' + $(this).attr('id') + '_form'
  $(this).button().click(function(){
    $(form).UIdialogs();
    $(form).find("select#log_project_id").change(function(){
    $('.spinning').show();
    var log_id = $(this).attr("log")
    var project_id = this.value
    if(project_id === ""){
      $.get("/project_todos/0/" + log_id)
    }else{
      var project_id = this.value
      $.get("/project_todos/" + project_id + "/" + log_id)
    }
    });
    $(form).find("select#new_log_customer_id").change(function(){
    $('.spinning').show();
    var log_id = $(this).attr("log")
    var customer_id = this.value
    if(customer_id === ""){
      $.get("/customer_employees/0/" + log_id)
    }else{
      var customer_id = this.value
      $.get("/customer_employees/" + customer_id + "/" + log_id)
    }
    });
    $(form).find("select").selectmenu({width:369});
      $(form).dialog( "open" );
    });

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
    $(this).validate(
    	
    	{
	
   errorElement: "em",
         
     errorPlacement: function(error, element) {
     	$(".signup-form-field-subdomain em").remove();
         error.appendTo( element.parent("div"));
         element.css("border:1px solid red;");
     }
   }); 
};
jQuery.fn.validates_uniqe = function(){
 	$(this).keyup(function(){
 	var value = $(this).val().toLowerCase();
 	
 	if (value.length == 0){
	$(".signup-form-field-subdomain em").remove();
 	$(".signup-form-field-subdomain").append("<em class='error'>This field is required.</em>");
 	}
 	else if (/^[a-z0-9\_]+$/i.test(value) == false){
 	$(".signup-form-field-subdomain em").remove();
 	$(".signup-form-field-subdomain").append("<em class='error'>No spesial charaters or spaces.</em>");	
 		
 	}else{
 	$(".signup-form-field-subdomain em").remove();
 	$(".signup-form-field-subdomain").append("<em class='check'>Cheking..</em>");
 	$.get("/validates_uniqe/" + value);
 	
 	}
 	
 	
 	
 	});
 	

};
jQuery.fn.UIdialogs_links = function(){
  var form = '#' + $(this).attr('id') + '_form'
  var date = '#' + $(this).attr('id') + '_date'
  var object = $(this).attr("data-object")
 
  $(this).button().click(function(){
  	$(form).UIdialogs();
      $(date).datepicker().attr( 'readOnly' , 'true' );
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
	
}
jQuery.fn.activate_projects_no_button = function(){
	$(this).click(function(){
		$('.spinning').show();
		var id = $(this).attr("data-id")
  	$.get("/activate_projects/" + id)
    });
	
}
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
jQuery.fn.UIdialogs_edit_logs_links = function(){
  $(this).click(function(){
    var data_id = $(this).attr('data-id')
    var form_id = '#' + $(this).attr('id') + '_' + data_id + '_form'
    var log_time_from = $("#log_times_from_" + data_id).val();
    var log_time_to = $("#log_times_to_" + data_id).val();
    $(form_id).children(".edit_log").validateWithErrors();
    $(form_id).find("#slider_range_" + data_id).slider({
        range: true,
        min: 0,
        max: 1439,
        values: [ time_to_value(log_time_from), time_to_value(log_time_to) ],
        step:10,
        slide: slideTime
    });
    $(form_id).find("select").selectmenu({width:369});
    $("#log_date_edit_" + data_id).datepicker().attr( 'readOnly' , 'true' );
    $(form_id).find("select#log_project_id").change(function(){
    $('.spinning').show();
    var log_id = $(this).attr("log")
    var project_id = this.value
    if(project_id === ""){
      $.get("/project_todos/0/" + log_id)
    }else{
      var project_id = this.value
      $.get("/project_todos/" + project_id + "/" + log_id)
    }
    });
    $(form_id).find("select#log_customer_id_" + data_id).change(function(){
    $('.spinning').show();
    var log_id = $(this).attr("log")
    var customer_id = this.value
    if(customer_id === ""){
      $.get("/customer_employees/0/" + log_id)
    }else{
      var customer_id = this.value
      $.get("/customer_employees/" + customer_id + "/" + log_id)
    }
    });
    $(form_id).UIdialogs();
    $(form_id).dialog( "open" );
    });

};

jQuery.fn.open_not_required = function(){
	 $(this).click(function(){
  	$(".not_required").slideToggle();
  	$(".open_not_required").toggleClass("close_not_required");
  	return false
  });
};

jQuery.fn.UIdialogs_tracking_logs_links = function(){
  $(this).click(function(){
  	$(".tracking_select").slideToggle();
  	$(".open_tracking_select").toggleClass("close_tracking_select");
  
  	
    var data_id = $(this).attr('data-id')
    var form_id = '#form_holder'
    
    
    $("select.small_selector").selectmenu({width:200});
    $(form_id).find("select#log_project_id").change(function(){
    $('.spinning').show();
    var log_id = $(this).attr("log")
    var project_id = this.value
    if(project_id === ""){
      $.get("/project_todos/0/" + log_id)
    }else{
      var project_id = this.value
      $.get("/project_todos/" + project_id + "/" + log_id)
    }
    });
    $(form_id).find("select#log_customer_id_" + data_id).change(function(){
    $('.spinning').show();
    var log_id = $(this).attr("log")
    var customer_id = this.value
    if(customer_id === ""){
      $.get("/customer_employees/0/" + log_id)
    }else{
      var customer_id = this.value
      $.get("/customer_employees/" + customer_id + "/" + log_id)
    }
    });
    
    });

};

function slideTime(event, ui){
   var log = $(this).attr("log")
    var minutes0 = parseInt(ui.values[ 0 ]  % 60);
    var hours0 = parseInt(ui.values[ 0 ]  / 60 % 24);
    var minutes1 = parseInt(ui.values[ 1 ]  % 60);
    var hours1 = parseInt(ui.values[ 1 ]  / 60 % 24);
    $("#log_times_from_" + log).val(getTime(hours0, minutes0));
    $("#log_times_to_" + log).val(getTime(hours1, minutes1));
    }
 
function getTime(hours, minutes) {
    var time = null;
    minutes = minutes + "";  
    if (minutes.length == 1) {
        minutes = "0" + minutes;
    }
    return hours + ":" + minutes;
}
function time_to_value(time){
    var b = time
    var temp = new Array
    temp = b.split(":")
    
    var hours = parseInt(temp[0] *60)
    var min = parseInt(temp[1])
    
    return hours + min
}

jQuery.fn.back_button_function = function(){
  $(this).live("click", function(){
	$('.spinning').show();
	var object = $(this).attr("data-object");
	$.getScript("/" + object + "s");
	$(".inner").animate({left:0, duration:500});
	$(".show-view").empty();
	$(".show-view").append("<div class='show-view'><div class='list_header'>Loading....</div></div>");
	return false
});
};
	
///////////////////////////////////////////////////////////////document.ready///////////////////////////////////////////////////////



  
  
$(document).ready(function() {
	
	$(".view-tabs-list").live("click", function(){
		$('.spinning').show();
		var id = $(this).attr("data-id");
		var object = $(this).attr("data-object");
		var firm_id = $(this).attr("data-firm-id");
		$(".inner").animate({left:-980, duration:500});
		$.get("/" + object + "s/" + id);
	});
	

   $('.jclock').jclock();

 
 $( "#tabs" ).tabs({ cache: true },
  {spinner: '<img src="/images/spinner2.gif" />'},
   {
      ajaxOptions: {
        
        error: function( xhr, status, index, anchor ) {
          $( anchor.hash ).html(
            "Couldn't load this tab. We'll try to fix this as soon as possible. ");
        }
      }
    });
$(".back_button").back_button_function();

//jquery UI dialogs
  
  $("#dialog_milestone").UIdialogs_links();
  
  $("#dialog_task").UIdialogs_links();
  
  $("#dialog_log").UIdialogs_log_links();
  
  $("#dialog_project").UIdialogs_links();
  
  $("#dialog_employees").UIdialogs_links();
 
  $("#dialog_customer").UIdialogs_links();
 
  $("#dialog_user").UIdialogs_links();
 
  $("#activate_project").button().click(function(){
  	var id = $(this).attr("data-id")
  	
  	alert(id);
    });

  
  $(".open_project_update").UIdialogs_edit_links();
  $(".open_customer_update").UIdialogs_edit_links();
  $(".open_milestone_update").UIdialogs_edit_links();
  $(".open_todo_update").UIdialogs_edit_links();
  $(".open_employee_update").UIdialogs_edit_links();
  $(".open_log_update").UIdialogs_edit_logs_links();

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
 
  $(".open_not_required_container").open_not_required();
 
 $(".tracking_log").submitWithAjax();
$("#form_holder").find(".edit_log").submitWithAjax();
$(".open_tracking_select").UIdialogs_tracking_logs_links();
$(".activate_project").activate_projects();
$(".activate_projects_no_button").activate_projects_no_button();
$("select#logs_pr_date_select").change(function(){
  $('.spinning').show();
  var time = this.value
  $.get("/logs_pr_date/" + time)
  
  });

$(".signup select").selectmenu({width:364});
 $("input.done_box").mark_todo_done();
 $("input.membership").membership();
 $(".register_firm").validateNoSubmit();
 $(".first_user").validateNoSubmit();
 $(".register_firm_subdomain").validates_uniqe();

   
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