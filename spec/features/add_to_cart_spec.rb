require 'rails_helper'

RSpec.feature "User can add item to the cart", type: :feature, js: true do

  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Add product to the cart" do
    visit root_path

    expect(page).to have_button("Add", count: 10)
    
    first(:button, "Add").click
    save_screenshot

    expect(page).to have_content("My Cart (1)")
    puts page.html
  end
end
