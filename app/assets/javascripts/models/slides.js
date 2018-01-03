var slideQueue = [];

var requestPending = false;

function getNextSlide() {
  var nextSlide = slideQueue.shift();
  checkSlideQueue();
  return nextSlide;
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
  if (slideQueue.length < MAX_ELEMENTS && requestNotPending()) {
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
    console.log(json)
    addToSlideQueue(json);
    console.log( "Success: Slide successfully retrieved." );
  })
  .fail(function() {
    // [Fix: Would like a system here for waiting before next request.]
    console.log( "Error: Could not retrieve next slide." );
  })
  .always(function() {
    toggleRequestPending();
    checkEnoughSlides();
    checkSlideQueue();
  });
}
