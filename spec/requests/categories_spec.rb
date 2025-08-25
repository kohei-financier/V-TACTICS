require 'rails_helper'

# どのテストかを宣言する
RSpec.describe "Categories", type: :request do
  describe "カテゴリー一覧を取得する（index）" do
    let!(:category1) { create(:category, name: "ジェット") }
    let!(:category2) { create(:category, name: "初心者") }

    before do
      get categories_path
    end

    it "リクエストが成功しているか" do
      expect(response).to have_http_status(200)
    end
    it "すべてのカテゴリー（@categories）が正しく取得できるか" do
      expect(response.body).to include(category1.name)
      expect(response.body).to include(category2.name)
    end
  end

  describe "カテゴリー詳細ページを取得する(show)" do
    let!(:category) { create(:category) }
    let!(:youtube_technique) { create(:technique, :youtube, category_ids: [ category.id ]) }
    let!(:twitter_technique) { create(:technique, :twitter, category_ids: [ category.id ]) }

    before do
      get category_path(category)
    end

    it "youtubeテクニックとそのIDが表示されるか" do
      expect(response.body).to include(youtube_technique.title)
    end

    it "twitterテクニックとそのIDが表示されるか" do
      expect(response.body).to include(twitter_technique.title)
    end
  end
end
