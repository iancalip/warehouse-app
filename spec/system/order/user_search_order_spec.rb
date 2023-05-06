require 'rails_helper'

describe 'usuário busca por um pedido' do
    it 'a partir do menu' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        #Act
        login_as(user)
        visit root_path
        #Assert
        within('header nav') do
            expect(page).to have_field('Buscar Pedido')
            expect(page).to have_button('Buscar')
        end
    end

    it 'e deve ser autenticado' do
        #Arrange

        #Act
        visit root_path
        #Assert
        within('header nav') do
            expect(page).not_to have_field('Buscar Pedido')
            expect(page).not_to have_button('Buscar')
        end
    end

    it 'e encontra um pedido' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user)
        visit root_path
        fill_in 'Buscar Pedido', with: order.code
        click_on 'Buscar'
        #Assert
        expect(page).to have_content("Resultados da Busca por: #{order.code}")
        expect(page).to have_content('1 pedido encontrado')
        expect(page).to have_content("Código: #{order.code}")
        expect(page).to have_content("Galpão Destino: #{order.warehouse.full_description}")
        expect(page).to have_content("Fornecedor: #{order.supplier.corporate_name}")
    end

    it 'e econtra multiplos pedidos' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        second_warehouse = Warehouse.create!(name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 100_000,
                                    address: 'Avenida aeroporto, 3000', cep: '16000-000',
                                    description: 'Galpão para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU67890')
        second_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00000')
        third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user)
        visit root_path
        fill_in 'Buscar Pedido', with: 'GRU'
        click_on 'Buscar'
        #Assert
        expect(page).to have_content('2 pedidos encontrados')
        expect(page).to have_content('GRU12345')
        expect(page).to have_content('GRU67890')
        expect(page).to have_content('Galpão Destino: GRU | Aeroporto SP')
        expect(page).not_to have_content('SDU00000')
        expect(page).not_to have_content('Galpão Destino: SDU | Aeroporto Rio')
    end
end