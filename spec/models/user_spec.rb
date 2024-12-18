require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "will check if user can be created if all fields exist and are valid" do
      user = User.create(
        first_name: 'Andrew',
        last_name: 'Lang',
        email: 'a@a.com',
        password: 'test123',
        password_confirmation: 'test123'
      )

      p user.errors.full_messages

      expect(user).to be_valid
    end

    it 'is invalid without a password' do
      user = User.new(password: nil, password_confirmation: 'password')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is invalid without a password confirmation' do
      user = User.new(password: 'password', password_confirmation: nil)
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'is invalid when password and password confirmation do not match' do
      user = User.new(password: 'password', password_confirmation: 'different')
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'requires email to be unique (case insensitive)' do
      User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(email: 'TEST@example.COM', password: 'password', password_confirmation: 'password')
      user.valid?
      expect(user.errors.full_messages).to include('Email has already been taken')
    end

    it 'requires first name, last name, and email to be present' do
      user = User.new(first_name: nil, last_name: nil, email: nil)
      user.valid?
      expect(user.errors.full_messages).to include(
        "First name can't be blank",
        "Last name can't be blank",
        "Email can't be blank"
      )
    end

    it 'is invalid if the password is too short' do
      user = User.new(password: 'short', password_confirmation: 'short')
      user.valid?
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
  end

  describe '.authenticate_with_credentials' do
    let!(:user) do
      User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'authenticates with correct email and password' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'does not authenticate with incorrect password' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates even if email has spaces around it' do
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates even if email has different case' do
      authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.COM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
