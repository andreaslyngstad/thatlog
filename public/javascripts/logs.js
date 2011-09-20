$(document).ready(function() {
  $("select#logs_pr_date_select").logs_pr_date_select();
  $("#dialog_log").UIdialogs_log_links();
  $(".small_selector").selectmenu({width:200});
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
})