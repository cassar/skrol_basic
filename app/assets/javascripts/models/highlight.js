var domWord = null;

function toggleHighlight() {
  domWord = $(this);
  console.log(domWord);
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
  if (!domWord.parent().hasClass('base')) {
    var metric_id = domWord.attr('data-metric');
    if (metric_id != '0') {
      $('*[data-metric="' + metric_id + '"]').addClass('highlight');
    }
  }
  domWord = null;
}

function highlightOff() {
  $('.highlight').removeClass('highlight');
}
