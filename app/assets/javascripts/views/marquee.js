var oldXpos;

function initMarquee() {
  $('#frame').hover(checkForPause, checkForUnpause);
  $('#frame').mousemove(marqueeDrag);
  $(window).resize(updateEntryPoint);
}

function reinitAfterInsert() {
  $('.slides:last .word').hover(toggleHighlight);
  $('.slides:last .base').click(unhideBase);
  $('.slides:last .base').addClass('hide');
  $('.slides:last .phnChar').hover(charOn, charOff);
  $('.slides:last .phnChar').click(playSound);
}

function marqueeDrag(event){
  checkForPause();
  var newXpos = event.pageX;
  if (cursorGrabbing() && notDisabled()) {
    var newPosition = (newXpos - oldXpos) + getMarqueePosition();
    updateMarqueePosition(newPosition);
    updateMarqueeView();
  }
  oldXpos = newXpos;
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
