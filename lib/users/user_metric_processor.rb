class UserMetricProcessor
  def initialize(obj)
    @metric_id = obj['metric_id'].to_i
    @speed = obj['speed'].to_i
    @pause = obj['pause'] == 'true'
    @hover = obj['hover'] == 'true'
    @hide = obj['hide'] == 'true'
  end

  def process
    metric = UserMetric.find_by_id(@metric_id)
    return [0, 'METRIC RESET'] if metric.nil?
    metric.update(speed: @speed, pause: @pause, hover: @hover, hide: @hide)
    metric.user_score.update(status: TESTED)
    [metric.apply_user_score, metric.word.entry]
  end
end
