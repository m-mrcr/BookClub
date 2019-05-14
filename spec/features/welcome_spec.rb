require "rails_helper"

describe "user sees a homepage" do
  it "displays that reviewers name as a link" do
    visit '/'

    expect(page).to have_content("Welcome!")
    expect(page).to have_link("Continue to Books")
    expect(page.status_code).to be(200)
  end
end
