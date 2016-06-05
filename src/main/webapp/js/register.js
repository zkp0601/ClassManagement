jQuery(document).ready(function() {

    $('.page-container form').submit(function(){
        var username = $(this).find('.username').val();
        var name = $(this).find('.name').val();
        var email = $(this).find('.email').val();
        var password = $(this).find('.password').val();
        var pass_confirm = $(this).find('.pass_confirm').val();
        if(username == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '27px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.username').focus();
            });
            return false;
        }
        if(name == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '96px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.name').focus();
            });
            return false;
        }
        if(email == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '372px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.email').focus();
            });
            return false;
        }
        if(password == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '441px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.password').focus();
            });
            return false;
        }
        if(pass_confirm == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '510px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.pass_confirm').focus();
            });
            return false;
        }
        if(password != pass_confirm){
        	$(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '510px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.pass_confirm').focus();
            });
            return false;
        }
    });

    $('.page-container form .username, .page-container form .password').keyup(function(){
        $(this).parent().find('.error').fadeOut('fast');
    });

});