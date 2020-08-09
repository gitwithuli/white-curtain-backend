module Followable
  extend ActiveSupport::Concern
  included do
    has_many :follows, as: :followable
    has_many :users, through: :follows
    after_create :create_follow
  end

  def create_follow
    Follow.create(user: self.creator_id, followable_type: self.class.name, followable_id: self.id)
  end
end
