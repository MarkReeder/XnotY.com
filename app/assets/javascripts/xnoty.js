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
    }).fail(function() {
      $('#pageContent').html(Hogan.compile($('#FacebookConnectTemplate').html()).render());
    });
  });

  $(document).on('click', '.button-facebook-connect', function() {
    XnotY.Facebook.login(function() {
     $('#pageContent').html(Hogan.compile($('#FacebookSendTemplate').html()).render(data));
    });
  });

  $(document).on('click', '.button-facebook-send', function() {
    var url = window.location.origin + '/' + $(this).attr('data-fb-send-url');
    XnotY.Facebook.send_message_modal(url);
  });

});
