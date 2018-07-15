jQuery(function() {
  return $.ajax({
    url: 'https://apis.google.com/js/client:plus.js?onload=gpAsyncInit',
    dataType: 'script',
    cache: true
  });
});

window.gpAsyncInit = function() {
  gapi.auth.authorize({
    immediate: true,
    response_type: 'code',
    cookie_policy: 'single_host_origin',
    client_id: '561113342907-r3soorsio8ohuvi1pkboh9o3cf8pk791.apps.googleusercontent.com',
    scope: 'email profile'
  }, function(response) {
    return;
  });
  $('.googleplus-login').click(function(e) {
    e.preventDefault();
    gapi.auth.authorize({
      immediate: false,
      response_type: 'code',
      cookie_policy: 'single_host_origin',
      client_id: '561113342907-r3soorsio8ohuvi1pkboh9o3cf8pk791.apps.googleusercontent.com',
      scope: 'email profile'
    }, function(response) {
      if (response && !response.error) {
        // google authentication succeed, now post data to server.
        jQuery.ajax({type: 'POST', url: '/auth/google_oauth2/callback', data: response,
          success: function(data) {
            console.log("Signon success.");
          }
        });
      } else {
        console.log("Signon failure.");
      }
    });
  });
};
