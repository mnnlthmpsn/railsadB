require "application_system_test_case"

class TownsTest < ApplicationSystemTestCase
  setup do
    @town = towns(:one)
  end

  test "visiting the index" do
    visit towns_url
    assert_selector "h1", text: "Towns"
  end

  test "creating a Town" do
    visit towns_url
    click_on "New Town"

    check "Active status" if @town.active_status
    fill_in "City", with: @town.city_id
    fill_in "Comment", with: @town.comment
    check "Del status" if @town.del_status
    fill_in "Town desc", with: @town.town_desc
    click_on "Create Town"

    assert_text "Town was successfully created"
    click_on "Back"
  end

  test "updating a Town" do
    visit towns_url
    click_on "Edit", match: :first

    check "Active status" if @town.active_status
    fill_in "City", with: @town.city_id
    fill_in "Comment", with: @town.comment
    check "Del status" if @town.del_status
    fill_in "Town desc", with: @town.town_desc
    click_on "Update Town"

    assert_text "Town was successfully updated"
    click_on "Back"
  end

  test "destroying a Town" do
    visit towns_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Town was successfully destroyed"
  end
end
