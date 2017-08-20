// Constants
var NORMAL_INTERVAL = 15;
var MIN_INTERVAL = 10;
var MAX_INTERVAL = 20;
var INTERVAL_INCREMENT = 5;
var MIN_ELEMENTS = 3;
var HOVER_WAIT = 1000;
var BUFFER = 1;
var STEP = 1;

// The array that sentence objects will be loaded into.
var stringArray = [];
var attrArray = [];

// Ajax Variables
var requestPending = false;
var sentMetricsArray = [];

// Timer vars
var frontTimeOutId;
var interval = NORMAL_INTERVAL;

// Speed Settings
var skroling = true;
var disabled = true;

// Word Hover Reporting
var start;
var end;

// Base Hide Settings
var baseHidden = false;
var baseColour = 'black';

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

// User settings.
var userMapId = 0;
var userId = 1;
var userLangArr;
var LANG_NAME = 0;
var USER_MAP_ID = 1;
