// Blink engine detection
var isBlink;

function setBlink() {
  // Opera 8.0+
  var isOpera = (!!window.opr && !!opr.addons) || !!window.opera ||
                  navigator.userAgent.indexOf(' OPR/') >= 0;

  // Chrome 1+
  var isChrome = !!window.chrome && !!window.chrome.webstore;

  // Blink engine detection
  isBlink = (isChrome || isOpera) && !!window.CSS;
}

function notBlink() {
  return !isBlink;
}
