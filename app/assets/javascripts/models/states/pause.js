var skroling;

function initSkroling() {
  skroling = true;
}

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
  changeToResume();
  reportPause();
}

function unpause() {
  hideBase();
  removeHighlight();
  startMarquee();
  changeToPause();
}

// Change button #stop_start button to Paused
function changeToResume() {
  enableStateButton();
  changeStateButton('Resume', 'default');
}

// Change button #stop_start button to Skroling
function changeToPause() {
  enableStateButton();
  changeStateButton('Pause', 'primary');
}
