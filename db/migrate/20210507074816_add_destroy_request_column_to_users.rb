class AddDestroyRequestColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :destroy_request, :boolean, null: false, default: false
  end
end
