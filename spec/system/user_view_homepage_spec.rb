require 'rails_helper'

describe 'Usuario visita tela incial' do
    it 'e vê o nome da app' do
        #Arrange
        #Act
        visit root_path
        #Assert
        expect(page).to have_content('Galpões & Estoque')
    end

    it 'e nao existem galpoes cadastrados' do
        #Arrange
        #Act
        visit root_path
        #Assert
        expect(page).to have_content('Não existem galpões cadastrados')
    end
end

