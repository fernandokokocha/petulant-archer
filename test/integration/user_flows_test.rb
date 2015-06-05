require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({:provider => 'facebook',
                                                                   :uid => '1'
                                                                  })
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end

  test 'unlogged user "flow""' do
    get root_path
    assert_response :success
    assert_equal '/', path
  end

  test 'logged user flow"' do
    login_user
    while redirect? do
      follow_redirect!
    end
    assert_response :success
    assert_equal '/app', path
  end

  def login_user
    post user_omniauth_authorize_path(:facebook)
  end
end
