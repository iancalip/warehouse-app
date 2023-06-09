require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do
   it 'e vê informações adicionais' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                    city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        ProductModel.create!(name: 'TV 32', weight: '8000', width: '70', height: '45', depth: '10',
                            category: 'categoria', description: 'descrição', supplier: supplier)
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'TV 32'
        #Assert

        expect(page).to have_content('TV 32')
        expect(page).to have_content('8000')
        expect(page).to have_content('70')
        expect(page).to have_content('45')
        expect(page).to have_content('10')
        expect(page).to have_content("#{ProductModel.last.identifier}")
        expect(page).to have_content('Samsung')
        expect(page).to have_content('categoria')
        expect(page).to have_content('descrição')
   end


   it 'e volta para tela inicial' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                    city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        ProductModel.create!(name: 'TV 32', weight: '8000', width: '70', height: '45', depth: '10',
                            category: 'categoria', description: 'descrição', supplier: supplier)
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'TV 32'
        within('nav') do
            click_on 'Home'
        end
        #Assert
        expect(current_path).to eq root_path
    end
end
