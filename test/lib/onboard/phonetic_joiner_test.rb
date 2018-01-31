require 'test_helper'

class PhoneticJoinerTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @english_ipa = Script.find(2)
  end

  test 'join_all' do
    joint = @english.words.create(entry: 'hello please')
    none = @english_ipa.words.find_or_create_by(entry: NONE)
    none.standards << joint
    joiner = PhoneticJoiner.new(@english, @english_ipa)
    assert_difference('Word.count', 1) do
      joiner.join_all
    end
  end
end
