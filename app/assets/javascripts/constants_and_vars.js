// Constants
var STANDARD_FONT_SIZE = 4;
var NORMAL_SPEED = 3;
var MIN_ELEMENTS = 2;

// The array that sentence objects will be loaded into.
var stringArray = [];
// Ajax Variables
var request_pending = false;

// Speed Settings
var step = NORMAL_SPEED;
var prePause = step;
var skrolling = true;

// Font Size Settings
var fontSize = STANDARD_FONT_SIZE;

// Marquee vars
var oldX = 0;
var newX = 0;
var diff = 0;
var cursor = '';

// Marquee setup
var marquee;
var slide;
var frame;
var marqueeWidth;
var marginLeft;
var slideWidth;
