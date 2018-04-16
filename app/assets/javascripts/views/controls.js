function initControls() {
  $('#lessSpeed').click(decreaseSpeed);
  $('#moreSpeed').click(increaseSpeed);
  $('#state').click(togglePause);
  $('#signOut').click(exit);
  $('#about, #account').click(pause);
}

function updateLangButton() {
  $('#langLabel').html(currentLanguageName());
  if ($('#langLabel').hasClass('btn-warning')) {
    $('#langLabel')
    .removeClass('btn-warning')
    .addClass('btn-primary');
  }
}

function setLangButtonSelect() {
  $('#langLabel')
  .removeClass('btn-primary')
  .addClass('btn-warning')
  .html('Languages');
}

function showAboutModal() {
  $('#aboutModal').modal('show');
}

function addLangListElement(enrolmentId, langName) {
  $('#languages').prepend('<a class="language dropdown-item" data-enrolment=' +
  enrolmentId + '>' + langName +'</a>');
}

function setLangChange() {
  $('.language').click(changeLanguage);
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

function updateMeterButton(msg) {
  $('.meter').text(msg);
}
