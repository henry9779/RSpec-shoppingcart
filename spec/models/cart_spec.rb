require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '購物車基本功能' do
    it '可將商品放入購物車，購物車內有東西'
    it '如果加入同商品進購物車，購買項目 (CartItem) 不會增加，但數量會增加'
    it '商品可放入購物車，也可再拿出來'
    it '每個購買項目 (CartItem) 可以計算自己的金額 (小計)'
    it '可以計算整台購物車的總金額'
  end

  describe '購物車進階功能' do
    it '可將購物車內容轉換成 Hash，存到 Session 內'
    it '可將 Session 的內容 (Hash格式)，還原回購物車的內容'
  end
end
