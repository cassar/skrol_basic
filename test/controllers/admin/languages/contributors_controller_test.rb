require 'test_helper'

class Admin::Languages::ContributorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users :luke
    @language = Language.first
    @user = User.first
  end

  test 'should get new' do
    get new_admin_language_contributor_url @language
    assert_response :success
  end

  test 'should post create success' do
    Contributor.destroy_all
    assert_difference 'Contributor.count' do
      post admin_language_contributors_url @language, params: { contributor: { user_id: @user.id } }
    end
    assert_redirected_to admin_language_url @language
  end

  test 'should post create fail' do
    assert_no_difference 'Contributor.count' do
      post admin_language_contributors_url @language, params: { contributor: { user_id: @user.id } }
    end
    assert_response :success
  end
end
