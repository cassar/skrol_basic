// User settings.
var userId = DEFAULT_USER;

// Assigns variables based on retrieved user info
function loadUserInfo(user) {
  setBaseHidden(user['base_hidden']);
  setSpeed(user['current_speed']);
  setEnrolmentId(user['current_enrolment']);
}

// Retrieves information on what informion is available from the server
function requestUserInfo() {
  $.ajax({
    method: "GET",
    url: "/user-info",
    data: { 'user_id': userId }
  })
  .done(function(json) {
    console.log( json );
    loadLangInfo(json['lang']);
    loadUserInfo(json['user']);
    // [Fix: waste of time, see if the first slide can be sent with lang/user info]
    checkSlideQueue();
  })
  .fail(function() {
    console.log( "Error: Could not retrieve lang_info." );
  });
}

// Requests user scores and metrics be reset for new session
function requestSessionReset() {
  $.ajax({
    method: "POST",
    url: "/reset-user-session",
    data: { 'user_id': userId }
  })
  .done(function( msg ) {
    console.log( "Complete: " + msg["message"] );
  })
  .fail(function() {
    console.log( "Error: Could not reset user session." );
  });
}

// Updates a user setting back at the server so it persists
function updateUserSetting(setting) {
  $.ajax({
    method: "POST",
    url: "/update-user-setting",
    data: {'user_id': userId, 'new_setting': setting }
  })
  .done(function( msg ) {
    console.log( "Complete: " + msg["message"] );
  })
  .fail(function() {
    console.log( "Error: Could not update user setting." );
  });
}
