// Compiles and sends report to server
function send_report(data_group, data_word, data_map, hover) {
  // check if metric already sent
  if (sentMetricsArray.includes(data_group + ':' + data_word)) {
    return;
  }
  sentMetricsArray.push(data_group + ':' + data_word)
  // compile report
  var report = compile_json(data_group, data_word, data_map, hover);
  console.log(report);
  // send report
  send_metrics(report);
}

// Creates JSON object to be sent
function compile_json(data_group, data_word, data_map, hover) {
  var report = {};
  report['group_id'] = parseInt(data_group, 10);
  report['word_id'] = parseInt(data_word, 10);
  report['user_map_id'] = parseInt(data_map, 10);
  report['speed'] = speed_level();
  report['pause'] = !skroling;
  report['hover'] = hover;
  report['hide'] = false;
  return report;
}
