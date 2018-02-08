class CreateSentEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :sent_emails do |t|
      t.references :user, foreign_key: true
      t.string :email
      t.string :status
      t.string :handler_id
      t.text :body

      t.timestamps
    end
  end
end
