require 'rails_helper'

describe 'Usuŕario cadastra um modelo de produto' do
    it 'a partir da tela inicial' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'Cadastrar modelo de produto'

        #Assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Peso')
        expect(page).to have_field('Largura')
        expect(page).to have_field('Altura')
        expect(page).to have_field('Profundidade')
        expect(page).to have_field('Fornecedor')
        expect(page).to have_content('Novo Modelo de Produto')
    end

    it 'com sucesso' do
        #Arrage
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                        city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'Cadastrar modelo de produto'

        fill_in('Nome', with: 'TV 33')
        fill_in('Peso', with: '8000')
        fill_in('Largura', with: '70')
        fill_in('Altura', with: '45')
        fill_in('Profundidade', with: '10')
        fill_in('Categoria', with: 'categoria')
        fill_in('Descrição', with: 'descrição')
        select 'Samsung', from: 'Fornecedor'
        click_on 'Enviar'

        #Assert
        expect(current_path).to eq product_models_path
        expect(page).to have_content 'TV 33'
        expect(page).to have_content "#{ProductModel.last.identifier}"
        expect(page).to have_content 'Samsung'
        expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    end

    it 'com dados incompletos' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'Cadastrar modelo de produto'

        fill_in('Nome', with: '')
        fill_in('Peso', with: '')
        fill_in('Largura', with: '')
        fill_in('Altura', with: '')
        fill_in('Profundidade', with: '')
        fill_in('Categoria', with: '')
        fill_in('Descrição', with: '')
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Modelo de produto não cadastrado, preencha todos os campos.')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Peso não pode ficar em branco')
        expect(page).to have_content('Largura não pode ficar em branco')
        expect(page).to have_content('Altura não pode ficar em branco')
        expect(page).to have_content('Categoria não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Peso não é um número')
        expect(page).to have_content('Largura não é um número')
        expect(page).to have_content('Altura não é um número')
        expect(page).to have_content('Profundidade não é um número')
    end

    it 'com 0 nas dimensões' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'Cadastrar modelo de produto'

        fill_in('Peso', with: 0)
        fill_in('Largura', with: 0)
        fill_in('Altura', with: 0)
        fill_in('Profundidade', with: 0)
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Peso deve ser maior que 0')
        expect(page).to have_content('Largura deve ser maior que 0')
        expect(page).to have_content('Altura deve ser maior que 0')
        expect(page).to have_content('Profundidade deve ser maior que 0')
    end

    it 'com números menores que 0' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'Cadastrar modelo de produto'

        fill_in('Peso', with: -9)
        fill_in('Largura', with: -9)
        fill_in('Altura', with: -1)
        fill_in('Profundidade', with: -2)
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Peso deve ser maior que 0')
        expect(page).to have_content('Largura deve ser maior que 0')
        expect(page).to have_content('Altura deve ser maior que 0')
        expect(page).to have_content('Profundidade deve ser maior que 0')
    end
end