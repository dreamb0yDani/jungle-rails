require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    it "should have password and password_confirmation, otherwise invalid" do
      @user = User.create(
        :first_name => "Dani",
        :last_name => "J",
        :email => "testing@testing.com",
        :password => "12345678",
        :password_confirmation => "12345678"
      )

      expect(@user)
      .to be_valid
    end

    it "should have same password and password_confirmation" do
      @user = User.new(
        :first_name => "Dani",
        :last_name => "J",
        :email => "testing@testing.com",
        :password => "1234678",
        :password_confirmation => "12345678"
      )

      expect(@user.password == @user.password_confirmation)
      .to be_falsy
    end

    it "should have password with minimum 8 characters" do
      @user = User.new(
        :first_name => "Dani",
        :last_name => "J",
        :email => "testing@testing.com",
        :password => "123456",
        :password_confirmation => "123456"
      )
      # @user.save!

      expect(@user).to_not be_valid
    end

    it "should have unique email and not case-senstive" do
      @user = User.new(
        :first_name => "Dani",
        :last_name => "J",
        :email => "testing@teSTing.COM",
        :password => "12345678",
        :password_confirmation => "12345678"
      )
      @user.save!

      @user_2 = User.new(
        :first_name => "Dani",
        :last_name => "J",
        :email => "testing@teSTing.COM",
        :password => "12345678",
        :password_confirmation => "12345678"
      )

      expect(@user_2).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    before :each do

      @user_1 = User.create(
        :first_name => "Dani",
        :last_name => "J",
        :email => " testing@testing.COM ",
        :password => "12345678",
        :password_confirmation => "12345678"
      )
    end

    it "should login with spaces before and after the email" do
      user = User.authenticate_with_credentials("testing@testing.com", "12345678")
      expect(user).to eq(@user_1)
    end

    it "should login without case sestivity" do
      user = User.authenticate_with_credentials("TESTING@testing.com", "12345678")
      expect(user).to eq(@user_1)
    end
  end
end
