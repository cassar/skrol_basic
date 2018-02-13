// Base Hide Settings
var baseColour, buttonDown;

function initHideBase() {
  baseColour = HIDE_COLOUR;
  buttonDown = false;
}

function checkUnhideBase() {
  BaseSentenceColorApply(this, REAVEAL_COLOUR);
  buttonDown = true;
}

function checkHideBase() {
  if (buttonDown) {
    BaseSentenceColorApply(this, HIDE_COLOUR);
    buttonDown = false;
    reportReveal();
  }
}
