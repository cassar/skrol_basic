function initMarquee() {
  $('#frame').hover(checkForPause, checkForUnpause);
  $('#frame').mousemove(moveMarquee);
  $(window).resize(updateEntryPoint);
}

function reinitAfterInsert() {
  $('.word').hover(timerOn, timerOff);
  $('.word').hover(wordOn, wordOff);
  $('.base').mousedown(checkUnhideBase).mouseup(checkHideBase);
  $('.phnChar').hover(charOn, charOff);
  $('.phnChar').click(playSound);
  applyBaseColour();
}

function applyBaseColour() {
  $('.base').css('color', baseColour);
}

function updateMarqueePosition() {
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

function BaseSentenceColorApply(element, color) {
  $(element).css('color', color);
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
