require 'rails_helper'

describe 'product_model API' do
    context 'GET/api/v1/product_models/1' do
        it 'success' do
            #Arrange
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                        city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
            product_model = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, category: 'Eletronicos',
                                               description: 'TV grande', supplier: supplier)
            #Act
            get "/api/v1/product_models/#{product_model.id}"

            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'

            json_response = JSON.parse(response.body)

            expect(json_response["name"]).to eq('TV 32')
            expect(json_response["weight"]).to eq 8000
            expect(json_response["width"]).to eq 70
            expect(json_response["height"]).to eq 45
            expect(json_response["depth"]).to eq 10
            expect(json_response["category"]).to eq('Eletronicos')
            expect(json_response["description"]).to eq('TV grande')
            expect(json_response.keys).not_to include('supplier')

        end

        it 'fail if product model not found' do
            #Arrange
            #Act
            get "/api/v1/product_models/9999999"
            #Assert
            expect(response.status).to eq 404
        end
    end

    context 'GET/api/v1/product_models' do
        it 'success' do
            #Arrange
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung', registration_number: '1234567891111',
                                        city: 'São Paulo', state: 'SP', address: 'Endereço', email: 'contato@samsung.com.br', telephone: '1188888-8888')
            product_model = ProductModel.create!(name: 'TV 32', weight: '8000', width: '70', height: '45', depth: '10', category: 'Eletronicos',
                                                 description: 'TV grande', supplier: supplier)
            other_product_model = ProductModel.create!(name: 'Notebook', weight: '8000', width: '70', height: '45', depth: '10', category: 'Eletronicos',
                                                     description: 'TV grande', supplier: supplier)
            #Act
            get "/api/v1/product_models"

            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'

            json_response = JSON.parse(response.body)

            expect(json_response.class).to eq Array
            expect(json_response.length).to eq 2
            expect(json_response[1]["name"]).to eq "TV 32"
            expect(json_response[0]["name"]).to eq "Notebook"
        end

        it 'return empty if there is no product_model' do
            #Arrange
            #Act
            get "/api/v1/product_models"
            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'

            json_response = JSON.parse(response.body)
            expect(json_response).to eq []
        end

        it 'and raise internal error' do
            #Arrange
            allow(ProductModel).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

            #Act
            get "/api/v1/product_models"

            #Assert
            expect(response.status).to eq 500
        end
    end

    context 'POST /api/v1/product_models' do
        it 'success' do
            #Arrange
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung',
                                        registration_number: '1234567891111', city: 'São Paulo', state: 'SP', address: 'Endereço',
                                        email: 'contato@samsung.com.br', telephone: '1188888-8888')
            product_model_params = { product_model: { name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                                    category: 'Eletronicos', description: 'TV grande', supplier_id: supplier.id } }
            #Act
            post '/api/v1/product_models', params: product_model_params

            #Assert
            expect(response).to have_http_status(201)
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)

            expect(json_response["name"]).to eq('TV 32')
            expect(json_response["weight"]).to eq 8000
            expect(json_response["width"]).to eq 70
            expect(json_response["height"]).to eq 45
            expect(json_response["depth"]).to eq 10
            expect(json_response["category"]).to eq('Eletronicos')
            expect(json_response["description"]).to eq('TV grande')
            expect(json_response.keys).not_to include('supplier')

        end

        it 'fail if parameters are missing' do
            #Arrange
            product_model_params = { product_model: { name: 'TV 32' } }
            #Act
            post '/api/v1/product_models', params: product_model_params

            #Assert
            expect(response).to have_http_status(412)
            expect(response.body).not_to include('Nome não pode ficar em branco')
            expect(response.body).to include('Peso não pode ficar em branco')
            expect(response.body).to include('Largura não pode ficar em branco')
            expect(response.body).to include('Altura não pode ficar em branco')
            expect(response.body).to include('Profundidade não pode ficar em branco')
            expect(response.body).to include('Categoria não pode ficar em branco')
            expect(response.body).to include('Descrição não pode ficar em branco')
        end

        it 'fail if there is an internal error' do
            #Arrange
            supplier = Supplier.create!(corporate_name: 'Samsung Electronics Inc', brand_name: 'Samsung',
                                        registration_number: '1234567891111', city: 'São Paulo', state: 'SP', address: 'Endereço',
                                        email: 'contato@samsung.com.br', telephone: '1188888-8888')
            allow(ProductModel).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
            product_model_params = { product_model: { name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                                    category: 'Eletronicos', description: 'TV grande', supplier_id: supplier.id } }
            #Act
            post '/api/v1/product_models', params: product_model_params

            #Assert
            expect(response).to have_http_status(500)
        end
    end
end
