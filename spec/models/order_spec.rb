require 'rails_helper'

RSpec.describe Order, type: :model do

    describe '#valid?' do
        it 'deve ter um código' do
            #Arrange
            warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                            address: 'Endereço', cep: '25000-000', description: 'descrição')
            user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                        city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-02')
            #Assert
            expect(order).to be_valid
        end
    end

    describe 'gera um código aleatório' do
        it 'ao criar novo pedido' do
            #Arrange
            warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                            address: 'Endereço', cep: '25000-000', description: 'descrição')
            user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                            city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
            order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-02')
            #Act
            #Assert
            expect(order.code).not_to be_empty
            expect(order.code.length).to eq 8
        end

        it 'e o código é unico' do
            #Arrange
            warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                            address: 'Endereço', cep: '25000-000', description: 'descrição')
            user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                            city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
            first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
            second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-02')
            #Act
            #Assert
            expect(second_order.code).not_to eq first_order.code
            expect(first_order.code.length).to eq 8
        end
    end
end
