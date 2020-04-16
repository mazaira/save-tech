class AddMetaToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :description, :string
    add_column :items, :image, :string
    add_column :items, :title, :string
  end
end
