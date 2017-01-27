// compiles and sends report to server
function report(data_group, data_word) {
  var report = {};
  report['group_id'] = parseInt(data_group, 10);
  report['word_id'] = parseInt(data_word, 10);
  report['user_map_id'] = user_map_id;
  report['speed'] = prePause;
  report['pause'] = skrolling;
  report['hover'] = true;
  report['hide'] = false;
  console.log(report);
  send_metrics(report);
}
