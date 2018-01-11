function initControls() {
  $('#lessSpeed').click(decreaseSpeed);
  $('#moreSpeed').click(increaseSpeed);
  $('#stop-start').click(togglePause);
  $('#hide-base').click(toggleHideBase);
  $('#signOut').click(disable);
}

function update_speed() {
  $('#speedLabel').html(getSpeedLevel());
}

function updateLangButton() {
  $('#lang-label').html(currentLanguageName());
}

function addLangListElement(enrolmentId, langName) {
  $('.languages').prepend('<li class="language dropdown-item" data-enrolment=' +
  enrolmentId + '><a>'+ langName +'</a></li>');
}

function setLangChange() {
  $('li.language').click(changeLanguage);
}

// Change button #hide-base button to Showing
function changeToShowing() {
  $('#hide-base')
  .html('Showing')
  .removeClass('btn-default')
  .addClass('btn-primary');
}

// Change button #hide-base button to Hidden
function changeToHidden() {
  $('#hide-base')
  .html('Hidden')
  .removeClass('btn-primary')
  .addClass('btn-default');
}

// Change button #stop_start button to Paused
function changeToPaused() {
  $('#stop-start')
  .removeAttr('disabled')
  .html('Paused')
  .removeClass()
  .addClass('btn btn-default');
}

// Change button #stop_start button to Skroling
function changeToSkroling() {
  $('#stop-start')
  .removeAttr('disabled')
  .html('Skroling')
  .removeClass()
  .addClass('btn btn-primary');
}

// Change button #stop_start button to Loading
function changeToLoading() {
  $('#stop-start')
  .attr('disabled', 'true')
  .html('Loading')
  .removeClass()
  .addClass('btn btn-warning');
}
