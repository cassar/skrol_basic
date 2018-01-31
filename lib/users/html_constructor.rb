class HTMLConstructor
  def initialize(enrolment_manager, word_manager)
    @metrics_manager = MetricsManager.new(enrolment_manager, word_manager)
    @word_manager = word_manager
    @phn_chars = []
  end

  attr_reader :phn_chars

  def standard_inner_rep(script)
    assoc_rep, sentence = @word_manager.assoc_rep_and_sentence(script)
    InnerRepConstructor.new(sentence, script, @metrics_manager, self).construct(assoc_rep)
  end

  def phonetic_inner_rep(assoc_rep, phn_rep)
    phonetic_string = ''
    assoc_rep.each_with_index do |assoc, index|
      user_metric = @metrics_manager.user_metric(assoc)
      phonetic_string << compile_word_tags_with_entry(user_metric, phn_rep[index])
    end
    phonetic_string
  end

  def compile_sentence_tag(inner_rep, type)
    "<div class=\"sentence #{type}\">#{inner_rep}</div>"
  end

  def compile_sentences_tag(content)
    entry = "<div class=\"sentences\">#{content}</div>"
  end

  def user_metric_ids
    @metrics_manager.user_metric_ids
  end

  def compile_word_tags_with_entry(metric, word)
    opening_tag, closing_tag = compile_word_tags(metric.id)
    opening_tag + compile_char_string(word) + closing_tag + '&nbsp'
  end

  def compile_char_string(word)
    char_string = ''
    word.entry.each_char do |char|
      char_string << "<div class='phnChar'>#{char}</div>"
      @phn_chars << char
    end
    char_string
  end

  def compile_word_tags(metric_id)
    opening_tag = "<div class=\"word\"data-metric=\"#{metric_id}\">"
    closing_tag = '</div>'
    [opening_tag, closing_tag]
  end

  class MetricsManager
    def initialize(enrolment_manager, word_manager)
      @enrolment_manager = enrolment_manager
      @target_script = word_manager.target_script
      @target_sentence = word_manager.target_sentence
      @word_manager = word_manager
      @sentence_metrics = []
    end

    attr_reader :word_manager

    def user_metric(word_assoc)
      word = @word_manager.word(word_assoc, @target_script)
      return nil if (score = @enrolment_manager.user_score(word)).nil?
      @sentence_metrics.each { |metric| return metric if metric.user_score_id == score.id }
      new_metric = score.user_metrics.create(sentence: @target_sentence)
      @sentence_metrics << new_metric
      new_metric
    end

    def user_metric_ids
      user_metric_ids = []
      @sentence_metrics.each { |metric| user_metric_ids << metric.id }
      user_metric_ids
    end
  end

  class InnerRepConstructor
    def initialize(sentence, script, metrics_manager, html_constructor)
      @standard_string = sentence.entry
      @dummy_string = @standard_string.downcase
      @offset = 0
      @start_index = 0
      @script = script
      @metrics_manager = metrics_manager
      @html_constructor = html_constructor
      @word_manager = metrics_manager.word_manager
    end

    def construct(assoc_rep)
      assoc_rep.each { |assoc| insert_associate(assoc) }
      @standard_string
    end

    private

    def insert_associate(assoc)
      word = @word_manager.word(assoc, @script)
      user_metric = @metrics_manager.user_metric(assoc)
      user_metric_id = user_metric.id if user_metric.present?
      user_metric_id = 0 if user_metric.nil?
      opening_tag, closing_tag = @html_constructor.compile_word_tags(user_metric_id)
      analyse_dummy_string(word, opening_tag, closing_tag)
    end

    def analyse_dummy_string(word, opening_tag, closing_tag)
      loop do
        substring = @dummy_string[@start_index, word.entry.length]
        if substring == word.entry
          insert_tags(word, opening_tag, closing_tag)
          return
        else
          word_deliniator_found
        end
      end
    end

    def word_deliniator_found
      word_deliniator = @standard_string[@start_index + @offset]
      if word_deliniator == ' '
        @standard_string[@start_index + @offset] = '&nbsp'
        @offset += 4 # '&nbsp'.length - ' '.length
      end
      @start_index += 1
    end

    def insert_tags(word, opening_tag, closing_tag)
      @standard_string.insert(@start_index + @offset, opening_tag)
      @offset += opening_tag.length
      @start_index += word.entry.length
      @standard_string.insert(@start_index + @offset, closing_tag)
      @offset += closing_tag.length
    end
  end
end
