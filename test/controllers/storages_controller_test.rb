require 'test_helper'

class StoragesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get storages_new_url
    assert_response :success
  end

end
