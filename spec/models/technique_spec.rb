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

  describe "calculate_video_timestampメソッドのチェック" do
    let(:technique) { build(:technique, :youtube, user: user, video_timestamp: video_timestamp) }

    context "HH:MM:SS形式の場合" do
      let(:video_timestamp) { "01:30:30" }
      it "正しく秒変換できること" do
        expect(technique.calculate_video_timestamp).to eq(5430)
      end
    end

    context "MM:SS形式の場合" do
      let(:video_timestamp) { "30:30" }
      it "正しく秒変換できること" do
        expect(technique.calculate_video_timestamp).to eq(1830)
      end
    end

    context "SS形式の場合" do
      let(:video_timestamp) { "30" }
      it "正しく秒変換できること" do
        expect(technique.calculate_video_timestamp).to eq(30)
      end
    end

    context "予期せぬ値の場合" do
      let(:video_timestamp) { "01:30:30:30" }
      it "0になること" do
        expect(technique.calculate_video_timestamp).to eq(0)
      end
    end
  end
end
