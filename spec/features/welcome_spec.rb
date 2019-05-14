require "rails_helper"

describe "user sees a homepage" do
  it "displays that reviewers name as a link" do
    visit '/'

    expect(page).to have_content("Welcome!")
    expect(page).to have_link("Books Central")
    expect(page.status_code).to be(200)
  end

  it "leads user to /books when clicking Books Central" do
    visit '/'
    click_link("Books Central")

    expect(current_path).to eq(books_path)
  end
end
