var domWord = null;

// Word Hover Reporting
var start, end;

function toggleHighlight() {
  domWord = $(this);
  if (domWord.hasClass('highlight')) {
    timerOff();
    checkforReport();
    removeHighlight();
  } else {
    checkForPause();
    removeHighlight();
    timerOn();
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
}

function checkforReport() {
  if ((end - start) > HOVER_WAIT && domWord != null) {
    reportHighlight(domWord);
  }
}

function unhideBase() {
  checkForPause();
  hideBase();
  $(this).addClass('reveal');
  reportReveal();
}

function timerOn() {
  start = Date.now();
}

function timerOff() {
  end = Date.now();
}
