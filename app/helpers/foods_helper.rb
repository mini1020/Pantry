module FoodsHelper

  def where_storage(storage_id)
    storage = Storage.find(storage_id)
    storage.place
  end

end
