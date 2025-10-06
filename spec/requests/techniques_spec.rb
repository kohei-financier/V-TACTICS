require 'rails_helper'

RSpec.describe "Techniques", type: :request do
  describe "GET /techniques/search" do
    let!(:technique1) { create(:technique, title: "テスト1") }
    let!(:technique2) { create(:technique, title: "テスト2") }

    it "検索結果が正しく表示されること" do
      get search_techniques_path, params: { q: { title_cont: "テスト" } }
      expect(response).to have_http_status(200)
      expect(response.body).to include(technique1.title)
      expect(response.body).to include(technique2.title)
    end

    it "検索結果がない場合にメッセージが表示されること" do
      get search_techniques_path, params: { q: { title_cont: "存在しない" } }
      expect(response).to have_http_status(200)
      expect(response.body).not_to include(technique1.title)
      expect(response.body).not_to include(technique2.title)
    end
  end
end