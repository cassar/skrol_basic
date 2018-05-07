// Initial Map Value
var NO_ENROLMENT_SET = 0;
// Amount of miliseconds before the backend checks if a slide should be inserted.
var SLIDE_MONITOR_INTERVAL = 5;
// Amount of slides after which client will check server for meter update.
var METER_CHECK = 1;
// The dafault marqueeInterval in milliseconds that the marquee will start at.
var NORMAL_INTERVAL = 18;
// The minimum marqueeInterval that represents the maximum speed.
var MIN_INTERVAL = 10;
// The maximum marqueeInterval which represents the minimum speed.
var MAX_INTERVAL = 29;
// Them number of miliseconds to change the increment upon each request.
var INTERVAL_INCREMENT = 1;
// Number of elements at which marquee cannot operate.
var EMPTY = 0;
// The maximum number of slides to keep in the buffer before requesting more.
var MAX_ELEMENTS = 2;
// The number of pixels to push a slide out of view
var BUFFER = 1;
// Number of pixels to move at each mouse increment.
var STEP = 1;
// The default marqueeInterval ID when none is set.
var TIME_OUT_NOT_SET = 0;
// Minimum number of slides inserted before metrics are sent
var MONITOR_THRESHOLD = 4;
// Minimum number of slides reached before metrics are recorded
var PROGRESS_THRESHOLD = 2;
// Time in miliseconds to wait before checking for another slide after initial
// fail
var FAIL_WAIT = 10000;
// Indexes where Language Name and User Map ID can be found.
var LANG_NAME = 0;
var ENROLMENT_ID = 1;
