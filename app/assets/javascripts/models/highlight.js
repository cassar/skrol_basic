function wordOn() {
  var domWord = $(this);
  if (!domWord.parent().hasClass('base') || notHidden()) {
    var metric_id = domWord.attr('data-metric');
    if (metric_id != '0') {
      $('*[data-metric="' + metric_id + '"]').addClass('highlight');
    }
  }
}

function wordOff() {
  $('*[data-metric="' + $(this).attr('data-metric') + '"]')
  .removeClass('highlight');
}
