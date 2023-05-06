require 'rails_helper'
describe 'Usuário edita um pedido' do
    it 'e visita um pedido' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        visit edit_order_path(order.id)
        #Assert
        expect(current_path).to eq new_user_session_path
    end

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
                        address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        warehouse_2 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')

        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        visit root_path
        login_as(user)
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Editar'
        select warehouse_2.full_description, from: 'Galpão Destino'
        fill_in 'Data Prevista de Entrega', with: '20/12/2100'
        click_on 'Gravar'

        #Assert
        expect(page).to have_content 'Data Prevista de Entrega: 20/12/2100'
        expect(page).to have_content 'Pedido atualizado com sucesso'
        expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    end

    it 'caso seja o responsável' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        user_2 = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
                        address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')

        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user_2)
        visit edit_order_path(order.id)

        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content('Você não possui acesso a esse pedido.')
    end
end