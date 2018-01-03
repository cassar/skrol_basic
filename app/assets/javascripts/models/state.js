// skrol/pause/disabled setting
var skroling = true;
var disabled = true;

function canContinueSkroling() {
  return skroling && !disabled;
}

function notDisabled() {
  return !disabled;
}

function checkEnoughSlides() {
  if (enoughSlides()) {
    if (disabled) {
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

// Toggles between disabled state and the user controlled pause/skroling state.
function toggleDisabled() {
  disabled = !disabled;
  if (disabled) {
    changeToLoading();
    stopMarquee();
    stopSlideMonitor();
  } else {
    setPause();
    startSlideMonitor();
  }
}

// Toggles between skroling or paused and updates view.
function togglePause() {
  skroling = !skroling;
  setPause();
}

function setPause() {
  if (skroling) {
    unpause();
  } else {
    pause();
  }
}

function checkForPause() {
  if (canContinueSkroling()) {
    pause();
  }
}

function checkForUnpause() {
  if (canContinueSkroling()) {
    unpause();
  }
}

function pause() {
  stopMarquee();
  changeToPaused();
  reportPause();
}

function unpause() {
  startMarquee();
  changeToSkroling();
}
