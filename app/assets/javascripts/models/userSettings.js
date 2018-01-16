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
    url: "/user-info"
  })
  .done(function(json) {
    console.log( json );
    loadLangInfo(json['lang']);
    loadUserInfo(json['user']);
    if (enrolmentSet()) {
      checkSlideQueue();
    } else {
      transitionToSelect();
    }
  })
  .fail(function() {
    console.log( "Error: Could not retrieve lang_info." );
  });
}

// Requests user scores and metrics be reset for new session
function requestSessionReset() {
  $.ajax({
    method: "POST",
    url: "/reset-user-session"
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
    data: { 'new_setting': setting }
  })
  .done(function( msg ) {
    console.log( "Complete: " + msg["message"] );
  })
  .fail(function() {
    console.log( "Error: Could not update user setting." );
  });
}
