class RemoveWorkIdFromStaff < ActiveRecord::Migration[5.1]
  def change
    remove_column :staffs, :work_id, :integer
  end
end
