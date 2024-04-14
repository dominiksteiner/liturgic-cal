class CreateMedia < ActiveRecord::Migration[7.1]
  def change
    create_table :media do |t|
      t.string :external_id
      t.string :title
      t.string :description
      t.datetime :published_at
      t.string :thumbnail_url
      t.string :url
      t.references :liturgic_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
