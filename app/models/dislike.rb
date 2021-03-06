class Dislike < ApplicationRecord
  belongs_to :user
  validates :episode_id,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :user,
            uniqueness: { scope: :episode_id,
                          message: I18n.t(:dislike_uniqueness,
                                          scope: %i[activerecord errors
                                                    messages user]) }
  validate :maximum_dislikes

  def self.repeated_movie?(user_id:, episode_id:)
    return unless user_id && episode_id

    result = Dislike.where(user_id: user_id,
                           episode_id: episode_id).length
    return true if result != 0
  end

  private

  def maximum_dislikes
    return unless user_id

    user = User.find(user_id)
    return unless user.dislikes.length > 1

    errors[:base] << I18n.t(:maximum_dislikes, scope: %i[activerecord errors
                                                         messages])
  end
end
