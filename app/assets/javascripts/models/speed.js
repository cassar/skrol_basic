// time in milliseconds before the marquee is moved.
var marqueeInterval = NORMAL_INTERVAL;

// Timer vars
var marqueeIntervalId = TIME_OUT_NOT_SET;

// Sets the marqueeInterval given a past speed level
function setSpeed(speed) {
  marqueeInterval = speed;
}

function getInterval() {
  return marqueeInterval;
}

// Increases marqueeInterval to slow down marquee
function decreaseSpeed() {
  if (marqueeInterval < MAX_INTERVAL) {
    marqueeInterval += INTERVAL_INCREMENT;
    if (canContinueSkroling()) {
      restartMarquee();
    }
    reportSpeed();
    updateUserSetting({'current_speed': marqueeInterval });
  }
}

// Decreases marqueeInterval to speed up marquee.
function increaseSpeed() {
  if (marqueeInterval > MIN_INTERVAL) {
    marqueeInterval -= INTERVAL_INCREMENT;
    if (canContinueSkroling()) {
      restartMarquee();
    }
    reportSpeed();
    updateUserSetting({'current_speed': marqueeInterval });
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
