// Languages
var enrolmentId, languages;

function initLanguages() {
  enrolmentId = NO_ENROLMENT_SET;
  languages = {};
}

function enrolmentSet() {
  return enrolmentId != NO_ENROLMENT_SET;
}

function getEnrolmentId() {
  return enrolmentId;
}

function setEnrolmentId(iD) {
  enrolmentId = iD;
  updateLangButton();
  retrieveMeter();
}

// Loads the languages available into languages dropdown
function loadLangInfo(langs) {
  for(var i = 0; i < langs.length; i++) {
    var langName = langs[i][LANG_NAME];
    var enrolmentId = langs[i][ENROLMENT_ID];
    languages[enrolmentId] = langName;
    addLangListElement(enrolmentId, langName);
  }
  setLangChange();
}

function currentLanguageName() {
  return languages[enrolmentId];
}

function changeLanguage() {
  enrolmentId = parseInt($(this).attr('data-enrolment'));
  resetComplete();
  emptySlideQueue();
  updateUserSetting({'current_enrolment': enrolmentId});
  updateLangButton();
  clearNotification();
  retrieveMeter();
}
