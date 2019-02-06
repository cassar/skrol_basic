require 'test_helper'

class ContributorTest < ActiveSupport::TestCase
  setup do
    @contributor = Contributor.first
    @user = User.first
    @language = Language.first
  end

  test 'contributor associations' do
    assert @contributor.user == @user
    assert @contributor.language = @language
  end

  test 'validations' do
    # No duplicate contributor entries.
    assert_not @contributor.update language_id: 2
  end
end
