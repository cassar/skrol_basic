var domWord = null;

function toggleHighlight() {
  domWord = $(this);
  if (domWord.hasClass('highlight')) {
    highlightOff();
  } else {
    highlightOff();
    highlightOn();
  }
  domWord = null;
}

function highlightOn() {
  if (domWord == null) {
    domWord = $(this);
  }
  var parent = domWord.parent();
  if (!parent.hasClass('base') || parent.hasClass('reveal')) {
    var metric_id = domWord.attr('data-metric');
    if (metric_id != '0') {
      $('*[data-metric="' + metric_id + '"]').addClass('highlight');
    }
  }
  domWord = null;
}

function highlightOff() {
  $('.highlight').removeClass('highlight');
function unhideBase() {
  checkForPause();
  hideBase();
  $(this).addClass('reveal');
  reportReveal();
}
