class AddUniqueIndexesToSubscriptionsAndPreferences < ActiveRecord::Migration[7.2]
  def change
    add_index :user_category_subscriptions,
              [:user_id, :category],
              unique: true,
              name: "index_user_category_unique"

    add_index :user_channel_preferences,
              [:user_id, :channel],
              unique: true,
              name: "index_user_channel_unique"
  end
end
