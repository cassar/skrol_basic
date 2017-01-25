// Request next string from the Server.
// Note User 1 currently hot coded.
function request_string(){
  $.ajax( "/slides/1" )
    .done(function(json) {
      stringArray.push(json.entry);
      requests_outstanding--;
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