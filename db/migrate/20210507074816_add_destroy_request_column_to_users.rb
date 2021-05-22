class AddDestroyRequestColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_deleted, :boolean, null: false, default: false
  end
end
