require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get messages_edit_url
    assert_response :success
  end

end
