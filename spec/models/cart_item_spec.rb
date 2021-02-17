require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it '每個購買項目 CartItem 可以計算自己的金額 (小計)' do
    cart = Cart.new
    p1 = Product.create(title:'Ruby', price:70)
    p2 = Product.create(title:'Rails', price:90)

    2.times { cart.add_item(p1.id) }
    3.times { cart.add_item(p2.id) }
    4.times { cart.add_item(p1.id) }

    expect(cart.items.first.price).to be 420
    expect(cart.items.second.price).to be 270
  end
end
