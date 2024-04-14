class CreateCelebrations < ActiveRecord::Migration[7.1]
  def change
    create_table :celebrations do |t|
      t.string :title
      t.string :colour
      t.string :rank
      t.string :rank_num
      t.references :liturgic_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
