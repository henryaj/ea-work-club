class AddOwnerNameToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :owner_name, :string
  end
end
