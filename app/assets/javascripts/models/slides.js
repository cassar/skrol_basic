var slideQueue = [];

var requestPending = false;

var complete = false;

function getNextSlide() {
  var nextSlide = slideQueue.shift();
  checkSlideQueue();
  return nextSlide;
}

function isComplete() {
  return complete;
}

function resetComplete() {
  complete = false;
}

function requestNotPending() {
  return !requestPending;
}

function toggleRequestPending() {
  requestPending = !requestPending;
}

function addToSlideQueue(slide) {
  slideQueue.push(slide);
}

// [Fix: don't hard code,]
function enoughSlides() {
  return slideQueue.length > EMPTY;
}

// Makes sure the strings array has a minimum of MIN_ELEMENTS of elements in it.
function checkSlideQueue() {
  if (slideQueue.length < MAX_ELEMENTS && requestNotPending() && !complete) {
    requestSlide();
  }
}

function emptySlideQueue() {
  slideQueue = [];
  checkSlideQueue();
}

// Request next slide from the Server.
function requestSlide() {
  toggleRequestPending();
  $.ajax({
    method: "GET",
    url: "/next-slide",
    data: { 'enrolment_id': getEnrolmentId() }
  })
  .done(function(json) {
    if (json['service'] == 'GOOD') {
      console.log( "Success: Slide successfully retrieved." );
      console.log(json);
      addToSlideQueue(json);
      checkSlideQueue();
      checkEnoughSlides();
    } else {
      console.log( "Course complete. No more Slides.")
      complete = true;
      if (isDisabled()) {
        changeToComplete();
      }
    }
  })
  .fail(function() {
    // [Fix: Would like a system here for waiting before next request.]
    console.log( "Error: Could not retrieve next slide. Recheck in 10 secs" );
    setTimeout(checkSlideQueue, 10000);
  })
  .always(function() {
    toggleRequestPending();
  });
}
