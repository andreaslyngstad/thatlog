//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.8.7custom.min
//= require jquery.ui.selectmenu
//= require_self


jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

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

jQuery.fn.open_not_required = function(){
	 $(this).click(function(){
  	$(".not_required").slideToggle();
  	$(".open_not_required").toggleClass("close_not_required");
  	return false
  });
};

$(document).ready(function() {
	$(".start").hover(function(){
		$(this).toggleClass("on")
	})
	$(".start").live("click", function(){
		$(this).hide();
		$(".play_a_video").hide();
		$(".video_container").show();
		$(".video_container").addClass("on")
		$(".video_container").append('<iframe src="http://player.vimeo.com/video/30698649?title=0&amp;byline=0&amp;portrait=0&autoplay=1&byline=0" width="640" height="360" frameborder="0" webkitAllowFullScreen allowFullScreen></iframe>')
	
	})
	var box = $('.hide');
        var link = $('#login_link');

        link.click(function() {
            box.slideDown(); return false;
        });

        $(document).click(function() {
            box.slideUp();
        });

        box.click(function(e) {
            e.stopPropagation();
        });
	
	
	$(".register_firm_subdomain").validates_uniqe();
	$(".open_not_required_container").open_not_required();
	$(".signup select, .update select").selectmenu({width:364});
})