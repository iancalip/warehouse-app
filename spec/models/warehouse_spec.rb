require 'rails_helper'

RSpec.describe Warehouse, type: :model do
    describe '#valid?' do
        it 'false when name is empty' do
            #Arrange
            warehouse = Warehouse.new(name: '', code: 'RIO', city: 'Rio', area: 1000,
                                    address: 'Endereço', cep: '25000-000', description: 'descrição')
            #Act
            #Assert
            expect(warehouse).not_to be_valid
            #expect(warehouse).not_to be_valid - boa pratica em algumas situações
        end

        it 'false when code is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio de Janeiro', code: '', city: 'Rio', area: 1000,
                                    address: 'Endereço', cep: '25000-000', description: 'descrição')
            #Act
            #Assert
            expect(warehouse).not_to be_valid
        end

        it 'false when city is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', city: '', area: 1000,
                                    address: 'Endereço', cep: '25000-000', description: 'descrição')
            #Act
            #Assert
            expect(warehouse).not_to be_valid
        end

        it 'false when area is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', area: '',
                                    address: 'Endereço', cep: '25000-000', description: 'descrição')
            #Act
            #Assert
            expect(warehouse).not_to be_valid
        end

        it 'false when address is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', area: 1000,
                                    address: '', cep: '25000-000', description: 'descrição')
            #Act
            #Assert
            expect(warehouse).not_to be_valid
        end

        it 'false when cep is empty' do
            #Arrange
            warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', area: 1000,
                                    address: 'Endereço', cep: '', description: 'descrição')
            #Act
            #Assert
            expect(warehouse).not_to be_valid
        end

        it 'false when description is empty' do
            #Arrange
            warehouse = Warehouse.create(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', area: 1000,
                                    address: 'Endereço', cep: '25000-000', description: '')
            #Act
            #Assert
            expect(warehouse).not_to be_valid
        end

        it 'false when code is already in use' do
            #Arrange
            first_warehouse = Warehouse.create(name: 'Rio de Janeiro', code: 'RIO', city: 'Rio', area: 1000,
                address: 'Endereço', cep: '25000-000', description: 'descrição')

            second_warehouse = Warehouse.new(name: 'Niterói', code: 'RIO', city: 'Niterói', area: 1000,
                address: 'Endereço', cep: '35000-000', description: 'descrição')
            #Act
            #Assert
            expect(second_warehouse).not_to be_valid
        end
    end


end
