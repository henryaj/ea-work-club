class AddUrlToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :url, :string
  end
end
