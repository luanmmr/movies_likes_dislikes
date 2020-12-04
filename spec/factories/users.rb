FactoryBot.define do
  factory :user do
    email { 'devise@devise.com.br' }
    password { '123456' }
  end
end
