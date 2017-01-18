# The user will no longer have to revise this word after its user_score gets
# above this.
THRESHOLD = 0.9

# The entry that a user_score is ititialised with.
START_SCORE = 0.5

# Score weights determine how much a particular score will contribute to the
# WTS
WCFBSW = 0.05
WCFTSW = 0.05
WFSW = 0.20
WLSW = 0.20
WSSW = 0.50

# View Metric Constants, used to determine how much a user will be penalised or
# rewarded.
NORMAL_BONUS = 0.3
NORMAL_SPEED = 30
PAUSE_PENALTY = 0.1
HOVER_PENALTY = 0.5
HIDE_BONUS = 0.3

# Place Holders
NONE = '[none]'.freeze
CHECK = '[check]'.freeze
NEW = '[new]'.freeze
