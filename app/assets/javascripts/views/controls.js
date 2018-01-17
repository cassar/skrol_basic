function initControls() {
  $('#lessSpeed').click(decreaseSpeed);
  $('#moreSpeed').click(increaseSpeed);
  $('#state').click(togglePause);
  $('#signOut, #account').click(exit);
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
