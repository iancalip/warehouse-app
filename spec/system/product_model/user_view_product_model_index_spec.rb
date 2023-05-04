require 'rails_helper'

describe 'Usuário vê modelo de produtos' do

    it 'se estiver autenticado' do
        #Arrange
        #Act
        visit root_path
        within('nav') do
            click_on "Modelos de Produtos"
        end
        #Assert
        expect(current_path).to eq new_user_session_path
    end

    it 'a partir da tela inicial' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        #Act
        login_as(user)
        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end
        #Assert
        expect(current_path).to eq product_models_path
    end

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                        city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        ProductModel.create!(name: 'TV 32', weight: '8000', width: '70', height: '45', depth: '10',
                             sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        ProductModel.create!(name: 'SoundBar 7.1', weight: '3000', width: '80', height: '15', depth: '20',
                             sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        #Assert
        expect(page).to have_content('Samsung')
        expect(page).to have_content('TV 32')
        expect(page).to have_content('TV32-SAMSU-XPTO90000')
        expect(page).to have_content('Samsung')
        expect(page).to have_content('SoundBar 7.1')
        expect(page).to have_content('SOU71-SAMSU-NOIZ7700')
    end

    it 'e não existem produtos cadastrados' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        #Assert
        expect(page).to have_content('Não existem modelos de produtos cadastrados.')
    end
end