function initControls() {
  $('#lessSpeed').click(decreaseSpeed);
  $('#moreSpeed').click(increaseSpeed);
  $('#state').click(togglePause);
  $('#hide-base').click(toggleHideBase);
  $('#signOut, #account').click(exit);
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

function changeStateButton(label, subClass) {
  $('#state')
  .html(label)
  .removeClass()
  .addClass('btn btn-' + subClass);
}

function disableStateButton() {
  $('#state').attr('disabled', 'true');
}

function enableStateButton() {
  $('#state').removeAttr('disabled');
}
