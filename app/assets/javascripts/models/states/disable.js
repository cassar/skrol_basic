var disabled;

function initDisable() {
  disabled = true;
}

function notDisabled() {
  return !disabled;
}

function isDisabled() {
  return disabled;
}

// Toggles between disabled state and the user controlled pause/skroling state.
function toggleDisabled() {
  disabled = !disabled;
  if (disabled) {
    disable();
  } else {
    setPause();
    startSlideMonitor();
    clearNotification();
  }
}

function disable() {
  if (isComplete()) {
    changeToComplete();
  } else {
    changeToWorking();
  }
  stopMarquee();
  stopSlideMonitor();
}
