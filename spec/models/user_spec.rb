require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }

  describe "validationチェック" do

    context "名前が存在する場合" do
      it "ログインが有効か" do
        user = build(:user, name: "テストユーザー")
        expect(user).to be_valid
      end
    end

    context "名前が存在しない場合" do
      it "ログインが無効か" do
        user = build(:user, name: nil)
        expect(user).to_not be_valid
        expect(user.errors[:name]).to include("を入力してください")
      end
    end

    context "名前が255文字を超える場合" do
      it "ログインが無効か" do
        too_long_name = "a"*31
        user = build(:user, name: too_long_name)
        expect(user).to_not be_valid
        expect(user.errors[:name]).to include("は30文字以内で入力してください")
      end
    end

    context "emailが無い場合" do
      it "ログインが無効か" do
        too_long_name = "a"*31
        user = build(:user, email: nil)
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include("を入力してください")
      end
    end

    context "emailがユニークで無い場合" do
      it "ログインが無効か" do
        create(:user, email: "test@example.com")
        user = build(:user, email: "test@example.com")
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include("はすでに存在します")
      end
    end
  end
end
