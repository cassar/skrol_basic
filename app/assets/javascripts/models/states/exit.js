function exit() {
  disableStateButton();
  changeStateButton('Exiting', 'warning');
  stopMarquee();
  stopSlideMonitor();
}
