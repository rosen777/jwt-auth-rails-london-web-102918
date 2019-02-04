class RemoveBioFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :bio, :string
  end
end
