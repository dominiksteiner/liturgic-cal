class CreateCalendarDays < ActiveRecord::Migration[7.1]
  def change
    create_table :calendar_days do |t|
      t.integer :day
      t.integer :month
      t.integer :year
      t.references :liturgic_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
