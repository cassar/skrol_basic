// Sets all jquery listeners for the DOM
function init_jquery_controls() {
  // Creates a lister for whene the mouse hover's over the marquee
  // That it will pause whene over and resume when it leaves.
  if (frame.addEventListener) {
      frame.addEventListener('mouseenter', function () {
          if (skrolling) {
            prePause = step;
            step = 0;
            $('#stop-start').html('Stopped');
          }
      }, false);
      frame.addEventListener('mouseleave', function () {
        if (skrolling) {
          step = prePause
          $('#stop-start').html('Scrolling');
        }
      }, false);
  }

  // Decrements step to slow marquee down.
  $('#lessSpeed').click(function(){
    step--;
    $('#speedLabel').html(step);
  });

  // Increments step to speed up marquee.
  $('#moreSpeed').click(function(){
    step++;
    $('#speedLabel').html(step);
  });

  // Decrements fontSize variable and pushes change to DOM.
  $('#smallerFont').click(function(){
    fontSize--;
    $('#frame').css('font-size', fontSize + 'em');
    $('#fontLabel').html(fontSize);
    slideWidth = parseInt($('#slide').css('width'));
  });

  // Increments fontSize variable and pushes change to DOM.
  $('#largerFont').click(function(){
    fontSize++;
    $('#frame').css('font-size', fontSize + 'em');
    $('#fontLabel').html(fontSize);
    slideWidth = parseInt($('#slide').css('width'));
  });

  // Sets action of Stopped and Scrolling buttons to pause and resume actions.
  $('#stop-start').click(function(){
    if (skrolling) {
      prePause = step;
      step = 0;
      skrolling = false;
      $('#stop-start').html('Stopped');
    } else {
      step = prePause
      $('#stop-start').html('Scrolling');
      skrolling = true;
    }
  });

  // Sets the action of the mouse pointer to grab and drag the marquee.
  $('#frame').mousemove(function(event){
    cursor = $('#frame').css('cursor');
    if (cursor == 'grabbing') {
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
  $('.sentences').hover(function(){
    var data_group = $(this)[0].getAttribute('data-group');
    var data_word = $(this)[0].getAttribute('data-word');
    hover_report(data_group, data_word);
  });
}
