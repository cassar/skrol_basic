require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  setup do
    @language = Language.first
    @script = Script.first
    @contributor = Contributor.first
  end

  test 'associations' do
    assert @language.scripts.include? @script
    assert @language.contributors.include? @contributor
    @language.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @contributor.reload }
  end

  test 'info' do
    Language.take.info
  end

  test 'all_info' do
    Language.all_info
  end
end
