require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
    it 'e vê informações adicionais' do
       #Arrange
       Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                        address: 'Avenida aeroporto, 1000', cep: '15000-000',
                        description: 'Galpão para cargas internacionais')
       #Act
       visit root_path
       click_on 'Aeroporto SP'
       #Assert
       expect(page).to have_content('Galpão: GRU')
       expect(page).to have_content('Nome: Aeroporto SP')
       expect(page).to have_content('Cidade: Guarulhos')
       expect(page).to have_content('Estado: SP')
       expect(page).to have_content('Área: 100000')
       expect(page).to have_content('Endereço: Avenida aeroporto, 1000 CEP: 15000-000')
       expect(page).to have_content('Descrição: Galpão para cargas internacionais')
    end

    it 'e volta para tela inicial' do
        #Arrange
        Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
            address: 'Avenida aeroporto, 1000', cep: '15000-000',
            description: 'Galpão para cargas internacionais')

        #Act
        visit root_path
        click_on 'Aeroporto SP'
        click_on 'Home'

        #Assert
        expect(current_path).to eq root_path
    end
end
