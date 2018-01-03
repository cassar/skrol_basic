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
HIDE_BONUS = 0.3
NORMAL_BONUS = 0.3
PAUSE_PENALTY = 0.1
HOVER_PENALTY = 0.5

# Record Placeholder Sentinals
NONE = '[none]'.freeze

# Point at which a score is 'acquired'
ACQUIRY_POINT = 1.0

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
