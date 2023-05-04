require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    it 'false when corporate name is empty' do
        #Arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'LG', registration_number: '1234567890000',  city: 'Rio de Janeiro',
                        state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
        #Act
        #Assert
        expect(supplier).not_to be_valid
    end

    it 'false when brand name is empty' do
      #Arrange
      supplier = Supplier.new(corporate_name: 'LG Electronics Inc', brand_name: '', registration_number: '1234567890000',
                            city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
      #Act
      #Assert
      expect(supplier).not_to be_valid
    end

    it 'false when registration number is empty' do
      #Arrange
      supplier = Supplier.new(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '', city: 'Rio de Janeiro',
                             state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')
      #Act
      #Assert
      expect(supplier).not_to be_valid
    end

    it 'false when e-mail is empty' do
      #Arrange
      supplier = Supplier.new(corporate_name: 'LG Electronics Inc', brand_name: '', registration_number: '1234567890000',
                            city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: '', telephone: '1199999-9999')
      #Act
      #Assert
      expect(supplier).not_to be_valid
    end

    it 'false when registration number is already in use' do
      #Arrange
      first_supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                              city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')

      second_supplier = Supplier.new(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567890000',
                              city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
      #Act
      #Assert
      expect(second_supplier).not_to be_valid
    end

    it 'false when registration number is not 13 characters long' do
      #Arrange
      supplier = Supplier.new(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                              city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: '', telephone: '1199999-9999')
      #Act
      #Assert
      expect(supplier).not_to be_valid
    end

  end

  describe '#full_description' do
    it "description" do
         #Arrange
         supplier = Supplier.new(corporate_name: 'LG Electronics Inc', registration_number: '1234567890000')
         #Act
         #Assert
         expect(supplier.full_description).to eq('LG Electronics Inc | 1234567890000')
     end
 end
end
