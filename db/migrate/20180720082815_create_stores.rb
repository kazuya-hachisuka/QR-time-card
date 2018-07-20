class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :store_name, null: false, index: true

      t.timestamps
    end
  end
end
