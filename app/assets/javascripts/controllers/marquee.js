$(document).ready(function() {
  // Load DOM and global variables with values
  setup_marquee();
  init_jquery_controls();

  if (window.addEventListener) {
      window.addEventListener('load', start_marquee, false);
  } else if (window.attachEvent) { //IE7-8
      window.attachEvent('onload', start_marquee);
  }
});
