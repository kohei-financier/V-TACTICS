require 'rails_helper'

RSpec.describe Technique, type: :model do
  let(:user) { create(:user) }

  describe "youtube_video_idメソッドのチェック" do
    let(:expected_video_id) { "oUUoFnbZBy0" }

    context "source_typeがyoutubeの場合" do
      let(:technique) { build(:technique, :youtube, user: user) }

      it "ブラウザのアドレスバーからIDが抽出できること" do
        technique.source_url = "https://www.youtube.com/watch?v=#{expected_video_id}"
        expect(technique.youtube_video_id).to eq(expected_video_id)
      end

      it "共有ボタンから出てきたURLからIDが抽出できること" do
        technique.source_url = "https://youtu.be/#{expected_video_id}?si=qCvLUszo6GeYKETE"
        expect(technique.youtube_video_id).to eq(expected_video_id)
      end

      it "想定していないURLにはnilを返すこと" do
        technique.source_url = "https://x.com/valesportscl_jp/status/1959522926560186823"
        expect(technique.youtube_video_id).to be_nil
      end
    end

    context "source_typeがtwitterの場合" do
      let(:technique) { build(:technique, :twitter, user: user) }

      it "nilになること" do
        expect(technique.youtube_video_id).to be_nil
      end
    end
  end
end