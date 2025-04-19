require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validationチェック" do
    it "正常ログイン" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
