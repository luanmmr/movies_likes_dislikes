require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    user = create(:user)

    visit root_path
    within 'form' do
      fill_in 'Email', with: 'devise@devise.com.br'
      fill_in 'Password', with: '123456'
      click_on 'Entrar'
    end

    expect(page).to have_content('Você está logado.')
    expect(page).to have_content(user.email)
    expect(page).to have_link('Sair')
    expect(current_path).to eq(root_path)
  end

  scenario 'and logout successfully' do
    user = create(:user)

    sign_in(user, scope: :user)
    visit root_path
    within 'li#logout' do
      click_on 'Sair'
    end

    expect(current_path).to eq(new_user_session_path)
  end
end
