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
