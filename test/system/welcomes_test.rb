require "application_system_test_case"

class WelcomesTest < ApplicationSystemTestCase
  test "トップページに Taskleaf と表示されている" do
    visit root_url
    assert_selector "h1", text: "Taskleaf"
  end
end
