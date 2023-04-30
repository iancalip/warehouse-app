require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        #Arrange
        #Act
        visit root_path
        click_on 'Login'
        click_on 'Criar conta'
        fill_in 'Nome', with: 'Ian'
        fill_in 'E-mail', with: 'ian@email.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'

        #Assert
        expect(page).to have_button 'Sair'
        expect(page).to have_content 'ian@email.com'
        expect(page).to have_content 'Usuário cadastrado com sucesso'
        expect(User.last.name).to eq 'Ian'
    end
end