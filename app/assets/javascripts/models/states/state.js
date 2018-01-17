function canContinueSkroling() {
  return isSkroling() && notDisabled();
}

function checkEnoughSlides() {
  if (enoughSlides()) {
    if (isDisabled()) {
      toggleDisabled();
    }
    return true;
  } else {
    if (notDisabled()) {
      toggleDisabled();
    }
    return false;
  }
}

function changeToWorking() {
  disableStateButton();
  changeStateButton('Working', 'warning');
}

function changeToSelect() {
  disableStateButton();
  changeStateButton('Select', 'warning');
}

function changeToLoading() {
  disableStateButton();
  changeStateButton('Loading', 'warning');
}

function changeToComplete() {
  disableStateButton();
  changeStateButton('Complete', 'success');
}

function exit() {
  disableStateButton();
  changeStateButton('Exiting', 'warning');
  stopMarquee();
  stopSlideMonitor();
}
