require 'rails_helper'

RSpec.describe "Users::Sessions", type: :request do
  let(:user) { create(:user) }

  describe "サインアウト" do
    before do
      sign_in user
    end

    it "ログアウト成功→トップページにリダイレクト" do
      delete destroy_user_session_path
      expect(response).to be_redirect
      expect(response).to redirect_to(root_path)
    end
  end
end