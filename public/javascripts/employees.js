$(document).ready(function() {
  $("#dialog_employees").UIdialogs_links();
  $("#dialog_employees_form").UIdialogs();
  $(".open_employee_update").UIdialogs_edit_links();
  $(".new_employee").validateWithErrors();
})