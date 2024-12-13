class AboutController < ApplicationController
  def index
    @product = Product.first
  end
end
