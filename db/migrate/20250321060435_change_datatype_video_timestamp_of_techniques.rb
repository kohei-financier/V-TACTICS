class ChangeDatatypeVideoTimestampOfTechniques < ActiveRecord::Migration[7.2]
  def change
    change_column :techniques, :video_timestamp, :string
  end
end
