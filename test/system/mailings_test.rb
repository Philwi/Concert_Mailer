require "application_system_test_case"

class MailingsTest < ApplicationSystemTestCase
  setup do
    @mailing = mailings(:one)
  end

  test "visiting the index" do
    visit mailings_url
    assert_selector "h1", text: "Mailings"
  end

  test "creating a Mailing" do
    visit mailings_url
    click_on "New Mailing"

    click_on "Create Mailing"

    assert_text "Mailing was successfully created"
    click_on "Back"
  end

  test "updating a Mailing" do
    visit mailings_url
    click_on "Edit", match: :first

    click_on "Update Mailing"

    assert_text "Mailing was successfully updated"
    click_on "Back"
  end

  test "destroying a Mailing" do
    visit mailings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mailing was successfully destroyed"
  end
end
