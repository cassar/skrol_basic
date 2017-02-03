// compiles and sends hover report to server
function hover_report(data_group, data_word) {
  // check if metric already sent
  if (sentMetricsArray.includes(data_group + ':' + data_word)) {
    return;
  }
  sentMetricsArray.push(data_group + ':' + data_word)

  // compile report
  var report = {};
  report['group_id'] = parseInt(data_group, 10);
  report['word_id'] = parseInt(data_word, 10);
  report['user_map_id'] = user_map_id;
  report['speed'] = step;
  report['pause'] = !skroling;
  report['hover'] = true;
  report['hide'] = false;
  console.log(report);

  // send report
  send_metrics(report);
}

// compiles and sends clear report
function clear_report(data_group, data_word) {
  // check if metric already sent
  if (sentMetricsArray.includes(data_group + ':' + data_word)) {
    return;
  }
  sentMetricsArray.push(data_group + ':' + data_word)

  // compile report
  var report = {};
  report['group_id'] = parseInt(data_group, 10);
  report['word_id'] = parseInt(data_word, 10);
  report['user_map_id'] = user_map_id;
  report['speed'] = step;
  report['pause'] = !skroling;
  report['hover'] = false;
  report['hide'] = false;
  console.log(report);

  // send report
  send_metrics(report);
}
