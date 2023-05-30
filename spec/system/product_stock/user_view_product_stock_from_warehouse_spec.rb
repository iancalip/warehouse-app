require 'rails_helper'

describe 'Usuário vê estoque' do
    it 'na tela do galpão' do
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
        product_a = ProductModel.create!(name: 'Produto A', weight: '8000', width: '70', height: '45', depth: '10',
                                sku: 'PRODUTO-A/1234567890', supplier: supplier)
        product_b = ProductModel.create!(name: 'Produto B', weight: '3000', width: '80', height: '15', depth: '20',
                                sku: 'PRODUTO-B/1234567890', supplier: supplier)
        product_c = ProductModel.create!(name: 'Produto C', weight: '4000', width: '90', height: '15', depth: '20',
                                sku: 'PRODUTO-C/1234567890', supplier: supplier)
        3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a) }
        2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_b) }
        #act
        login_as user
        visit root_path
        click_on 'Aeroporto SP'
        #Assert
        within("section#stock_products") do
            expect(page).to have_content 'Itens em Estoque'
            expect(page).to have_content '3 x PRODUTO-A/1234567890'
            expect(page).to have_content '2 x PRODUTO-B/1234567890'
        end
    end

    it 'e dá baixa em um item' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
                                    address: 'Avenida aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
        product= ProductModel.create!(name: 'Produto A', weight: '8000', width: '70', height: '45', depth: '10',
                                sku: 'PRODUTO-A/1234567890', supplier: supplier)
        2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product) }
        #Act
        login_as user
        visit root_path
        click_on 'Aeroporto SP'
        select 'PRODUTO-A/1234567890', from: 'Item para Saída'
        fill_in 'Destinatário', with: 'Maria Ferreira'
        fill_in 'Endereço Destino', with: 'Rua Destino, 100 - Destino, Destinolandia'
        click_on 'Confirmar Retirada'

        #Assert
        expect(current_path).to eq warehouse_path(warehouse.id)
        expect(page).to have_content 'Item retirado com sucesso!'
        expect(page).to have_content '1 x PRODUTO-A/1234567890'
    end
end