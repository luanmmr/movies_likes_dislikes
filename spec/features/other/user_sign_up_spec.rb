require 'rails_helper'

feature 'User Sign Up' do
  scenario 'successfully' do
    visit root_path
    click_on 'Criar Conta'
    within 'form' do
      fill_in 'Email', with: 'devise@devise.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content('devise@devise.com.br')
  end
end
