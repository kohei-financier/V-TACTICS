require 'rails_helper'

RSpec.describe "Techniques", type: :system do
  it "GET /users/sign_in" do
    visit "/users/sign_in"
    expect(page).to have_text("ログイン")
  end
end
