require 'rails_helper'

describe 'Usuário visita tela inicial' do
    it 'e vê os galpões cadastrados' do
        #Arrange
        #casdastrar 2 galpoes: Rio e Maceio
        Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro' , state: 'RJ', area: 60_000,
                        address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

        Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio' , state: 'AL', area: 50_000,
                        address: 'Avenida Atlântica, 50', cep: '80000-000', description: 'Galpão de Maceió')
        #Act
        visit root_path
        #Assert
        #garantir que eu vejo os galpoes Rio e Maceió
        expect(page).not_to have_content('Não existem galpões cadastrados')
        expect(page).to have_content('Rio')
        expect(page).to have_content('Código: SDU')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('60000')

        expect(page).to have_content('Maceio')
        expect(page).to have_content('Código: MCZ')
        expect(page).to have_content('Cidade: Maceio')
        expect(page).to have_content('50000')
    end
end
