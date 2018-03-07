class AddLatLonToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :latitude, :float
    add_column :jobs, :longitude, :float
  end
end
