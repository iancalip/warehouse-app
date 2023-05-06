require 'rails_helper'

describe 'Usuário cadastra um pedido'do

    it 'e deve estar autenticado' do
        #Arrange
        #Act
        visit root_path
        click_on 'Registrar Pedido'

        #Assert
        expect(current_path).to eq new_user_session_path
    end

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
                        address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                    city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')

        allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
        #Act
        visit root_path
        login_as(user)
        click_on 'Registrar Pedido'
        select warehouse.full_description, from: 'Galpão Destino'
        select supplier.full_description, from: 'Fornecedor'
        fill_in 'Data Prevista de Entrega', with: '20/12/2100'
        click_on 'Gravar'

        #Assert
        expect(page).to have_content 'Pedido ABC12345'
        expect(page).to have_content 'Pedido registrado com sucesso'
        expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
        expect(page).to have_content 'Fornecedor: LG Electronics Inc | 1234567890000'
        expect(page).to have_content 'Data Prevista de Entrega: 20/12/2100'
        expect(page).to have_content 'Usuário Responsável: Ian | ian@email.com'
        expect(page).not_to have_content 'Galpão Maceio'
        expect(page).not_to have_content 'Samsung Electronics Inc'
    end
end