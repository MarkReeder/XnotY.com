jQuery(document).ready(function() {

  $(document).on('click', '.button-create-event', function() {
    var eventTitle = $('#createEventTitle').val();

    $.post('/events', {
      'title': eventTitle
    }, function() {

    });
  });

  $(document).on('click', '.button-facebook-connect', function() {
    XnotY.Facebook.login();
  });

});
