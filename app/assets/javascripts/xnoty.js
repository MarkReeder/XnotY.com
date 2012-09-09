jQuery(document).ready(function() {

  $('#pageContent').html(Hogan.compile($('#createEventTemplate').html()).render());

  $(document).on('submit', '#createEventForm', function(event) {
      event.preventDefault();
      $('.button-create-event').click();
  });

  $(document).on('click', '.button-create-event', function() {
    var eventTitle = $('#createEventTitle').val();
    $.post('/events.json', {
      'title': eventTitle
    }).done(function(data) {
      $('#pageContent').html(Hogan.compile($('#FacebookSendTemplate').html()).render(data));

      (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return; js = d.createElement(s);
        js.id = id; js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=" + window.XnotY.keys.fb;
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));

    }).fail(function() {
      $('#pageContent').html(Hogan.compile($('#FacebookConnectTemplate').html()).render());
    });
  });

  $(document).on('click', '.button-facebook-connect', function() {
    XnotY.Facebook.login(function() {
     $('#pageContent').html(Hogan.compile($('#FacebookSendTemplate').html()).render(data.event));
    });
  });

});
