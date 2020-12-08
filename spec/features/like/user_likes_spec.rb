require 'rails_helper'

feature 'User likes' do
  scenario 'successfully' do
    user = create(:user)

    sign_in(user, scope: :user)
    visit root_path
    within 'td#movie-like-1' do
      click_on 'Like'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Like registrado')
  end

  scenario 'more than twice' do
    user = create(:user)

    sign_in(user, scope: :user)
    visit root_path
    within 'td#movie-like-1' do
      click_on 'Like'
    end
    within 'td#movie-like-2' do
      click_on 'Like'
    end
    within 'td#movie-like-3' do
      click_on 'Like'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Máximo de likes atingido')
  end

  scenario 'and if there is an deslike, remove' do
    user = create(:user)
    
    sign_in(user, scope: :user)
    visit root_path
    within 'td#movie-dislike-1' do
      click_on 'Dislike'
    end
    within 'td#movie-like-1' do
      click_on 'Like'
    end
    
    expect(page).to have_css('.ls-ico-thumbs-up2')
  end

  scenario 'and remove same like' do
    user = create(:user)
    
    sign_in(user, scope: :user)
    visit root_path
    within 'td#movie-like-1' do
      click_on 'Like'
    end
    within 'td#movie-like-1' do
      click_on 'Like'
    end

    expect(page).to have_no_css('.ls-ico-checkmark')
    expect(page).to have_css('.ls-ico-thumbs-up')
  end

end
