function exit() {
  disableStateButton();
  changeStateButton('Exiting', 'success');
  stopMarquee();
  stopSlideMonitor();
}
