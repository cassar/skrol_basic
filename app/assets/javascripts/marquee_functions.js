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
  marqueeWidth = marquee.clientWidth + buffer;
  marginLeft = marqueeWidth;
  slideWidth = parseInt($('#slide').css('width'));
  marquee.style.marginLeft = marqueeWidth + 'px';
}

// Moves the marquee pased on the size of the step variable.
function increment_marquee() {
  if (stringArray.length > 1) {
    marginLeft -= step;
    marquee.style.marginLeft = marginLeft + 'px';
  }
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
  if ((marginLeft + slideWidth + buffer) <= marqueeWidth) {
    $('#slide').append(stringArray.shift());
    slideWidth = parseInt($('#slide').css('width'));
    reinit_sentence();
    add_sentence();
    monitor_sents();
  }
}

// Add latest sentence label to attrArray
function add_sentence() {
  var sent = $('.sentences:last-of-type')[0]
  var grp = sent.getAttribute('data-group');
  var wrd = sent.getAttribute('data-word');
  attrArray.push([grp, wrd]);
}

// Will send 3rd last sentence to clear_report 
function monitor_sents() {
  attrLength = attrArray.length;
  if (attrLength >= 3) {
    sent = attrArray[attrLength - 3];
    clear_report(sent[0], sent[1]);
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
