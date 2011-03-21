$(document).ready(function() {
  
  $("#dialog_log").UIdialogs_log_links();
 
  $(".open_log_update").UIdialogs_edit_logs_links();
  $(".new_log").validateWithErrors();

$(".slider_range").slider({
        range: true,
        min: 0,
        max: 1439,
        values: [ 740, 1020 ],
        step:10,
        slide: slideTime
    });
})