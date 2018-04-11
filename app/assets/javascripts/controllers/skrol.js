var initialised = false;

function skrolInit() {
  if (!initialised) {
    initialized = true;
    checkForPortrait();
    changeToLoading();

    // Models
    initPortraitMonitor();
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
