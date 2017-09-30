$(document).ready(function() {
  // Cleans up Legacy Scores and Metrics
  request_session_reset({ 'user_id': userId });

  // Requests languages available to the user be retrieved from the server
  request_lang_info({ user_id: userId });

  // Sets dom variables to global vars
  load_dom_vars()

  // Sets all jquery listeners for the DOM
  init_pause_frame_hover();
  init_speed_buttons();
  init_pause_button();
  init_hide_base();
  init_mouse_move_slide();

  if (window.addEventListener) {
      window.addEventListener('load', start_marquee, false);
  } else if (window.attachEvent) { //IE7-8
      window.attachEvent('onload', start_marquee);
  }
});
