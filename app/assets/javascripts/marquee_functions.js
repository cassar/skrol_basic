// Injects initial values into the DOM
function setup_marquee() {
  // Speed Inject
  $('#speedLabel').html(step);

  // Inject Initial Font Settings
  $('#frame').css('font-size', fontSize + 'em');
  $('#fontLabel').html(fontSize);

  // Marquee setup
  marquee = document.getElementById('marquee');
  slide = document.getElementById('slide');
  frame = document.getElementById('frame');
  marqueeWidth = marquee.clientWidth + 1;
  marginLeft = marqueeWidth;
  slideWidth = parseInt($('#slide').css('width'));
  marquee.style.marginLeft = marqueeWidth + 'px';
}

// Moves the marquee pased on the size of the step variable.
function increment_marquee() {
  marginLeft -= step;
  marquee.style.marginLeft = marginLeft + 'px';
}

// Makes sure the strings array has a minimum of MIN_ELEMENTS of elements in it.
function fill_string_arr() {
  if ((stringArray.length < MIN_ELEMENTS) && !request_pending) {
    request_pending = true;
    request_string();
  }
}

// Checks to see if a new slide needs to be added into the marquee, and inserts
// a new one from stringArray if needs be.
function check_for_insert() {
  if ((marginLeft + slideWidth + 1) <= marqueeWidth) {
    $('#slide').append(stringArray.shift());
    slideWidth = parseInt($('#slide').css('width'));
  }
}

// Maintains the stringArray and marquee queue
function back_end() {
  check_for_insert();
  fill_string_arr();
}

// Will run marquee and backend on 50 milisecond intervals
function start_marquee() {
  // Set the Go function to run every 50 miliseconds.
  setInterval(back_end, 50);
  setInterval(increment_marquee, 50);
}
