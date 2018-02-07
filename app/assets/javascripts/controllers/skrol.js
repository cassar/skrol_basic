function skrolInit() {
  if (isTouchScreen()) {
    $('#noTouch').show();
  } else {
    changeToLoading();
    requestSessionReset();
    requestUserInfo();

    // Set event views
    initControls();
    initMarquee();

    initEngine();
    clearNotification();
  }
}
