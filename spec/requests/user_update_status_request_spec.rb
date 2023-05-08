require 'rails_helper'

describe 'Usuário tenta atualizar um status' do
    it 'caso seja o responsável' do
        #Arrange
        user = User.create!(name: 'Ian', email: 'ian@email.com', password: 'password')
        user_2 = User.create!(name: 'Carlos', email: 'carlos@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
                        address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        supplier = Supplier.create!(corporate_name: 'LG Electronics Inc', brand_name: 'LG', registration_number: '1234567890000',
                                    city: 'Rio de Janeiro', state: 'RJ', address: 'Endereço', email: 'contato@lg.com.br', telephone: '1199999-9999')

        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user_2)
        post(delivered_order_path(order.id))

        #Assert
        expect(response).to redirect_to root_path
        end
end