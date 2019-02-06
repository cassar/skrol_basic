require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.first
    @contributor = Contributor.first
    @language = Language.first
  end

  test 'associations' do
    assert @user.contributors.include? @contributor
    assert @user.contributing_languages.include? @language
    @user.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @contributor.reload }
  end

  test 'scopes' do
    assert User.search('l').include? @user
  end
end
