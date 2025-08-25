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

  let(:owner_user) { create(:user) }
  let(:technique) { create(:technique, user: owner_user) }

  describe "techniqueの所有者かどうかチェック" do
    context "テクニックの所有者の場合" do
      it "own?がtrueか" do
        expect(owner_user.own?(technique)).to be true
      end
    end

    context "テクニックの所有者ではない（他のユーザーが持っている）場合" do
      it "own?がfalseか" do
        expect(user.own?(technique)).to be false
      end
    end
  end

  describe "お気に入り機能のチェック" do
    # 事前にデータを作成しておく
    let!(:user) { create(:user) }
    let!(:technique) { create(:technique) }

    context "favoriteメソッド" do
      it "テクニックをお気に入り登録できるか" do
        # あるUserがテクニックをお気に入りする
        user.favorite(technique)
        # そのユーザーのマイページに上でお気に入りにいれたテクニックが見えるかを期待する
        expect(user.favorite_techniques).to include(technique)
      end
    end

    context "unfavoriteメソッド" do
      it "テクニックをお気に入り登録できるか" do
        user.favorite(technique)
        # ここでお気に入り解除
        user.unfavorite(technique)
        # そうすると、マイページに出てこないことが期待されるはず
        expect(user.favorite_techniques).not_to include(technique)
      end
    end

    context "favorite?メソッド" do
      it "お気に入り登録したらTrueを返すか" do
        user.favorite(technique)
        # trueを返すか確認
        expect(user.favorite?(technique)).to be true
      end
      it "お気に入りしてなかったらFalseを返すか" do
        # falseを返すか確認
        expect(user.favorite?(technique)).to be false
      end
    end
  end
end
