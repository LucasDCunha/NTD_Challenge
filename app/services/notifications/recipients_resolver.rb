module Notifications
  class RecipientsResolver
    def initialize(category:)
      @category = category
    end

    # Returns: ActiveRecord::Relation<User>
    def call
      User
        .joins(:user_category_subscriptions)
        .where(user_category_subscriptions: { category: category_value })
        .distinct
    end

    private

    attr_reader :category

    # Accepts either Symbol/String ("sports") or Integer (0)
    def category_value
      return category if category.is_a?(Integer)

      Message.categories.fetch(category.to_s)
    end
  end
end
