// Request next string from the Server.
// Note User 1 currently hot coded.
function request_string(json){
  $.ajax({
    method: "GET",
    url: "/next-slide",
    data: json
  })
  .done(function(json) {
    stringArray.push(json.entry);
    request_pending = false;
    console.log( json.entry );
    console.log( "Success" );
  })
  .fail(function() {
    console.log( "Error" );
  })
  .always(function() {
    console.log( "Request Finished" );
  });
}

// Sends metrics back to the server
function send_metrics(json){
  $.ajax({
    method: "POST",
    url: "/metrics",
    data: json
  })
  .done(function( msg ) {
    console.log( "Complete: " + msg["message"] );
  });
}

// Requests user scores and metrics be reset for new session
function request_session_reset(json){
  $.ajax({
    method: "POST",
    url: "/reset-user-session",
    data: json
  })
  .done(function( msg ) {
    console.log( "Complete: " + msg["message"] );
  });
}
