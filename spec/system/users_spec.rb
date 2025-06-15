require "rails_helper"

RSpec.describe "Users", type: :system do

  describe "ログイン" do
    let!(:user) { create(:user) }

    context "正常な入力の場合" do
      it "ログイン可能" do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
        expect(page).to have_content "ログインしました"
      end
    end
  end
end