require 'rails_helper'

describe 'Usuário edita um fornecedor' do
    it 'A partir da tela inicial' do
       #Arrange
       Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                        city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
       #Act
       visit root_path
       click_on 'Fornecedores'
       click_on 'LG'
       click_on 'Editar'

       #Assert
       expect(page).to have_content('Editar Fornecedor')
       expect(page).to have_field('Nome fantasia', with: 'LG')
       expect(page).to have_field('Razão social', with: 'LG Electronics Inc')
       expect(page).to have_field('E-mail', with: 'contato@lg.com.br')
       expect(page).to have_field('CNPJ', with: '1234567890000')
       expect(page).to have_field('Endereço', with: 'Endereço')
       expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
       expect(page).to have_field('UF', with: 'RJ')
       expect(page).to have_field('Telefone', with: '1199999-9999')
    end

    it 'com sucesso' do
        #Arrange
        Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                        city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LG'
        click_on 'Editar'

        fill_in('Nome fantasia', with: 'ÉLIGÊ')
        fill_in('Razão social', with: 'LG Electronics Inc')
        fill_in('Cidade', with: 'Rio de Janeiro')
        fill_in('UF', with: 'RJ')
        fill_in('CNPJ', with: '1234567890000')
        fill_in('Endereço', with: 'Centro, 1000')
        fill_in('Telefone', with: '1199999-7777')
        fill_in('E-mail', with: 'contato@lg')

        #Assert
        expect(page).to have_field('Nome fantasia', with: 'ÉLIGÊ')
        expect(page).to have_field('Razão social', with: 'LG Electronics Inc')
        expect(page).to have_field('E-mail', with: 'contato@lg')
        expect(page).to have_field('CNPJ', with: '1234567890000')
        expect(page).to have_field('Endereço', with: 'Centro, 1000')
        expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
        expect(page).to have_field('UF', with: 'RJ')
        expect(page).to have_field('Telefone', with: '1199999-7777')
    end

    it 'sem sucesso' do
        #Arrange
        Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                        city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LG'
        click_on 'Editar'

        fill_in('Nome fantasia', with: '')
        fill_in('Razão social', with: '')
        fill_in('Cidade', with: '')
        fill_in('UF', with: '')
        fill_in('CNPJ', with: '')
        fill_in('Endereço', with: '')
        fill_in('Telefone', with: '')
        fill_in('E-mail', with: '')
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Não foi possível atualizar o fornecedor.')
        expect(page).to have_content('Nome fantasia não pode ficar em branco')
        expect(page).to have_content('Razão social não pode ficar em branco')
        expect(page).to have_content('E-mail não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('CNPJ não possui o tamanho esperado (13 caracteres)')
    end
end