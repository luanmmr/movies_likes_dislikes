FactoryBot.define do
  factory :like do
    user_id { create(:user) }
    episode_id { 1 }
  end
end