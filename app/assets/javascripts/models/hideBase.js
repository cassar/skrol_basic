// Base Hide Settings
var baseHidden = false;
var baseColour = REAVEAL_COLOUR;
var buttonDown = false;

function setBaseHidden(hidden) {
  baseHidden = hidden;
  set_hide_base();
}

function getBaseHidden() {
  return baseHidden;
}

function notHidden() {
  return !baseHidden;
}

// Toggles between base hidden and base visible and updates view.
function toggleHideBase() {
  baseHidden = !baseHidden;
  set_hide_base();
  updateUserSetting({'base_hidden': baseHidden});
}

function set_hide_base() {
  if (baseHidden) {
    hideBaseLine();
  } else {
    revealBaseLine();
  }
}

function checkUnhideBase() {
  if (baseHidden) {
    BaseSentenceColorApply(this, REAVEAL_COLOUR);
    baseHidden = false;
    buttonDown = true;
  }
}

function checkHideBase() {
  if (buttonDown) {
    BaseSentenceColorApply(this, HIDE_COLOUR);
    baseHidden = true;
    buttonDown = false;
    reportReveal();
  }
}

function hideBaseLine() {
  baseColour = HIDE_COLOUR;
  applyBaseColour();
  changeToHidden();
}

function revealBaseLine() {
  baseColour = REAVEAL_COLOUR;
  applyBaseColour();
  changeToShowing();
  reportReveal();
}
