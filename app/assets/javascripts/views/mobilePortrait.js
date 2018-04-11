function initPortraitMonitor() {
  $(window).resize(checkForPortrait);
}

function checkForPortrait() {
  if ($(window).width() < $(window).height()) {
    $('#mobilePortrait').show();
    checkForPause();
  } else {
    $('#mobilePortrait').hide();
  }
}
