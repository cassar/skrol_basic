function skrolInit() {
  changeToLoading();
  requestSessionReset();
  // Requests available languages and user settings, be retrieved from the
  // server. Then, updates models and views.
  requestUserInfo();

  // Set event for Controls and Marquee
  initControls();
  initMarquee();

  initEngine();
  clearNotification();
}
