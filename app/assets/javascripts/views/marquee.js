function initMarquee() {
  $('#frame').hover(checkForPause, checkForUnpause);
  initFrameDrag();
  $(window).resize(updateEntryPoint);
}

function initFrameDrag() {
  var frame = document.getElementById('frame');
  var frameInstance = new Hammer(frame);
  frameInstance.add( new Hammer.Pan({ direction: Hammer.DIRECTION_HORIZONTAL, threshold: 0 }) );
  frameInstance.on('pan', marqueeDrag);
}

function reinitAfterInsert() {
  $('.word').hover(timerOn, timerOff);
  $('.word').hover(highlightOn, highlightOff);
  $('.word').click(toggleHighlight);
  $('.base').mousedown(checkUnhideBase).mouseup(checkHideBase);
  $('.phnChar').hover(charOn, charOff);
  $('.phnChar').click(playSound);
  applyBaseColour();
}

function marqueeDrag(event){
  if (notDisabled()) {
    checkForPause();
    var newPosition = event.deltaX + getMarqueePosition();
    $('#marquee').css('margin-left', newPosition + 'px');
    if (event.isFinal) {
      updateMarqueePosition(newPosition);
      checkForUnpause();
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
