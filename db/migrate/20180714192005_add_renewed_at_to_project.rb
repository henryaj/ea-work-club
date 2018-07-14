class AddRenewedAtToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :renewed_at, :datetime
  end
end
