require 'rails_helper'

RSpec.describe "Users", type: :request do
  it "ログインしたら、indexページに飛ぶ" do
    @user = FactoryBot.create(:user)
    sign_in @user
    get techniques_path
    expect(response).to have_http_status(200)
  end

  it "ログアウトしたら、aboutページに飛ぶ" do
    @user = FactoryBot.create(:user)
    sign_in @user
    sign_out @user
    get root_path
    expect(response).to have_http_status(200)
  end
end
