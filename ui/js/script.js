let alertmenu = false;

function hideAlert(sound) {
    $("#alert-menu").fadeOut();
    alertmenu = false;
};

$(function () {
    window.addEventListener('message', function (event) {
        if (event.data.type == 'show-alert') {
            var sound = new Audio('audio/sound.mp3');
            sound.volume = event.data.volume
            
            if (alertmenu) return;

            let alertData = event.data.data
    
            $('.factionImage').attr('src', alertData.img);
            $('#title span').text(alertData.title);
    
            $("#message").html(alertData.message);
    
            $("#alert-menu").fadeIn(500);
            alertmenu = true;
            sound.play();

            setTimeout(() => {
                sound.pause();
                hideAlert();
            }, event.data.time);
        } else if (event.data.type == 'hide-alert') {
            hideAlert(sound);
        }
    });
});