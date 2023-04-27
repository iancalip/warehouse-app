require 'rails_helper'

describe 'Usuário visita página de fornecedores' do
    it 'com sucesso' do
        #Arrange
        #Act
        visit root_path
        click_on 'Fornecedores'
        #Assert
        expect(page).to have_content('Galpões & Estoque')
        expect(page).to have_content('Fornecedores')
        expect(current_path).to eq suppliers_path
    end

    it 'e não existem fornecedores cadastrados' do
        #Arrange
        #Act
        visit root_path
        click_on 'Fornecedores'
        #Assert
        expect(page).to have_content('Não existem fornecedores cadastrados')
    end

    it 'e vê os fornecedores cadastrados' do
        #Arrange
        first_supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')

        second_supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                    city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        #Act
        visit root_path
        click_on 'Fornecedores'
        #Assert
        expect(page).to have_content('LG')
        expect(page).to have_content('contato@lg.com.br')
        expect(page).to have_content('Rio de Janeiro')
        expect(page).to have_content('RJ')

        expect(page).to have_content('Samsung')
        expect(page).to have_content('contato@samsung.com.br')
        expect(page).to have_content('São Paulo')
        expect(page).to have_content('SP')

    end
end