$(document).ready(function() {
	
  $(window).bind( 'hashchange', function(e) {
  	
    var url = e.fragment;
    var id = ("#" + url)
    $( '#sub_tabs li.active' ).removeClass( 'active' );
    url && $( 'a[href="#' + url + '"]' ).parent().addClass( 'active' );
    $(id).siblings().addClass("hide");
	$(id).removeClass("hide");
	if (url === ""){
	$( '#sub_tabs li:first' ).addClass( 'active' );
	}
    })
  $(window).trigger( 'hashchange' );
  
	
})