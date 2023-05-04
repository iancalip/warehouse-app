require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        #Arrange
        User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        #Act
        visit root_path
        within('nav') do
            click_on 'Login'
        end
        within('form') do
            fill_in 'E-mail', with: 'ian@email.com'
            fill_in 'Senha', with: 'password'
            click_on 'Log in'
        end
        #Assert
        within('nav') do
            expect(page).not_to have_link 'Login'
            expect(page).to have_button 'Sair'
            expect(page).to have_content 'Ian | ian@email.com'
        end
        expect(page).to have_content 'Login efetuado com sucesso'
    end

    it 'faz logout' do
        #Arrange
        User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        #Act
        visit root_path
        click_on 'Login'
        fill_in 'E-mail', with: 'ian@email.com'
        fill_in 'Senha', with: 'password'
        within('form') do
            click_on 'Log in'
        end
        click_on 'Sair'
        #Assert
        expect(page). to have_link 'Login'
        expect(page).not_to have_button 'Sair'
        expect(page).to have_content 'Logout efetuado com sucesso'
        expect(page).not_to have_content 'Ian | ian@email.com'
    end
end