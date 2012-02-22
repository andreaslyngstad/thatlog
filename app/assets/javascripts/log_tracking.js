jQuery.fn.tracking_logs_WithAjax = function() {
  this.submit(function() { 
    $.post(this.action, $(this).serialize(), null, "script"); 
    $('.spinning').show();
    return false;
  })
  return this;
};

jQuery.fn.stopwatch = function() {

    var clock = $(this);
    var timer = 0;
    clock.addClass('stopwatch');
    var h = clock.find('.hr');
    var m = clock.find('.min');
    var s = clock.find('.sec');
    timer = setInterval(do_time, 1000);
    function do_time() {
      // parseInt() doesn't work here...
      hour = parseFloat(h.text());
      minute = parseFloat(m.text());
      second = parseFloat(s.text());
      second++;
      if(second > 59) {
        second = 0;
        minute = minute + 1;
      }
      if(minute > 59) {
        minute = 0;
        hour = hour + 1;
      }
      h.html("0".substring(hour >= 10) + hour);
      m.html("0".substring(minute >= 10) + minute);
      s.html("0".substring(second >= 10) + second);
    }
  };

$(document).ready(function() {
	$(".start_tracking_form").tracking_logs_WithAjax();
	
	$(".clock_rec").stopwatch();
	$(".stop_tracking_form").tracking_logs_WithAjax();
});	