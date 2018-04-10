var initialised = false;

function skrolInit() {
  if (!initialised) {
    initialized = true;
    changeToLoading();

    // Models
    initDisable();
    initSkroling();
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
