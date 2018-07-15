require 'test_helper'

class ProcessRepsTest < ActiveSupport::TestCase
  setup do
    @standard = Language.find_by_name('Spanish').standard_script
    @sents = @standard.sentences
    @words = @standard.words
  end

  test 'derive_rep_sents' do
    rep_sents_id = derive_rep_sents(@words, @sents)
    assert_not_empty(rep_sents_id)
  end
end
