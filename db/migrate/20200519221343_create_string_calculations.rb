class CreateStringCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :string_calculations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :source_str, null: false
      t.string :comparing_str, null: false
      t.boolean :matching

      t.timestamps
    end
  end
end
