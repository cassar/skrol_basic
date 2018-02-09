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

function changeToError() {
  disableStateButton();
  changeStateButton('Error', 'warning');
  addNotification(SERVER_ERROR);
}

function changeToWorking() {
  disableStateButton();
  changeStateButton('Working', 'warning');
  addNotification(WORKING_MSG);
}

function changeToSelect() {
  disableStateButton();
  changeStateButton('Select', 'warning');
  addNotification(LANGUAGE_SELECT);
}

function changeToLoading() {
  disableStateButton();
  changeStateButton('Loading', 'warning');
}

function changeToComplete() {
  disableStateButton();
  changeStateButton('Complete', 'success');
  addNotification(COURSE_COMPLETE);
  retrieveMeter();
}

function exit() {
  disableStateButton();
  changeStateButton('Exiting', 'warning');
  stopMarquee();
  stopSlideMonitor();
}
