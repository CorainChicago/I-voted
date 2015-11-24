class CreateReminderEmails < ActiveRecord::Migration
  def change
    create_table :reminder_emails do |t|
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
