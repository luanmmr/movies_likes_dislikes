require 'rails_helper'

RSpec.describe Dislike, type: :model do

  describe 'validates#episode_id' do
    it 'verify presence' do
      dislike = Dislike.new

      dislike.valid?

      expect(dislike.errors[:episode_id]).to include('não pode ficar em branco')
    end

    it 'episode_id is an numeric' do
      dislike = Dislike.new(episode_id: 'a')

      dislike.valid?

      expect(dislike.errors[:episode_id]).to include('não é um número')
    end

    it 'episode_id is a integer' do
      dislike = Dislike.new(episode_id: 1.5)
  
      dislike.valid?
  
      expect(dislike.errors[:episode_id]).to include('não é um número inteiro')
    end
  end

  describe 'validates#user' do
    it 'verify uniqueness' do
      user = create(:user)
      Dislike.create(user: user, episode_id: 1)
      other_dislike = Dislike.new(user: user, episode_id: 1)

      other_dislike.valid?
      
      expect(other_dislike.errors[:user]).to include('já presente nos dislikes desse filme')
    end
  end

  describe 'validate#maximum_dislikes' do
    it 'user reached maximum dislike' do
      user = create(:user)
      Dislike.create(user: user, episode_id: 1)
      Dislike.create(user: user, episode_id: 2)
      dislike = Dislike.new(user: user, episode_id: 3)

      dislike.valid?
      
      expect(dislike.errors.full_messages).to include('Máximo de dislikes atingido')
    end

    it 'user has not yet reached maximum dislike' do
      user = create(:user)
      Dislike.create(user: user, episode_id: 1)
      dislike = Dislike.new(user: user, episode_id: 2)

      dislike.valid?

      expect(dislike.errors.full_messages).to_not include('Máximo de dislikes atingido')
    end
  end

  describe '.repeated_movie?' do
    it 'true' do
      user = create(:user)
      Dislike.create(user: user, episode_id: 1)

      result = Dislike.repeated_movie?(user_id: user.id, episode_id: 1)

      expect(result).to eq(true)
    end
    
    it 'false' do
      user = create(:user)
      Dislike.create(user: user, episode_id: 1)
  
      result = Dislike.repeated_movie?(user_id: user.id, episode_id: 2)
  
      expect(result).to eq(nil)
    end 
  end

end