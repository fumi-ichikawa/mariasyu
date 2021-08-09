require 'test_helper'

class MariagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get mariages_index_url
    assert_response :success
  end
end
