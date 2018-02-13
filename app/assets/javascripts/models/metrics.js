// An array to keep track of elements in the marquee view
var slideMetricsArray, metricsObject;

function initMetrics() {
  slideMetricsArray = [];
  metricsObject = {};
}

// Word Hover Reporting
var start, end;

function slideCount() {
  return slideMetricsArray.length;
}

function addSlideInfo(metrics) {
  slideMetricsArray.push(metrics);
  for (var i = 0; i < metrics.length; i++) {
    metricsObject[metrics[i]] = {
      'metric_id': metrics[i],
      'speed': getInterval(),
      'hover': false,
      'hide': true,
      'pause': false,
      'complete': false
     };
  }
}

function getSlideMetrics(position) {
  return slideMetricsArray[slideMetricsArray.length - position];
}

function reportResults() {
  if (slideMetricsArray.length >= MONITOR_THRESHOLD) {
    var slideMetrics = getSlideMetrics(MONITOR_THRESHOLD)
    for (var i = 0; i < slideMetrics.length; i++) {
      checkAndSendReport(slideMetrics[i]);
    }
  }
}

function reportCurrentSlide(attr, value, msg) {
  if (slideMetricsArray.length >= PROGRESS_THRESHOLD) {
    var slideMetrics = getSlideMetrics(PROGRESS_THRESHOLD)
    for (var i = 0; i < slideMetrics.length; i++) {
      metricsObject[slideMetrics[i]][attr] = value;
    }
    console.log(msg + slideMetrics);
  }
}

function reportReveal() {
  var msg = 'Basehidden set to ' + false + ' for metrics: ';
  reportCurrentSlide('hide', false, msg);
}

function reportSpeed() {
  var msg = 'Speed set to ' + getInterval() + ' for metrics: ';
  reportCurrentSlide('speed', getInterval(), msg);
}

function reportPause() {
  var msg = 'Paused on slide metrics: ';
  reportCurrentSlide('pause', true, msg);
}

function timerOn() {
  start = Date.now();
}

function timerOff() {
  end = Date.now();
  if ((end - start) > HOVER_WAIT) {
    var metric_id = $(this).attr('data-metric');
    if (metric_id == '0') {
      return;
    }
    metricsObject[metric_id]['hover'] = true;
    metricsObject[metric_id]['pause'] = true;
    console.log('Hoverd on metric: ' + metric_id);
    checkAndSendReport(metric_id);
  }
}

// Compiles and sends report to server
function checkAndSendReport(metric_id) {
  var metric_record = metricsObject[metric_id];
  if (metric_record['complete']) {
    return;
  }
  metric_record['complete'] = true;
  console.log(metric_record);
  sendMetric(metric_record);
}

// Sends metrics back to the server
function sendMetric(json) {
  $.ajax({
    method: "POST",
    url: "/metrics",
    data: json
  })
  .done(function( msg ) {
    console.log( "Complete: metric saved " + msg["message"] );
  })
  .fail(function() {
    console.log( "Error: Could not save metric: " + json['metric_id']);
    console.log( "Attempting again in 10secs.");
    setTimeout(sendMetric, 10000, json);
  });
}
