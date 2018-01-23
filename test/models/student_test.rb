require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
  end

  test 'uniqueness' do
    assert_difference('Sentence.count', 1) do
      @english.sentences.create(entry: 'Why hello there.')
      @english.sentences.create(entry: 'Why hello there.')
    end
  end
end
