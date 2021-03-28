class AddIndexFoodsName < ActiveRecord::Migration[6.0]
  def change
    add_index :foods, :fname
  end
end
