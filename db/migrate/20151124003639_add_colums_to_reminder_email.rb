class AddColumsToReminderEmail < ActiveRecord::Migration
  def change
    add_column :reminder_emails, :subject, :string
  end
end
