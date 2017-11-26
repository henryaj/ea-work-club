class AddOwnerIdToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :owner_id, :string
  end
end
