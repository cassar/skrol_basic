// Marquee Variables
var entryPoint;
var marqueePosition;

// The old X axis position of the marquee when the mouse was moved.
var oldXpos;

var slideMonitorId = TIME_OUT_NOT_SET;

function updateEntryPoint() {
  entryPoint = getMarqueeWidth() + BUFFER;
}

// Initiate Marquee
function initEngine() {
  updateEntryPoint();
  marqueePosition = entryPoint;
  updateMarqueePosition();
}

function isTouchScreen() {
  return 'ontouchstart' in window;
}

function getMarqueePosition() {
  return marqueePosition;
}

function moveMarquee(event){
  var newXpos = event.pageX;
  if (cursorGrabbing() && notDisabled()) {
    marqueePosition += newXpos - oldXpos;
    updateMarqueePosition();
  }
  oldXpos = newXpos;
}

// Moves the marquee based on the size of the step variable.
function incrementMarquee() {
  marqueePosition -= STEP;
  updateMarqueePosition();
}

// Checks to see if a new slide needs to be added into the marquee, and inserts
// a new one from slideQueue if needs be.
function checkForInsert() {
  if (((marqueePosition + getSlideWidth() + BUFFER) <= entryPoint)) {
    if (checkEnoughSlides()) {
      var nextSlide = getNextSlide();
      appendSlide(nextSlide['slide']);
      reinitAfterInsert();
      addSlideInfo(nextSlide['metrics']);
      retrieveSounds(nextSlide['phn_chars'])
      reportResults();
      checkForMeterUpdate();
    }
  }
}

function startSlideMonitor() {
  if (slideMonitorId == TIME_OUT_NOT_SET) {
    slideMonitorId = setInterval(checkForInsert, SLIDE_MONITOR_INTERVAL);
  }
}

function stopSlideMonitor() {
  if (slideMonitorId != TIME_OUT_NOT_SET) {
    clearInterval(slideMonitorId);
    slideMonitorId = TIME_OUT_NOT_SET;
  }
}
