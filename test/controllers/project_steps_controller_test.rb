require "test_helper"

class ProjectStepsControllerTest < ActionDispatch::IntegrationTest
  test "should get step1" do
    get project_steps_step1_url
    assert_response :success
  end

  test "should get step2" do
    get project_steps_step2_url
    assert_response :success
  end

  test "should get step3" do
    get project_steps_step3_url
    assert_response :success
  end

  test "should get review" do
    get project_steps_review_url
    assert_response :success
  end
end
