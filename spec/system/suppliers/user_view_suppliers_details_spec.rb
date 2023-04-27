require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
    it 'e vê informações adicionais' do
       #Arrange
       Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                        city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
       #Act
       visit root_path
       click_on 'Fornecedores'
       click_on 'LG'
       #Assert
       expect(page).to have_content('Fornecedor: LG')
       expect(page).to have_content('Razão social: LG Electronics Inc')
       expect(page).to have_content('E-mail: contato@lg.com.br')
       expect(page).to have_content('CNPJ: 1234567890000')
       expect(page).to have_content('Endereço: Endereço')
       expect(page).to have_content('Cidade: Rio de Janeiro')
       expect(page).to have_content('UF: RJ')
       expect(page).to have_content('Telefone: 1199999-9999')
    end

    it 'e volta para tela inicial' do
        #Arrange
        Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
            city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')


        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LG'
        click_on 'Home'

        #Assert
        expect(current_path).to eq root_path
    end
end