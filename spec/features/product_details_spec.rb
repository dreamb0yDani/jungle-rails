require 'rails_helper'

RSpec.feature "Visitor can navigate to product details", type: :feature, js: true do

  #SETUP
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

  scenario "User can see product details" do
    visit root_path
    
    first(".detail-info").click
    # save_screenshot "detail-info.png"
  end
end
