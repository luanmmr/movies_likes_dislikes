class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy

  
  def likes_total
    likes.length
  end

  def dislikes_total
    dislikes.length
  end
end
