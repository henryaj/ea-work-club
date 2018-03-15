class AddRemoteToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :remote, :bool
  end
end
