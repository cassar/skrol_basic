var domWord = null;

function toggleHighlight() {
  domWord = $(this);
  if (domWord.hasClass('highlight')) {
    highlightOff();
  } else {
    checkForPause();
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
    } else {
      domWord.addClass('highlight');
    }
  }
  domWord = null;
}

function unhideBase() {
  checkForPause();
  hideBase();
  $(this).addClass('reveal');
  reportReveal();
}
