require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
    it 'e visita um pedido' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        product = ProductModel.create!(supplier: supplier, name:'Cadeira Gamer', weight: 5, height: 100, width: 70, depth: 75, sku:'CAD-GAMER-1234567890')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                            estimated_delivery_date: 1.day.from_now, status: :pending)
        OrderItem.create!(order: order, product_model: product, quantity: 5)

        #Act
        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Marcar como Entregue'

        #Assert
        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content "Situação do Pedido: Entregue"
        expect(page).not_to have_button 'Marcar como Cancelado'
        expect(page).not_to have_button 'Marcar como Entregue'
        expect(StockProduct.count).to eq 5
    end

    it 'e o pedido foi cancelado' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        product = ProductModel.create!(supplier: supplier, name:'Cadeira Gamer', weight: 5, height: 100, width: 70, depth: 75, sku:'CAD-GAMER-1234567890')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                            estimated_delivery_date: 1.day.from_now, status: :pending)
        OrderItem.create!(order: order, product_model: product, quantity: 5)
        #Act
        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Marcar como Cancelado'
        #Assert
        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content "Situação do Pedido: Cancelado"
        expect(StockProduct.count).to eq 0
    end
end