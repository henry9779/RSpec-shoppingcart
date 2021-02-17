require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '購物車基本功能' do

    it '可將商品放入購物車，購物車內有東西' do
      cart = Cart.new
      cart.add_item 1
      expect(cart.nil?).to be false
    end

    it '如果加入同商品進購物車，購買項目 (CartItem) 不會增加，但數量會增加' do
      cart = Cart.new
      3.times { cart.add_item(1) }
      2.times { cart.add_item(2) }
      5.times { cart.add_item(3) }

      expect(cart.items.length).to be 3
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.quantity).to be 2
    end

    it '商品可放入購物車，也可再拿出來' do
      cart = Cart.new
      p1 = Product.create(title:'Ruby')
      p2 = Product.create(title:'Rails')

      2.times { cart.add_item(p1.id) }
      5.times { cart.add_item(p2.id) }

      expect(cart.items.first.product_id).to be p1.id
      expect(cart.items.second.product_id).to be p2.id
      expect(cart.items.first.product).to be_a Product
    end

    it '可以計算整台購物車的總金額' do
      cart = Cart.new
      p1 = Product.create(title:'Ruby', price:80)
      p2 = Product.create(title:'Rails', price:60)

      5.times {
        cart.add_item(p1.id)
        cart.add_item(p2.id)
      }

      expect(cart.total_price).to be 700
    end

  end

  describe '購物車進階功能' do

    it '可將購物車內容轉換成 Hash，存到 Session 內' do
      cart = Cart.new

      3.times { cart.add_item(1) }
      4.times { cart.add_item(2) }

      expect(cart.serialize).to eq session_hash
    end

    it '可將 Session 的內容 (Hash格式)，還原回購物車的內容' do
      cart = Cart.from_hash(session_hash)

      expect(cart.items.first.product_id).to be 1
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.product_id).to be 2
      expect(cart.items.second.quantity).to be 4
    end
  end

  private
  def session_hash
    {
      'items' => [
        { 'product_id' => 1, 'quantity' => 3 },
        { 'product_id' => 2, 'quantity' => 4 }
      ]
    }
  end
end
