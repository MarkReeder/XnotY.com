jQuery(document).ready(function() {

  window.fbAsyncInit = function() {
    FB.init({
      appId: "409153285798797",
      status: true,
      cookie: true,
      xfbml: false,
      oauth: true
    });
    return true;
  };

  (function(d) {
    var id, js;
    id = 'facebook-jssdk';
    if (d.getElementById(id)) {
      return;
    }
    js = d.createElement('script');
    js.id = id;
    js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    return d.getElementsByTagName('head')[0].appendChild(js);
  })(document);

});
