// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(document).ready(function() {

  var $pageContent = $('#pageContent'),
      $eventLoginTemplate = $('#eventLoginTemplate'),
      eventID = window.location.pathname.split('/events/')[1],
      eventDetails = null;
      $inviteTemplate = $('#invitesTemplate');
  if ($eventLoginTemplate.length) {
    $('#pageContent').html(Hogan.compile($eventLoginTemplate.html()).render());
  }

  if ($inviteTemplate.length) {
    var eventID = window.location.pathname.split('/events/')[1];
    $.getJSON('/events/' + eventID + '/invites', function(data) {

    });
  }

  $.getJSON('/events/' + eventID + '.json', function(data) {
      eventDetails = data.event;
      if(eventDetails.is_attending) {
        $('#pageContent').html(Hogan.compile($('#eventDetailsTemplate').html()).render(eventDetails));
      } else if ($eventLoginTemplate.length) {
        $('#pageContent').html(Hogan.compile($eventLoginTemplate.html()).render());
      }
  });
  
  $(document).on('click', '.button-facebook-connect-join', function(data) {
    XnotY.Facebook.login(function(data) {
      $('#pageContent').html(Hogan.compile($('#eventPhoneNumberTemplate').html()).render(data));
    });
  });
  $(document).on('submit', '#phoneNumberForm', function(event) {
      event.preventDefault();
      $('.button-phone-connect-join').click();
  });
    $(document).on('click', '.set-event-location', function(event) {
        var locationName = $(event.target).data('location-name');
        event.preventDefault();
        $.ajax({
            url: '/events/' + eventID + '.json',
            type: 'PUT',
            contentType: 'json',
            data: {
                event: {
                    'location' : locationName
                }
            }
        })
    });
    $(document).on('click', '.button-phone-connect-join', function() {
      var phone_number = $('#phoneNumberInput').val();
      $.ajax({
        url: '/users/' + user_data.user_id + '.json',
        type: 'PUT',
        contentType: 'json',
        data: {
          user: {
            'cell_number' : phone_number
          }
        }
      }).done(function(data) {
        $.post('/events/' + eventID + '/join').done(function(data) {
          $('#pageContent').html(Hogan.compile($('#eventDetailsTemplate').html()).render(data));
        });
      });

    });

});
