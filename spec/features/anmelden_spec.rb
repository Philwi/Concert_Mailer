require 'rails_helper'

describe "Neuanmeldung eines Users", type: :feature do
  it "Anmelden" do
    visit '/'
    fill_in 'signUpName', with: "Heinz Müller"
    fill_in 'signUpEmail', with: "heinz.mueller@web.de"
    fill_in 'signUpPassword', with: "hallo123"
    click_on('Anmelden')

  end
end
