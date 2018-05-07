var lastCount;

function checkForMeterUpdate() {
  if ((slideCount() % METER_CHECK) == 0) {
    retrieveMeter();
  }
}

function applyMeterUpdate(meterUpdate) {
  if (lastCount == null || meterUpdate < lastCount) {
    lastCount = meterUpdate;
    updateMeterButton(meterUpdate + ' hours till completion');
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
      applyMeterUpdate(json['meter']);
    })
    .fail(function() {
      updateMeterButton('-');
    });
  }
}
