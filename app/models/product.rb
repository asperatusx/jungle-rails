class Product < ApplicationRecord
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validate :price_cant_be_nil

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true


  private

  def price_cant_be_nil
    if price_cents == 0
      errors.add(:price, 'cannot be blank')
    end
  end

end
