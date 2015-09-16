/**
 * Created by JoseAntonio on 16/09/2015.
 */
$(document).ready(function() {
    $('.marginleftpick').hover(function() {
        $(this).children('.showhideparent').children('.showhide').css({"opacity":1});
    }, function() {
        $(this).children('.showhideparent').children('.showhide').css({"opacity":0});
    });
});


