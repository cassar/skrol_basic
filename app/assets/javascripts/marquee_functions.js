// Injects initial values into the DOM
function setup_marquee() {
  // Speed Inject
  $('#speedLabel').html(speed_level());

  // Inject Initial Font Settings
  // $('#frame').css('font-size', fontSize + 'em');
  // $('#fontLabel').html(fontSize);

  // Cleans up Legacy Scores and Metrics
  reset_user_session();

  // Marquee setup
  marquee = document.getElementById('marquee');
  slide = document.getElementById('slide');
  frame = document.getElementById('frame');
  marqueeWidth = marquee.clientWidth + BUFFER;
  marginLeft = marqueeWidth;
  slideWidth = parseInt($('#slide').css('width'));
  marquee.style.marginLeft = marqueeWidth + 'px';
}

// Resets the user session so words can be freshly retested
function reset_user_session() {
  json = {};
  json['user_map_id'] = user_map_id;
  request_session_reset(json);
}

// Returns the current speed level
function speed_level() {
  return (NORMAL_INTERVAL * 2) - interval;
}

// Checks if the marquee is able to be incremented and then executes.
function check_for_increment() {
  if (stringArray.length > 1) {
    if (disabled) {
      set_from_disabled();
      start_front_end();
    }
  } else {
    if (!disabled) {
      set_to_disabled();
      stop_front_end();
    }
  }
}

// Moves the marquee based on the size of the step variable.
function increment_marquee() {
  marginLeft -= STEP;
  marquee.style.marginLeft = marginLeft + 'px';
}

// Set button and boolean from loading state
function set_from_disabled() {
  disabled = false;
  $('#stop-start').removeAttr('disabled');
  if (!skroling) {
    change_to_paused();
  } else {
    change_to_skroling();
  }
}

// Set button and boolean to loading state
function set_to_disabled() {
  disabled = true;
  $('#stop-start').attr('disabled', 'true');
  change_to_loading();
}

// Change button #stop_start button to Paused
function change_to_paused() {
  $('#stop-start').html('Paused');
  $('#stop-start').removeClass();
  $('#stop-start').addClass('btn btn-default');
}

// Change button #stop_start button to Skroling
function change_to_skroling() {
  $('#stop-start').html('Skroling');
  $('#stop-start').removeClass();
  $('#stop-start').addClass('btn btn-primary');
}

// Change button #stop_start button to Loading
function change_to_loading() {
  $('#stop-start').html('Loading');
  $('#stop-start').removeClass();
  $('#stop-start').addClass('btn btn-warning');
}

// Makes sure the strings array has a minimum of MIN_ELEMENTS of elements in it.
function fill_string_arr() {
  if ((stringArray.length < MIN_ELEMENTS) && !request_pending) {
    request_pending = true;
    var json = {'user_map_id': user_map_id};
    request_string(json);
  }
}

// Checks to see if a new slide needs to be added into the marquee, and inserts
// a new one from stringArray if needs be.
function check_for_insert() {
  if ((marginLeft + slideWidth + BUFFER) <= marqueeWidth) {
    $('#slide').append(stringArray.shift());
    slideWidth = parseInt($('#slide').css('width'));
    reinit_sentence();
    add_sentence();
    monitor_sents();
  }
}

// Add latest sentence label to attrArray
function add_sentence() {
  var sent = $('.sentences:last-of-type');
  var grp = sent.attr('data-sentence-group');
  attrArray.push(grp);
}

// Will send 3rd last sentence to clear_report
function monitor_sents() {
  attrLength = attrArray.length;
  if (attrLength >= 3) {
    var sentGroup = attrArray[attrLength - 3];
    var targetSent = $('*[data-sentence-group="' + sentGroup + '"]').children()[0];
    var words = targetSent.children;
    var length = words.length
    for (var i = 0; i < length; i++) {
      wordId = words[i].getAttribute('data-word-id');
      send_report(sentGroup, wordId, false);
    }
  }
}

// Maintains the stringArray and marquee queue
function back_end() {
  check_for_insert();
  fill_string_arr();
  check_for_increment();
}

// stops the setInterval set for the frontend
function stop_front_end() {
  clearInterval(frontTimeOutId);
}

// starts the setInterval set for the frontend
function start_front_end() {
  frontTimeOutId = setInterval(increment_marquee, interval);
}

// restarts frontend
function restart_front_end() {
  stop_front_end();
  start_front_end();
}

// Will run marquee and backend on 50 milisecond intervals
function start_marquee() {
  // Set the Go function to run every 50 miliseconds.
  setInterval(back_end, 50);
}
