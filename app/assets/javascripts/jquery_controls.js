// Sets all jquery listeners for the DOM
function init_jquery_controls() {
  // Creates a lister for whene the mouse hover's over the marquee
  // That it will pause whene over and resume when it leaves.
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

  // Decrements step to slow marquee down.
  $('#lessSpeed').click(function(){
    if (interval < MAX_INTERVAL) {
      interval += INTERVAL_INCREMENT;
      if (skroling && !disabled) {
        restart_front_end();
      }
      $('#speedLabel').html(speed_level());
    }
  });

  // Increments step to speed up marquee.
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

  // Decrements fontSize variable and pushes change to DOM.
  // $('#smallerFont').click(function(){
  //   fontSize--;
  //   $('#frame').css('font-size', fontSize + 'em');
  //   $('#fontLabel').html(fontSize);
  //   slideWidth = parseInt($('#slide').css('width'));
  // });

  // Increments fontSize variable and pushes change to DOM.
  // $('#largerFont').click(function(){
  //   fontSize++;
  //   $('#frame').css('font-size', fontSize + 'em');
  //   $('#fontLabel').html(fontSize);
  //   slideWidth = parseInt($('#slide').css('width'));
  // });

  // Sets action of Stopped and Scrolling buttons to pause and resume actions.
  $('#stop-start').click(function(){
    if (skroling) {
      stop_front_end();
      skroling = false;
      change_to_paused();
    } else {
      start_front_end();
      change_to_skroling();
      skroling = true;
    }
  });

  // Toggles the base script color between black and white
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

  // Sets the action of the mouse pointer to grab and drag the marquee.
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

// Reinitiates events on sentence elements.
function reinit_sentence() {
  $('.word').hover(
    function() {
      start = Date.now();
    },
    function() {
      end = Date.now();
      var diff = end - start
      if ($(this).parent().hasClass('target') && diff > HOVER_WAIT) {
        var data_group = $(this).parent().parent().attr('data-sentence-group');
        var data_word = $(this).attr('data-word-id');
        send_report(data_group, data_word, true);
      }
    }
  );

  // Switches word elements to bootstrap primary color
  // @brand-primary: darken(#428bca, 6.5%); #337ab7
  $('.word').hover(
    function() {
      // Don't do this if the base sentence is hovered over but hidden.
      if ($(this).parent().hasClass('target') || !baseHidden) {
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
