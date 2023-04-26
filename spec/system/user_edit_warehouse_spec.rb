require 'rails_helper'

describe 'Usuŕario edita um galpão' do
    it 'A partir da tela inicial' do
        #Arrange
        Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

        #Act
        visit root_path
        click_on 'Rio'
        click_on 'Editar'

        #Assert
        expect(page).to have_content('Editar Galpão')
        expect(page).to have_field('Nome', with: 'Rio')
        expect(page).to have_field('Código', with: 'SDU')
        expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
        expect(page).to have_field('Área', with: '60000')
        expect(page).to have_field('Endereço', with: 'Avenida do Porto, 1000')
        expect(page).to have_field('CEP', with: '20000-000')
        expect(page).to have_field('Descrição', with: 'Galpão do Rio')
    end

    it 'Com sucesso' do
        #Arrange
        Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

        #Act
        visit root_path
        click_on 'Rio'
        click_on 'Editar'
        fill_in('Nome', with: 'Aeroporto do Rio')
        fill_in('Código', with: 'SRJ')
        fill_in('Cidade', with: 'Rio de Janeiro')
        fill_in('Área', with: '80000')
        fill_in('Endereço', with: 'Avenida do amanhã')
        fill_in('CEP', with: '20500-001')
        fill_in('Descrição', with: 'Galpão do Rio de Janeiro')
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Galpão atualizado com sucesso.')
        expect(page).to have_content('Nome: Aeroporto do Rio')
        expect(page).to have_content('Galpão: SRJ')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('Área: 80000')
        expect(page).to have_content('Endereço: Avenida do amanhã')
        expect(page).to have_content('CEP: 20500-001')
        expect(page).to have_content('Descrição: Galpão do Rio de Janeiro')
    end

    it 'e mantém os campos obrigatórios'do
        #Arrange
        Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

        #Act
        visit root_path
        click_on 'Rio'
        click_on 'Editar'
        fill_in 'Nome', with: ''
        fill_in 'Código', with: ''
        fill_in 'Cidade', with: ''
        fill_in 'Área', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'CEP', with: ''
        fill_in 'Descrição', with: ''
        click_on 'Enviar'

        #Assert
        expect(page).to have_content('Não foi possível atualizar o galpão.')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Código não pode ficar em branco')
        expect(page).to have_content('Cidade não pode ficar em branco')
        expect(page).to have_content('Área não pode ficar em branco')
        expect(page).to have_content('Endereço não pode ficar em branco')
        expect(page).to have_content('CEP não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
    end
end
