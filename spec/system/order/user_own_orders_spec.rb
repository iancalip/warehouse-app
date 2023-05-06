require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
    it 'e deve estar autenticado' do
        #Arrange
        #Act
        visit root_path
        click_on 'Meus Pedidos'
        #Assert
        expect(current_path).to eq new_user_session_path
    end

    it 'e não vê outros pedidos' do
        #Arrange
        user_1 = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        user_2 = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        order_1 = Order.create!(user: user_1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        order_2 = Order.create!(user: user_2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        order_3 = Order.create!(user: user_1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 4.day.from_now)
        #Act
        login_as(user_1)
        visit root_path
        click_on 'Meus Pedidos'

        #Assert
        expect(page).to have_content order_1.code
        expect(page).not_to have_content order_2.code
        expect(page).to have_content order_3.code
    end
end