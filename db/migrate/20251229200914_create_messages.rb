class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.integer :category
      t.text :body

      t.timestamps
    end
  end
end
