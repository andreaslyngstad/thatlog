(function($) {
	jQuery.fn.stopwatch = function() {
		var clock = $(this);
		var timer = 0;
		var logform = $(".log_form")
		var logformrec = $(".log_form_rec")
		var tracking_select = $(".tracking_select")
		clock.addClass('stopwatch');
		
		
		var h = clock.find('.hr');
		var m = clock.find('.min');
		var s = clock.find('.sec');
		var start = logform.find('.start_button');
		var stop = logform.find('.stop_button');
		var reset = clock.find('.reset')
		
		stop.hide();
		//logformrec.hide();

		start.bind('click', function() {
			timer = setInterval(do_time, 1000);
			logform.removeClass('blue').addClass('red');
			tracking_select.removeClass('blue').addClass('red');
			$(this).removeClass("start").addClass("stop");
			
		});
		
		logform.find('.stop').bind('click', function() {
			clearInterval(timer);
			timer = 0;
			h.html("00");
      m.html("00");
      s.html("00");
      
      logform.removeClass('red').addClass('blue');
      tracking_select.removeClass('red').addClass('blue');
			
      
		});
		
		reset.bind('click', function() {
			clearInterval(timer);
			timer = 0;
			h.html("00");
			m.html("00");
			s.html("00");
			stop.hide();
			start.show();
		});
		
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
	}
})(jQuery);