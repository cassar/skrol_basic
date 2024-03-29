# Maximum length in characters that a sentence can be to be mapped.
MAX_LENGTH_MAP = 40

# Maximum length in characters that a sentence can be to be loaded
MAX_LENGTH_LOAD = 40

# Maximum length in charcters that a word can be to be loaded
MAX_LENGTH_WORD = 80

# Score weights to determine how much a particular score will contribute to the
# WTS
WCFBSW = 0.05
WCFTSW = 0.05
WFSW = 0.20
WLSW = 0.20
WSSW = 0.50

# Score weights to determine how much a particular score will contribute to the
# STS
SCWTSW = 0.33
SWLSW = 0.33
SWOSW = 0.33

# View Metric Constants, used to determine how much a user will be penalised or
# rewarded.
NORMAL_BONUS = 0.3

# Point at which a score is 'acquired'
ACQUIRY_POINT = 1.0

# Average time that a user takes to learn a word in seconds (a guess)
AVG_ACQUIRY_TIME = 60

# Speed at which an new student is automatically set at.
DEFAULT_SPEED = 18

# New User Values
NO_ENROLMENT_SET = 0

# User Score placeholder
TESTING = '[testing]'.freeze
TESTED = '[tested]'.freeze
EXHAUSTED = '[exhausted]'.freeze

# Onboard Sources
TATOEBA = 'Tatoeba'.freeze
DBNARY = 'Dbnary'.freeze
WIKI = 'Wiktionary'.freeze
BING = 'Microsoft Bing API'.freeze
SENTENCE_SPLITTER = 'Skrol Sentence Splitter'.freeze
COURSE_CREATOR = 'Skrol Course Creator'.freeze

# Microsoft Bing Translate
COGNITIVE_SUBSCRIPTION_KEY = '4e75483f61a849d88c666d4ea0b88ca1'.freeze

# Skrol Inter Communication Key
SKROL_KEY = 'ffd9d0464401ab2e301763fc02196178'.freeze
