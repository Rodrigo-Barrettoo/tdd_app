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

  scenario 'Verifica formulário de Novo Cliente' do
    visit(new_customer_path)
    customer_name = Faker::Name.name

    fill_in('customer_name', with: customer_name)
    fill_in('customer_email', with: Faker::Internet.email)
    fill_in('customer_phone', with: Faker::PhoneNumber.phone_number)

    attach_file('customer_avatar', "#{Rails.root}/spec/fixtures/avatar.png")
    choose(option: ['S', 'N'].sample)

    click_on('Criar Cliente')

    expect(page).to have_content('Cliente cadastrado com sucesso!')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario 'does something' do
    visit(new_customer_path)
    click_on('Criar Cliente')

    expect(page).to have_content('não pode ficar em branco')
  end
end
