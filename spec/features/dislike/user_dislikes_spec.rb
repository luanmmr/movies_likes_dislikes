require 'rails_helper'

feature 'User dislikes' do
  scenario 'successfully' do
    user = create(:user)

    sign_in(user, scope: :user)
    visit root_path
    within 'td#movie-dislike-1' do
      click_on 'Dislike'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Dislike registrado')
  end

  scenario 'more than twice' do
    user = create(:user)

    sign_in(user, scope: :user)
    visit root_path
    within 'td#movie-dislike-1' do
      click_on 'Dislike'
    end
    within 'td#movie-dislike-2' do
      click_on 'Dislike'
    end
    within 'td#movie-dislike-3' do
      click_on 'Dislike'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Máximo de dislikes atingido')
  end

  scenario 'and if there is an like, remove' do
    user = create(:user)
    
    sign_in(user, scope: :user)
    visit root_path
    within 'td#movie-like-1' do
      click_on 'Like'
    end
    within 'td#movie-dislike-1' do
      click_on 'Dislike'
    end

    expect(page).to have_css('.ls-ico-thumbs-up')
  end
end
