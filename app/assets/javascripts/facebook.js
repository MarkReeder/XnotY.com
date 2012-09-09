jQuery(document).ready(function() {

  if (!window.XY) {
    window.XY = {};
  }

  XY.Facebook = {

      login : function(callback) {
          var self = this;
          self.callback = callback;

          if (FB) {
              FB.login(function(response) {
                  self.status = response.status;
                  self.oauth_token = response.authResponse.accessToken;
                  if (self.status === 'connected') {
                    self.fetch_user_data(self.callback);
                  } else {
                      console.log('facebook auth fail');
                  }
              }, {
                  scope: 'email,publish_actions'
              });
          }
      },

      fetch_user_data : function(callback) {
        var self = this;
        self.callback = callback;

        if (FB) {
            FB.api('/me', function(user_data) {
                XY.fb_data = {
                    'email' : user_data.email,
                    'first_name' : user_data.first_name,
                    'last_name' : user_data.last_name
                };
                $.publish('facebook_connect');
            });
        }
      }

  };

});
