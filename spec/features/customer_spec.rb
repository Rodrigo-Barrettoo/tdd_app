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

  scenario 'Não cadastra um cliente em inválido' do
    visit(new_customer_path)
    click_on('Criar Cliente')

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'Mostra um cliente' do
    customer = create(:customer)
    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
  end

  scenario 'Testando a Index' do
    customer1 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['S', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    )

    customer2 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['S', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    )

    visit(customers_path)
    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end

  scenario 'Atualiza um Cliente' do
    customer = create(:customer)
    new_name = Faker::Name.name
    visit(edit_customer_path(customer.id))
    fill_in('customer_name', with: new_name)

    click_on('Atualizar Cliente')

    expect(page).to have_content('Cliente atualizado com sucesso!')
    expect(page).to have_content(new_name)
  end

  scenario 'Link Mostrar' do
    customer = create(:customer)
    visit(customers_path)

    find(:xpath, "/html/body/table/tbody/tr/td[2]/a").click
    expect(page).to have_content('Mostrando Cliente')
  end

  scenario 'Link Editar' do
    customer = create(:customer)
    visit(customers_path)

    find(:xpath, "/html/body/table/tbody/tr/td[3]/a").click
    expect(page).to have_content('Editando Cliente')
  end

  scenario 'Link Excluir', js: true do
    customer = create(:customer)
    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr/td[4]/a").click

    2.second

    page.driver.browser.switch_to.alert.accept

    expect(page).to have_content('Cliente excluido com sucesso!')
  end
end
