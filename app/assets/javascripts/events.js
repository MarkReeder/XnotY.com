// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(document).ready(function() {

  var $pageContent = $('#pageContent'),
      $eventLoginTemplate = $('#eventLoginTemplate');
  if ($eventLoginTemplate.length) {
    $('#pageContent').html(Hogan.compile($eventLoginTemplate.html()).render());
  }

  $(document).on('click', '.button-facebook-connect-join', function() {
    XnotY.Facebook.login(function(data) {
      var eventID = window.location.pathname.split('/events/')[1];
      $.post('/events/' + eventID + '/join').done(function() {
        $('#pageContent').html(Hogan.compile($('#eventDetailsTemplate').html()).render(data));
      });
    });
  });

});
