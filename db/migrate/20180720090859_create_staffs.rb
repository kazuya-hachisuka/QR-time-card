class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.string :family_name,      null: false
      t.string :given_name,       null: false
      t.string :family_name_kana, null: false
      t.string :given_name_kana,  null: false
      t.string :qrcode,           null: false
      t.integer :status,          null: false,  default: 0
      t.integer :store_id,        null: false
      t.integer :work_id

      t.timestamps
    end
  end
end
