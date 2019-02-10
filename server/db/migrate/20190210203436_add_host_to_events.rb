class AddHostToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :host, :string
  end
end
