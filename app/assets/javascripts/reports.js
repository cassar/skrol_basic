// compiles and sends report to server
function send_report(data_group, data_word, hover) {
  // check if metric already sent
  if (sentMetricsArray.includes(data_group + ':' + data_word)) {
    return;
  }
  sentMetricsArray.push(data_group + ':' + data_word)
  // compile report
  var report = compile_json(data_group, data_word, hover);
  console.log(report);
  // send report
  send_metrics(report);
}

// Creates JSON object to be sent
function compile_json(data_group, data_word, hover) {
  var report = {};
  report['group_id'] = parseInt(data_group, 10);
  report['word_id'] = parseInt(data_word, 10);
  report['user_map_id'] = user_map_id;
  report['speed'] = speed_level();
  report['pause'] = !skroling;
  report['hover'] = hover;
  report['hide'] = false;
  return report;
}
