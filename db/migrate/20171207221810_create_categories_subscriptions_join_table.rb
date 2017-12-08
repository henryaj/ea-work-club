class CreateCategoriesSubscriptionsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_subscriptions, id: false do |t|
      t.integer :category_id
      t.integer :subscription_id
    end
  end
end
