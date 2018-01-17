module NextSlideRetriever
  # Will retrieve an object containing the html representation of the slide.
  def self.retrieve(enrolment)
    NextSlideHelper.new(enrolment).return_slide_and_data
  end

  class NextSlideHelper
    def initialize(enrolment)
      @enrolment_manager = EnrolmentManager.new(enrolment)
      @next_sentence_retriever = NextSentenceRetriever.new(@enrolment_manager)
    end

    # Retrieves the next available sentence and word entries that a user will
    # view.
    def return_slide_and_data
      target_sentence = nil
      loop do
        target_word = @enrolment_manager.next_word
        return { service: 'EMPTY' } if target_word.nil?
        target_sentence = @next_sentence_retriever.retrieve(target_word)
        break if target_sentence.present?
        @enrolment_manager.assign_status(target_word, EXHAUSTED)
      end
      SlideConstructor.new(@enrolment_manager, target_sentence).construct
    end
  end
end
