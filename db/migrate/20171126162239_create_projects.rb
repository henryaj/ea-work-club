class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :organisation
      t.string :owner_id
      t.string :owner_name
      t.string :contact_email

      t.timestamps
    end
  end
end
