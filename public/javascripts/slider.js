function slideTime(event, ui){
    var minutes0 = parseInt($("#slider_range").slider("values", 0) % 60);
    var hours0 = parseInt($("#slider_range").slider("values", 0) / 60 % 24);
    var minutes1 = parseInt($("#slider_range").slider("values", 1) % 60);
    var hours1 = parseInt($("#slider_range").slider("values", 1) / 60 % 24);
    $("#log_times_from").val(getTime(hours0, minutes0));
    $("#log_times_to").val(getTime(hours1, minutes1));
    $("#time").text(getTime(hours0, minutes0) + ' - ' + getTime(hours1, minutes1));
}
 
function getTime(hours, minutes) {
    var time = null;
    minutes = minutes + "";  
    if (minutes.length == 1) {
        minutes = "0" + minutes;
    }
    return hours + ":" + minutes;
}

