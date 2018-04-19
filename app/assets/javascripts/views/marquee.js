function initMarquee() {
  $('#frame').hover(checkForPause, checkForUnpause);
  initMarqueeDrag();
  $(window).resize(updateEntryPoint);
}

function reinitAfterInsert() {
  $('.slides:last .word').on('mouseover mouseout', toggleHighlight);
  if (notBlink()) {
    $('.slides:last .word').click(toggleHighlight);
  }
  $('.slides:last .base').click(unhideBase);
  $('.slides:last .base').addClass('hide');
  $('.slides:last .phnChar').hover(charOn, charOff);
  $('.slides:last .phnChar').click(playSound);
}

function initMarqueeDrag() {
  var frame = document.getElementById('frame');
  var frameInstance = new Hammer(frame);
  frameInstance.add( new Hammer.Pan({ direction: Hammer.DIRECTION_HORIZONTAL, threshold: 0 }) );
  frameInstance.on('pan', marqueeDrag);
}

function marqueeDrag(event){
  if (notDisabled()) {
    checkForPause();
    var newPosition = event.deltaX + getMarqueePosition();
    $('#marquee').css('margin-left', newPosition + 'px');
    if (event.isFinal) {
      updateMarqueePosition(newPosition);
    }
  }
}

function updateMarqueeView() {
  $('#marquee').css('margin-left', getMarqueePosition() + 'px');
}

function getMarqueeWidth() {
  return $('#marquee').width();
}

function getFrameWidth() {
  return $('#frame').width();
}

function cursorGrabbing() {
  return $('#frame').css('cursor').match('grabbing') != null;
}

function appendSlide(nextSlide) {
  $('#marquee').append(nextSlide);
}

function highlightOff() {
  $('.highlight').removeClass('highlight');
}

function hideBase() {
  $('.reveal').removeClass('reveal');
}

function charOn() {
  if (soundPresent($(this).text())) {
    $(this)
    .css('color', 'green')
    .css('cursor','default');
  }
}

function charOff() {
  $(this)
  .css('color', '')
  .css('cursor','');
}
