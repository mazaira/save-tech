class AddUserToItems < ActiveRecord::Migration[6.0]
  def up
    add_reference :items, :user
    add_foreign_key :items, :users, column: :user_id
  end

  def down
    remove_reference :items, :user
    remove_foreign_key :items, :users, column: :user_id
  end
end
