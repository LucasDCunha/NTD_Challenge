class CreateUserCategorySubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :user_category_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :category

      t.timestamps
    end
  end
end
