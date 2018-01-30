function checkForMeterUpdate() {
  if ((slideCount() % METER_CHECK) == 0) {
    retrieveMeter();
  }
}

function retrieveMeter() {
  if (getEnrolmentId() != NO_ENROLMENT_SET) {
    $.ajax({
      method: "POST",
      url: "/meter",
      data: { 'enrolment_id': getEnrolmentId() }
    })
    .done(function( json ) {
      updateMeterButton(json['meter'] + ' till completion');
    })
    .fail(function() {
      updateMeterButton('-');
    });
  }
}
