// Reinitiates events on sentence elements.
function reinit_sentence() {
  reinit_word_report();
  reinit_word_highlight();
}

// Creates a lister for when the mouse hover's over the marquee
// That it will pause when over and resume when it leaves.
function init_pause_frame_hover() {
  $('#frame').hover(
    function () {
      if (skroling && !disabled) {
        stop_front_end();
        change_to_paused();
      }
    },
    function () {
      if (skroling && !disabled) {
        start_front_end();
        change_to_skroling();
      }
    }
  );
}

function init_speed_buttons() {
  // Increases interval to slow down marquee
  $('#lessSpeed').click(function(){
    if (interval < MAX_INTERVAL) {
      interval += INTERVAL_INCREMENT;
      if (skroling && !disabled) {
        restart_front_end();
      }
      $('#speedLabel').html(speed_level());
    }
  });

  // Decreases interval to speed up marquee.
  $('#moreSpeed').click(function(){
    if (interval > MIN_INTERVAL) {
      interval -= INTERVAL_INCREMENT;
      if (skroling && !disabled) {
        stop_front_end();
        start_front_end();
      }
      $('#speedLabel').html(speed_level());
    }
  });
}

// Sets action of Stopped and Scrolling buttons to pause and resume actions.
function init_pause_button() {
  $('#stop-start').click(function(){
    if (skroling) {
      stop_front_end();
      change_to_paused();
      skroling = false;
    } else {
      start_front_end();
      change_to_skroling();
      skroling = true;
    }
  });
}

// Toggles the base script color between black and white
function init_hide_base() {
  $('#hide-base').click(function(){
    if (baseHidden) {
      baseColour = 'black';
      $('.base').css('color', baseColour);
      $('#hide-base').html('Showing');
      $('#hide-base').removeClass('btn-default');
      $('#hide-base').addClass('btn-primary');
      baseHidden = false;
    } else {
      baseColour = 'white';
      $('.base').css('color', baseColour);
      $('#hide-base').html('Hidden');
      $('#hide-base').removeClass('btn-primary');
      $('#hide-base').addClass('btn-default');
      baseHidden = true;
    }
  });
}

// Sets the action of the mouse pointer to grab and drag the marquee.
function init_mouse_move_slide() {
  $('#frame').mousemove(function(event){
    cursor = $('#frame').css('cursor');
    if ((cursor == 'grabbing') && !disabled) {
      newX = event.pageX;
      diff = newX - oldX;
      marginLeft += diff;
      marquee.style.marginLeft = marginLeft + 'px';
    }
    oldX = event.pageX;
  });
}

// Sends word report when ever a target or phonetic word is hovered on for more
// than the HOVER_WAIT
function reinit_word_report() {
  $('.word').hover(
    function() {
      start = Date.now();
    },
    function() {
      end = Date.now();
      var diff = end - start
      if (!$(this).parent().hasClass('base') && diff > HOVER_WAIT) {
        var data_word;
        if ($(this).parent().hasClass('target')) {
          data_word = $(this).attr('data-word-id');
        } else {
          data_word = $(this).attr('data-word-assoc');
        }
        var data_group = $(this).parent().parent().attr('data-sentence-group');
        var data_map = $(this).parent().parent().attr('data-usermap-id');
        send_report(data_group, data_word, data_map, true);
      }
    }
  );
}

// Switches word elements to bootstrap primary color
// @brand-primary: darken(#428bca, 6.5%); #337ab7
function reinit_word_highlight() {
  $('.word').hover(
    function() {
      // Don't do this if the base sentence is hovered over but hidden.
      if (!$(this).parent().hasClass('base') || !baseHidden) {
        var data_word_group = $(this).attr('data-word-group');
        $('*[data-word-group="' + data_word_group + '"]').css('color', '#337ab7');
      }
    },
    function(event) {
      var data_word_group = $(this).attr('data-word-group');
      $('*[data-word-group="' + data_word_group + '"]').css('color', '');
    }
  );
  // Sets the base sentence color to its current setting
  $('.base').css('color', baseColour);
}
