module FoodsHelper
  # 保管場所表示
  def where_storage(storage_id)
    storage = Storage.find(storage_id)
    storage.place
  end

end
