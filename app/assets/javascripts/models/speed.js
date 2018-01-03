// time in milliseconds before the marquee is moved.
var marqueeInterval = NORMAL_INTERVAL;

// Timer vars
var marqueeIntervalId = TIME_OUT_NOT_SET;

// Sets the marqueeInterval given a past speed level
function setSpeed(speed) {
  marqueeInterval = (NORMAL_INTERVAL * 2) - speed;
  update_speed();
}

function getInterval() {
  return marqueeInterval;
}

// Returns the current speed level
function getSpeedLevel() {
  return (NORMAL_INTERVAL * 2) - marqueeInterval;
}

// Increases marqueeInterval to slow down marquee
function decreaseSpeed() {
  if (marqueeInterval < MAX_INTERVAL) {
    marqueeInterval += INTERVAL_INCREMENT;
    if (canContinueSkroling()) {
      restartMarquee();
    }
    update_speed();
    reportSpeed();
    updateUserSetting({'current_speed': getSpeedLevel()});
  }
}

// Decreases marqueeInterval to speed up marquee.
function increaseSpeed() {
  if (marqueeInterval > MIN_INTERVAL) {
    marqueeInterval -= INTERVAL_INCREMENT;
    if (canContinueSkroling()) {
      restartMarquee();
    }
    update_speed();
    reportSpeed();
    updateUserSetting({'current_speed': getSpeedLevel()});
  }
}

function restartMarquee() {
  stopMarquee();
  startMarquee();
}

// stops the setInterval set for the frontend
function stopMarquee() {
  if (marqueeIntervalId != TIME_OUT_NOT_SET) {
    clearInterval(marqueeIntervalId);
    marqueeIntervalId = TIME_OUT_NOT_SET;
  }
}

// starts the setInterval set for the frontend
function startMarquee() {
  if (marqueeIntervalId == TIME_OUT_NOT_SET) {
    marqueeIntervalId = setInterval(incrementMarquee, marqueeInterval);
  }
}
