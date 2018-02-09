var LANGUAGE_SELECT = 'Please select a language to learn below';
var SERVER_ERROR = 'No server connection, will attempt again soon.';
var COURSE_COMPLETE = 'Course complete, please select another course.';
var WORKING_MSG = 'Retrieving sentences from server.';

var messageQueue = [];
var transitionCalled = false;

function clearNotification() {
  addNotification('');
}

function addNotification(msg) {
  messageQueue.push(msg);
  if (!transitionCalled) {
    transitionCalled = true;
    transition();
  }
}

function transition() {
  if (messageQueue.length != 0) {
    notificationFadeOut();
  } else {
    transitionCalled = false;
  }
}

function notificationFadeOut() {
  $('#notification')
    .fadeOut(400, 'swing', notificationFadeIn);
}

function notificationFadeIn() {
  $('#notification')
    .text(messageQueue.shift())
    .fadeIn(1000, 'swing', transition);
}
