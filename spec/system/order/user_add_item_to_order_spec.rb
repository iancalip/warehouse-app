require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'User', email: 'user@email.com', password: 'password')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG',
                                    registration_number: '1234567890000', city: 'Rio de Janeiro', state: 'RJ',
                                    address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                            estimated_delivery_date: 1.day.from_now)
        product_a = ProductModel.create!(name: 'Produto A', weight: '8000', width: '70', height: '45', depth: '10',
                                        category: 'categoria', description: 'descrição', supplier: supplier)
        product_b = ProductModel.create!(name: 'Produto B', weight: '3000', width: '80', height: '15', depth: '20',
                                        category: 'categoria', description: 'descrição', supplier: supplier)
        #Act
        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Adicionar Item'

        select 'Produto A', from: 'Produto'
        fill_in 'Quantidade', with: '8'
        click_on 'Gravar'

        #Arrange
        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content 'Item adicionado com sucesso'
        expect(page).to have_content '8 x Produto A'
    end

    it 'e não vê produto de outro fornecedor' do
        #Arrange
        user = User.create!(name: 'User', email: 'user@email.com', password: 'password')
        supplier_a = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG',
                                    registration_number: '1234567890000', city: 'Rio de Janeiro', state: 'RJ',
                                    address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        supplier_b = Supplier.create!(corporate_name: 'Fornecedor B', brand_name: 'FB',
                                    registration_number: '9876543210000', city: 'Rio de Janeiro', state: 'RJ',
                                    address: 'Endereço', email: 'contato@fb.com.br', telephone: '1199999-0000')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a,
                            estimated_delivery_date: 1.day.from_now)
        product_a = ProductModel.create!(name: 'Produto A', weight: '8000', width: '70', height: '45', depth: '10',
                                category: 'categoria', description: 'descrição', supplier: supplier_a)
        product_b = ProductModel.create!(name: 'Produto B', weight: '3000', width: '80', height: '15', depth: '20',
                                category: 'categoria', description: 'descrição', supplier: supplier_b)
        #Act
        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Adicionar Item'

        #Arrange
        expect(page).to have_content 'Produto A'
        expect(page).not_to have_content 'Produto B'
    end
end