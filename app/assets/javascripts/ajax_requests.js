// Request next string from the Server.
// Note User 1 currently hot coded.
function request_string(json) {
  $.ajax({
    method: "GET",
    url: "/next-slide",
    data: json
  })
  .done(function(json) {
    stringArray.push(json.entry);
    requestPending = false;
    console.log( json.entry );
  })
  .fail(function() {
    console.log( "Error" );
  })
  .always(function() {
    console.log( "Request Finished" );
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
    process_lang_info(json);
    console.log( json );
  })
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
  });
}
