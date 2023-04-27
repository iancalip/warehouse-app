require 'rails_helper'

describe 'Usuário deleta um galpão' do
    it 'com sucesso' do
        #Arrange
        Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
            address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

        #Act
        visit root_path
        click_on 'Rio'
        click_on 'Editar'
        click_on 'Remover'
        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).not_to have_content('Rio')
        expect(page).not_to have_content('SDU')
    end

    it 'e não apaga outros galpões' do
        #Arrange
        first_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
            address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

        second_warehouse = Warehouse.create!(name: 'Salvador', code: 'SSA', city: 'Salvador', state: 'BA', area: 60_000,
            address: 'São cristovão, 1000', cep: '42000-000', description: 'Galpão do Salvador')

        #Act
        visit root_path
        click_on 'Rio'
        click_on 'Editar'
        click_on 'Remover'
        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).not_to have_content('Rio')
        expect(page).not_to have_content('SDU')
        expect(page).to have_content('Salvador')
        expect(page).to have_content('SSA')
    end
end