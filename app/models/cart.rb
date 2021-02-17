class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_item(product_id)
    found_item = items.find { |item| item.product_id == product_id }

    if found_item
      found_item.increment
    else
      @items << CartItem.new(product_id)
    end

    def total_price
      items.reduce(0) { |sum, item| sum + item.price }
    end
  end

  def serialize
    all_items = items.map { |item|
      { 'product_id' => item.product_id, 'quantity' => item.quantity }
    }

    { 'items' => all_items }
  end

  def self.from_hash(hash)
    if hash.nil?
      new []
    else
      new hash['items'].map { |item|
        CartItem.new(item['product_id'], item['quantity'])
      }
    end
  end

end