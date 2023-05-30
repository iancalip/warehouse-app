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
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.month.from_now)
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
            order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
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
            first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.month.from_now)
            second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.year.from_now)
            #Act
            #Assert
            expect(second_order.code).not_to eq first_order.code
            expect(first_order.code.length).to eq 8
        end


        it 'data estimada de entrega deve ser obrigatória' do
            #Arrange
            warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                            address: 'Endereço', cep: '25000-000', description: 'descrição')
            user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                            city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '')
            #Act
            #Assert
            expect(order).not_to be_valid
            expect(order.errors[:estimated_delivery_date]).to include('não pode ficar em branco')
        end

        it 'data estimada não deve ser passada' do
            #Arrange
            warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                            address: 'Endereço', cep: '25000-000', description: 'descrição')
            user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                            city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.ago)
            #Act
            #Assert
            expect(order).not_to be_valid
            expect(order.errors[:estimated_delivery_date]).to include('deve ser futura.')
        end

        it 'data estimada não deve ser hoje' do
            #Arrange
            warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                            address: 'Endereço', cep: '25000-000', description: 'descrição')
            user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                            city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.today)
            #Act
            #Assert
            expect(order).not_to be_valid
            expect(order.errors[:estimated_delivery_date]).to include('deve ser futura.')
        end

        it 'e não deve ser modificado' do
            warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                            address: 'Endereço', cep: '25000-000', description: 'descrição')
            user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                            city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
            order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
            original_code = order.code
            #ACT
            order.update!(estimated_delivery_date: 1.week.from_now)
            #Assert
            expect(order.code).to eq(original_code)
        end
    end
end
