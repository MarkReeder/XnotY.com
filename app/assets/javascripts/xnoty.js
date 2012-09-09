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
    }).done(function() {
      $('#pageContent').html(Hogan.compile($('#FacebookSendTemplate').html()).render());
    }).fail(function() {
      $('#pageContent').html(Hogan.compile($('#FacebookConnectTemplate').html()).render());
    });
  });

  $(document).on('click', '.button-facebook-connect', function() {
    XnotY.Facebook.login(function() {
     $('#pageContent').html(Hogan.compile($('#FacebookSendTemplate').html()).render());
    });
  });

});
