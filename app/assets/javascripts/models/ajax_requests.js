// Request next string from the Server.
// Note User 1 currently hot coded.
function request_string(json) {
  console.log("Requesting for user_map_id: " + json['user_map_id']);
  $.ajax({
    method: "GET",
    url: "/next-slide",
    data: json
  })
  .done(function(json) {
    stringArray.push(json.entry);
    requestPending = false;
    console.log( "Slide successfully retrieved." );
  })
  .fail(function() {
    console.log( "Error: Could not retrieve next slide." );
  });
}

// Retrievs information on what informion is available from the server
function request_lang_info(json) {
  $.ajax({
    method: "GET",
    url: "/lang-info",
    data: json
  })
  .done(function(json) {
    userLangArr = json['info'];
    process_lang_info(json);
    console.log( json );
  })
  .fail(function() {
    console.log( "Error: Could not retrieve lang_info." );
  });
}

// Sends metrics back to the server
function send_metrics(json) {
  $.ajax({
    method: "POST",
    url: "/metrics",
    data: json
  })
  .done(function( msg ) {
    console.log( "Complete: metric saved " + msg["message"] );
  })
  .fail(function() {
    console.log( "Error: Could not save metric." );
  });
}

// Requests user scores and metrics be reset for new session
function request_session_reset(json) {
  $.ajax({
    method: "POST",
    url: "/reset-user-session",
    data: json
  })
  .done(function( msg ) {
    console.log( "Complete: " + msg["message"] );
  })
  .fail(function() {
    console.log( "Error: Could not reset user session." );
  });
}
