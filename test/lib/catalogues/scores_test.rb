require 'test_helper'

class ScoresCatalogueTest < ActiveSupport::TestCase
  setup do
    spanish = Language.find_by_name('Spanish')
    @words = spanish.standard_script.words
  end

  test 'create_item_scores_obj' do
    word_scores_obj = create_item_scores_obj(@words)
    assert_not_empty(word_scores_obj)
  end
end
