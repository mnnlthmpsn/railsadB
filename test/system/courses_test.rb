require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @course = courses(:one)
  end

  test "visiting the index" do
    visit courses_url
    assert_selector "h1", text: "Courses"
  end

  test "creating a Course" do
    visit courses_url
    click_on "New Course"

    check "Active status" if @course.active_status
    fill_in "Contact number", with: @course.contact_number
    check "Del status" if @course.del_status
    fill_in "First name", with: @course.first_name
    fill_in "Last name", with: @course.last_name
    fill_in "Town", with: @course.town_id
    click_on "Create Course"

    assert_text "Course was successfully created"
    click_on "Back"
  end

  test "updating a Course" do
    visit courses_url
    click_on "Edit", match: :first

    check "Active status" if @course.active_status
    fill_in "Contact number", with: @course.contact_number
    check "Del status" if @course.del_status
    fill_in "First name", with: @course.first_name
    fill_in "Last name", with: @course.last_name
    fill_in "Town", with: @course.town_id
    click_on "Update Course"

    assert_text "Course was successfully updated"
    click_on "Back"
  end

  test "destroying a Course" do
    visit courses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course was successfully destroyed"
  end
end
