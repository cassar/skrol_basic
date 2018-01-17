// Languages
var enrolmentId = NO_ENROLMENT_SET;
var languages = {};

// Indexes where Language Name and User Map ID can be found.
var LANG_NAME = 0;
var ENROLMENT_ID = 1;


function enrolmentSet() {
  return enrolmentId != NO_ENROLMENT_SET;
}

function getEnrolmentId() {
  return enrolmentId;
}

function setEnrolmentId(iD) {
  enrolmentId = iD;
  updateLangButton();
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
  emptySlideQueue();
  requestSessionReset();
  updateUserSetting({'current_enrolment': enrolmentId});
  updateLangButton();
  resetComplete();
  setPause();
}
