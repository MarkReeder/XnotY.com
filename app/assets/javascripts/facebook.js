jQuery(document).ready(function() {

  if (!window.XnotY) {
    window.XnotY = {};
  }

  XnotY.Facebook = {

      login : function(callback) {
          var self = this;
          self.callback = callback;

          if (FB) {
              FB.login(function(response) {
                  self.status = response.status;
                  self.oauth_token = response.authResponse.accessToken;
                  self.user_id = response.authResponse.userID;
                  if (self.status === 'connected') {
                    self.post_user_data(self.callback);
                  } else {
                      console.log('facebook auth fail');
                  }
              }, {
                  scope: 'email,publish_actions'
              });
          }
      },

      post_user_data : function(callback) {
        var self = this;
        $.post('/facebook',
        {
          'code' : self.oauth_token,
          'facebook_id' : self.user_id
        }, function(data) {
          window.user_data = data;
          if (typeof self.callback === 'function') {
            self.callback();
          }
        });
      },

      fetch_user_data : function(callback) {
        var self = this;
        self.callback = callback;

        if (FB) {
            FB.api('/me', function(user_data) {
                XnotY.fb_data = {
                    'email' : user_data.email,
                    'first_name' : user_data.first_name,
                    'last_name' : user_data.last_name
                };
                $.publish('facebook_connected');
            });
        }
      },

      send_message_modal : function(url) {
        FB.ui({
          method: 'send',
          name: 'X not Y',
          link: url
        });
      }

  };

});
