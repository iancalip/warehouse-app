require 'rails_helper'

describe 'Usuŕario cadastra um fornecedor' do
    it 'a partir da tela inicial' do
        #Arrange
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar fornecedor'

        #Assert
        expect(page).to have_field('Nome fantasia')
        expect(page).to have_field('Razão social')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('UF')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('E-mail')
        expect(page).to have_field('Telefone')
    end

    it 'com sucesso' do
        #Arrage
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar fornecedor'

        fill_in('Nome fantasia', with: 'LG')
        fill_in('Razão social', with: 'LG Electronics Inc')
        fill_in('Cidade', with: 'Rio de Janeiro')
        fill_in('UF', with: 'RJ')
        fill_in('CNPJ', with: '1234567890000')
        fill_in('Endereço', with: 'Avenida Museu do Amanhã, 1000')
        fill_in('Telefone', with: '1199999-9999')
        fill_in('E-mail', with: 'contato@lg.com.br')
        click_on 'Enviar'

        #Assert
        expect(current_path).to eq suppliers_path
        expect(page).to have_content 'LG'
        expect(page).to have_content 'Rio de Janeiro'
        expect(page).to have_content 'RJ'
        expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    end

    it 'com dados incompletos' do
        #Arrange
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar fornecedor'

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
        expect(page).to have_content('Fornecedor não cadastrado, preencha todos os campos.')
        expect(page).to have_content('Nome fantasia não pode ficar em branco')
        expect(page).to have_content('Razão social não pode ficar em branco')
        expect(page).to have_content('E-mail não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('CNPJ não possui o tamanho esperado (13 caracteres)')
    end
end