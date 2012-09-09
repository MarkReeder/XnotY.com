jQuery(document).ready(function() {

  var $pageContent = $('#pageContent'),
      $createEventTemplate = $('#createEventTemplate');
  if ($createEventTemplate.length) {
    $('#pageContent').html(Hogan.compile($createEventTemplate.html()).render());
  }

  $(document).on('submit', '#createEventForm', function(event) {
      event.preventDefault();
      $('.button-create-event').click();
  });

  $(document).on('click', '.button-create-event', function() {
    var eventTitle = $('#createEventTitle').val();
    $.post('/events.json', {
      'event' : {
        'title': eventTitle
      }
    }).done(function(data) {
      $('#pageContent').html(Hogan.compile($('#facebookSendTemplate').html()).render(data));
    }).fail(function() {
      $('#pageContent').html(Hogan.compile($('#facebookConnectTemplate').html()).render());
    });
  });

  $(document).on('click', '.button-facebook-connect', function() {
    XnotY.Facebook.login(function(data) {
      $('#pageContent').html(Hogan.compile($('#phoneNumberTemplate').html()).render(data));
    });
  });

  $(document).on('click', '.button-facebook-send', function() {
    var url = window.location.origin + '/' + $(this).attr('data-fb-send-url');
    XnotY.Facebook.send_message_modal(url);
  });

  $(document).on('click', '.button-phone-connect', function() {
    var phone_number = $('#phoneNumberInput').val();
    $.ajax({
      url: 'users/' + user_data.user_id + '.json',
      type: 'PUT',
      contentType: 'json',
      data: {
        user: {
          'cell_number' : phone_number
        }
      }
    }).done(function(data) {
      $('#pageContent').html(Hogan.compile($('#facebookSendTemplate').html()).render(data));
    });
  });



});
