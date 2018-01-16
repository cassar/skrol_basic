var skroling = true;

function isSkroling() {
  return skroling;
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

// Change button #stop_start button to Paused
function changeToPaused() {
  enableStateButton();
  changeStateButton('Paused', 'default');
}

// Change button #stop_start button to Skroling
function changeToSkroling() {
  enableStateButton();
  changeStateButton('Skroling', 'primary');
}
