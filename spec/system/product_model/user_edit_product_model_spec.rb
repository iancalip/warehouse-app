require 'rails_helper'

describe 'Usuário edita um modelo de produto' do
    it 'a partir da tela inicial' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                    city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        product_model = ProductModel.create!(name: 'TV 32', weight: '8000', width: '70', height: '45', depth: '10',
                                            category: 'categoria', description: 'descrição', supplier: supplier)
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'TV 32'
        click_on 'Editar'

        #Assert
        expect(page).to have_field('Nome', with: 'TV 32')
        expect(page).to have_field('Peso', with: '8000')
        expect(page).to have_field('Largura', with: '70')
        expect(page).to have_field('Altura', with: '45')
        expect(page).to have_field('Profundidade', with: '10')
        expect(page).to have_field('Fornecedor', with: supplier.id)
        expect(page).to have_content('Editar Modelo de produto')
    end

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                    city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        second_supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                            city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        product_model = ProductModel.create!(name: 'TV 32', weight: '8000', width: '70', height: '45', depth: '10',
                                            category: 'categoria', description: 'descrição', supplier: supplier)
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'TV 32'
        click_on 'Editar'

        fill_in('Nome', with: 'TV 33')
        fill_in('Peso', with: '9000')
        fill_in('Largura', with: '80')
        fill_in('Altura', with: '50')
        fill_in('Profundidade', with: '15')
        fill_in('Categoria', with: 'Eletrônicos')
        fill_in('Descrição', with: 'TV grande')
        select 'LG', from: 'Fornecedor'
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('TV 33')
        expect(page).to have_content('9000g')
        expect(page).to have_content('50cm x 80cm x 15cm')
        expect(page).to have_content("#{product_model.identifier}")
        expect(page).to have_content('TV grande')
        expect(page).to have_content('Eletrônicos')
        expect(page).to have_content('LG')
    end

    it 'sem sucesso' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                    city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        product_model = ProductModel.create!(name: 'TV 32', weight: '8000', width: '70', height: '45', depth: '10',
                                            category: 'categoria', description: 'descrição', supplier: supplier)

        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'TV 32'
        click_on 'Editar'

        fill_in('Nome', with: '')
        fill_in('Peso', with: '')
        fill_in('Largura', with: '')
        fill_in('Altura', with: '')
        fill_in('Profundidade', with: '')
        fill_in('Categoria', with: '')
        fill_in('Descrição', with: '')
        click_on 'Enviar'

        expect(page).to have_content('Não foi possível atualizar o modelo de produto.')
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
end