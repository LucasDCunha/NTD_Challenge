class CreateUserChannelPreferences < ActiveRecord::Migration[7.2]
  def change
    create_table :user_channel_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :channel

      t.timestamps
    end
  end
end
