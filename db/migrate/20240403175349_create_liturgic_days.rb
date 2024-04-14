class CreateLiturgicDays < ActiveRecord::Migration[7.1]
  def change
    create_table :liturgic_days do |t|
      t.string :season
      t.string :season_week
      t.string :weekday

      t.timestamps
    end
  end
end
