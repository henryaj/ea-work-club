class AddRenewedAtToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :renewed_at, :datetime
  end
end
