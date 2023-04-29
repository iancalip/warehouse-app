require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10,
                          sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when weight is empty' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: nil, width: 70, height: 45, depth: 10,
                          sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when weight is 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 0, width: 70, height: 45, depth: 10,
                                        sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when weight is less than 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: -3, width: 70, height: 45, depth: 10,
                                        sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when width is empty' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: nil, height: 45, depth: 10,
                                      sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when width is 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: 0, height: 45, depth: 10,
                                      sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when width is less than 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: -3, height: 45, depth: 10,
                                      sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when height is empty' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: 70, height: nil, depth: 10,
                                      sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when height is 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: 70, height: 0, depth: 10,
                                      sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when height is less than 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: 70, height: -3, depth: 10,
                                        sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when depth is empty' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: 70, height: 45, depth: nil,
                                      sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when depth is 0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: 70, height: 45, depth: 0,
                                      sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when depth is less than  0' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: 70, height: 45, depth: -3,
                                       sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when sku is empty' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: 70, height: 45, depth: 10,
                          sku: '', supplier: supplier)
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when sku is different than 20 chars' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      product_model = ProductModel.new(name: 'TV32', weight: 8000, width: 70, height: 45, depth: 10,
                          sku: 'TV32-SAMSU-XPTO900000', supplier: supplier )
      #Assert
      expect(product_model).not_to be_valid
    end

    it 'false when sku already exists' do
      #Arrange
      supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                  city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      first_product_model = ProductModel.create!(name: 'TV32', weight: 8000, width: 70, height: 45, depth: 10,
                                            sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      second_product_model = ProductModel.new(name: 'SoundBar 7.1', weight: 3000, width: 80, height: 15, depth: 20,
                                              sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      #Assert
      expect(second_product_model).not_to be_valid
    end

    it 'false when supplier doesnt exist' do
      #Arrange
      product_model = ProductModel.new(name: 'SoundBar 7.1', weight: 3000, width: 80, height: 15, depth: 20,
                                              sku: 'TV32-SAMSU-XPTO90000', supplier: nil)
      #Assert
      expect(product_model).not_to be_valid
    end
  end
end
