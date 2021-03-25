class DropSentEmails < ActiveRecord::Migration[6.1]
  def change
    drop_table :sent_emails
  end
end
