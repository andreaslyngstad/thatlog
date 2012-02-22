function Change_select(log_id, object_id, url){
		$('.spinning').show();
	    if (log_id === "") {
	    	if(object_id === ""){
		      $.get("/" + url + "/0/0"  )
		    }else{
		      $.get("/" + url + "/" + object_id + "/0" )
		     }
	    }else{
		    if(object_id === ""){
		      $.get("/" + url + "/0/" + log_id  )
		    }else{		     
		      $.get("/" + url + "/" + object_id + "/" + log_id)
	    }
	    };
}

jQuery.fn.UIdialogs_tracking_logs_links = function(){
  $(this).click(function(){
  	$(".tracking_select").slideToggle();
  	$(".open_tracking_select").toggleClass("close_tracking_select");
    var data_id = $(this).attr('data-id')
    var form_id = '#form_holder'
    $("select.small_selector").selectmenu({width:200});
    // get todo and saving log when selecting project
	    $(form_id).find("select#log_project_id").change(function(){
		    Change_select($(this).attr("log"), this.value.toString(), "project_select_tracking")
	    });
	    $(form_id).find("select#log_todo_id_" + data_id).change(function(){
	   		Change_select($(this).attr("log"), this.value.toString(), "todo_select_tracking")
	    });  
	  // get employees and saving log when selecting customer
	    $(form_id).find("select#log_customer_id_" + data_id).change(function(){
	    	Change_select($(this).attr("log"), this.value.toString(), "customer_select_tracking")
	    }); 
	    
	    $(form_id).find("select#log_employee_id_" + data_id).change(function(){
	    	Change_select($(this).attr("log"), this.value.toString(), "employee_select_tracking")
	    });  
   });

};

jQuery.fn.select_projects_customers = function() {
	$(this).UIdialogs();
   	$(this).dialog( "open" );
   	var data_id = $(this).attr('data-id')
 	$(this).find("select#log_project_id").change(function(){
    Change_select($(this).attr("log"), this.value.toString(), "project_todos")
	});
	if (data_id === undefined ) {
   		$(this).find("select#log_todo_id_").change(function(){
	    Change_select("", this.value.toString(), "todo_select")
	    });	
   		$(this).find("select#log_customer_id_").change(function(){
    	Change_select("", this.value.toString(), "customer_employees")	
    	});
	}else{
	    $(this).find("select#log_todo_id_" + data_id).change(function(){
	    Change_select($(this).attr("log"), this.value.toString(), "todo_select")
   		});
	    $(this).find("select#log_customer_id_" + data_id).change(function(){
    	Change_select($(this).attr("log"), this.value.toString(), "customer_employees")
		});
     }; 
};



jQuery.fn.UIdialogs_log_links = function(){
  var form = '#' + $(this).attr('id') + '_form'
  $(this).button().click(function(){
  	$(form).find(".date").datepicker().attr( 'readOnly' , 'true' );
  	$(form).find(".big_select").selectmenu({width:369});
    $(form).select_projects_customers();
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
    $("#log_date_edit_" + data_id).datepicker().attr( 'readOnly' , 'true' );
    $(form_id).find(".big_select").selectmenu({width:369});
    $(form_id).select_projects_customers(data_id) 
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
   };
 
function getTime(hours, minutes) {
    var time = null;
    minutes = minutes + "";  
    if (minutes.length == 1) {
        minutes = "0" + minutes;
    }
    hours = hours + "";
    if (hours.length == 1) {
        hours = "0" + hours;
    }
    
    return hours + ":" + minutes;
};
function time_to_value(time){
    var b = time
    var temp = new Array
    temp = b.split(":")
    
    var hours = parseInt(temp[0] *60)
    var min = parseInt(temp[1])
    
    return hours + min
};
jQuery.fn.logs_pr_date_select = function(){
		this.change(function(){
  $('.spinning').show();
  var time = this.value
  var url = $(this).attr("data-url");
  var id = $(this).attr("data-id");
  $.get("/logs_pr_date/" + time + "/" + url + "/" + id)
  
  });
  };

$(document).ready(function() {
  $("select#logs_pr_date_select").logs_pr_date_select();
  $("#dialog_log").UIdialogs_log_links();
  
  $(".open_log_update").UIdialogs_edit_logs_links();
  $(".new_log").validateWithErrors();
  $(".range").find(":submit").button();
  $(".date").datepicker().attr( 'readOnly' , 'true' );
  $(".range_date").datepicker().attr( 'readOnly' , 'true' );
$(".slider_range").slider({
        range: true,
        min: 0,
        max: 1439,
        values: [ 740, 1020 ],
        step:10,
        slide: slideTime
    });
    $(".open_tracking_select").UIdialogs_tracking_logs_links();
    
})