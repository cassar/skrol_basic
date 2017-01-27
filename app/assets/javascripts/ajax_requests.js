// Request next string from the Server.
// Note User 1 currently hot coded.
function request_string(){
  $.ajax( "/slides/1" )
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
