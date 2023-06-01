require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de sério' do
    it 'ao criar um StockProduct' do
      warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
        address: 'Endereço', cep: '25000-000', description: 'descrição')
      user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: :delivered)
      product = ProductModel.create!(name: 'Cadeira Gamer', supplier: supplier, weight: 5, height: 70, width: 75, depth: 80,
                                      category: 'categoria', description: 'descrição')
      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      #Assert
      expect(stock_product.serial_number.length).to eq 20

    end

    it 'e não é modificado' do
      warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                    address: 'Endereço', cep: '25000-000', description: 'descrição')
      other_warehouse = Warehouse.create!(name: 'São Paulo', code: 'SPL', city: 'São Paulo', state: 'SP', area: 1000,
                                      address: 'Endereço', cep: '25000-000', description: 'descrição')
      user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: :delivered)
      product = ProductModel.create!(name: 'Cadeira Gamer', supplier: supplier, weight: 5, height: 70, width: 75, depth: 80,
                                      category: 'categoria', description: 'descrição')
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = stock_product.serial_number
      #act
      stock_product.update!(warehouse: other_warehouse)
      #Assert
      expect(stock_product.serial_number).to eq original_serial_number
    end
  end

  describe '#available?' do
    it 'true se não houver destino' do
      #Arrange
      warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                    address: 'Endereço', cep: '25000-000', description: 'descrição')
      user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: :delivered)
      product = ProductModel.create!(name: 'Cadeira Gamer', supplier: supplier, weight: 5, height: 70, width: 75, depth: 80,
                                      category: 'categoria', description: 'descrição')

      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      #Assert
      expect(stock_product.available?).to eq true
    end

    it 'false se tiver destino' do
      warehouse = Warehouse.create!(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', state: 'RJ', area: 1000,
                                    address: 'Endereço', cep: '25000-000', description: 'descrição')
      user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now, status: :delivered)
      product = ProductModel.create!(name: 'Cadeira Gamer', supplier: supplier, weight: 5, height: 70, width: 75, depth: 80,
                                      category: 'categoria', description: 'descrição')

      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      stock_product.create_stock_product_destination!(recipient: "user", address: "rua do user")

      #Assert
      expect(stock_product.available?).to eq false
    end
  end

end
