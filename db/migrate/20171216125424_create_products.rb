class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :value
      t.integer :identifier

      t.timestamps
    end
  end
end
