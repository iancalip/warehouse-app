require 'rails_helper'

RSpec.describe User, type: :model do
    describe '#description' do
        it 'exibe o nome e o email' do
            #Arrange
            u = User.new(name: 'Julia Almeida', email: 'julia@email.com')

            #Assert
            expect(u.full_description).to eq('Julia Almeida | julia@email.com')
        end
    end
end
