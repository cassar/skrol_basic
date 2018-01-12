function initMarquee() {
  $('#frame').hover(checkForPause, checkForUnpause);
  $('#frame').mousemove(moveMarquee);
  initMarqueeModel();
}

function reinitAfterInsert() {
  $('.word').hover(timerOn, timerOff);
  $('.word').hover(wordOn, wordOff);
  $('.base').mousedown(checkUnhideBase).mouseup(checkHideBase);
  applyBaseColour();
}

function applyBaseColour() {
  $('.base').css('color', baseColour);
}

function updateMarqueePosition() {
  $('#marquee').css('margin-left', getMarqueePosition() + 'px');
}

function getSlideWidth() {
  return $('#slide').width();
}

function getMarqueeWidth() {
  return $('#marquee').width();
}

function cursorGrabbing() {
  return $('#frame').css('cursor') == 'grabbing';
}

function appendSlide(nextSlide) {
  $('#slide').append(nextSlide);
}

function BaseSentenceColorApply(element, color) {
  $(element).css('color', color);
}
