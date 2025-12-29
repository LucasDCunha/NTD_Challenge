class CreateNotificationLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :notification_logs do |t|
      t.references :message, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.integer :channel, null: false
      t.integer :status, null: false, default: 0

      t.datetime :delivered_at
      t.text :error_message

      t.timestamps
    end

    add_index :notification_logs, :created_at
    add_index :notification_logs, [:message_id, :created_at]
    add_index :notification_logs, [:user_id, :created_at]
    add_index :notification_logs, [:channel, :status]
  end
end
