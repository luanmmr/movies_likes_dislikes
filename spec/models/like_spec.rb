require 'rails_helper'

RSpec.describe Like, type: :model do

  describe 'validates#episode_id' do
    it 'verify presence' do
      like = Like.new

      like.valid?

      expect(like.errors[:episode_id]).to include('não pode ficar em branco')
    end

    it 'episode_id is an numeric' do
      like = Like.new(episode_id: 'a')

      like.valid?

      expect(like.errors[:episode_id]).to include('não é um número')
    end

    it 'episode_id is a integer' do
      like = Like.new(episode_id: 1.5)
  
      like.valid?
  
      expect(like.errors[:episode_id]).to include('não é um número inteiro')
    end
  end

  describe 'validates#user' do
    it 'verify uniqueness' do
      user = create(:user)
      Like.create(user: user, episode_id: 1)
      other_like = Like.new(user: user, episode_id: 1)

      other_like.valid?
      
      expect(other_like.errors[:user]).to include('já presente nos likes desse filme')
    end
  end

  describe 'validate#maximum_likes' do
    it 'user reached maximum likes' do
      user = create(:user)
      Like.create(user: user, episode_id: 1)
      Like.create(user: user, episode_id: 2)
      like = Like.new(user: user, episode_id: 3)

      like.valid?
      
      expect(like.errors.full_messages).to include('Máximo de likes atingido')
    end

    it 'user has not yet reached maximum likes' do
      user = create(:user)
      Like.create(user: user, episode_id: 1)
      like = Like.new(user: user, episode_id: 2)

      like.valid?

      expect(like.errors.full_messages).to_not include('Máximo de likes atingido')
    end
  end

  describe '.repeated_movie?' do
    it 'true' do
      user = create(:user)
      Like.create(user: user, episode_id: 1)

      result = Like.repeated_movie?(user_id: user.id, episode_id: 1)

      expect(result).to eq(true)
    end
    
    it 'false' do
      user = create(:user)
      Like.create(user: user, episode_id: 1)
  
      result = Like.repeated_movie?(user_id: user.id, episode_id: 2)
  
      expect(result).to eq(nil)
    end 
  end

end