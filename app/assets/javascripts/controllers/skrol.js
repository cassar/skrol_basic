var initialised = false;

function skrolInit() {
  if (!initialised) {
    initialized = true;
    if (isTouchScreen()) {
      $('#noTouch').show();
    } else {
      changeToLoading();

      // Models
      initDisable();
      initSkroling();
      initHideBase();
      initSounds();
      initLanguages();
      initMetrics();
      initSlides();
      initSpeed();

      // User Setup
      requestSessionReset();
      requestUserInfo();

      // Views
      initControls();
      initMarquee();

      // Start
      initEngine();
      clearNotification();
    }
  }
}
