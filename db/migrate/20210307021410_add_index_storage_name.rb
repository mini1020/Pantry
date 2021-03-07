class AddIndexStorageName < ActiveRecord::Migration[6.0]
  def change
    add_index :storages, :place, unique: true
  end
end
