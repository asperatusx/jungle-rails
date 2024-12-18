require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "will check if user password and password confirmation exist" do
      user = User.create(
        first_name: 'Andrew',
        last_name: 'Lang',
        email: 'a@a.com',
        password: 'test',
        password_confirmation: 'test'
      )

      p user.errors.full_messages

      expect(user).to be_vaild
    end
  end
end
