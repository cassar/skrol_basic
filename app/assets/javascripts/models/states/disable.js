var disabled = true;

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
  }
}

function disable() {
  changeToLoading();
  stopMarquee();
  stopSlideMonitor();
}
