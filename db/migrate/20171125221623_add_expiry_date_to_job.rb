class AddExpiryDateToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :expiry_date, :date
  end
end
