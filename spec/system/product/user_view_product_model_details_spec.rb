require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do
   it 'e vê informações adicionais' do
        #Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                    city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        ProductModel.create!(name: 'TV 32', weight: '8000', width: '70', height: '45', depth: '10',
                            sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        #Act
        visit root_path
        click_on 'Modelos de Produtos'
        click_on 'TV 32'
        #Assert

        expect(page).to have_content('TV 32')
        expect(page).to have_content('8000')
        expect(page).to have_content('70')
        expect(page).to have_content('45')
        expect(page).to have_content('10')
        expect(page).to have_content('TV32-SAMSU-XPTO90000')
        expect(page).to have_content('Samsung')
   end


   it 'e volta para tela inicial' do
        #Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                    city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        ProductModel.create!(name: 'TV 32', weight: '8000', width: '70', height: '45', depth: '10',
                            sku: 'TV32-SAMSU-XPTO90000', supplier: supplier )
        #Act
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
