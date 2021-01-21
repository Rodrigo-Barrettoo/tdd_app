require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario 'Verificar o link Cadastro de Clientes' do
    visit(root_path)
    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario 'Link de Novo Cliente' do    
    visit(root_path)    
    click_on('Cadastro de Clientes')
    expect(page).to have_content('Listando Clientes') 
    expect(page).to have_link('Novo Cliente')  
  end

  scenario 'Verifica formulário de Novo Cliente' do    
    visit(customers_path)    
    click_on('Novo Cliente')
    expect(page).to have_content('Novo Cliente')  
  end
end
