class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items
  belongs_to :user

  def total
    total = 0
    line_items.each {|line_item| total = total + line_item.item.price * line_item.quantity}
    total
  end

  def place_order
    submitted = true
    save
    line_items.each do |line_item|
      line_item.item.remove_inventory(line_item.quantity)
    end
  end

  def has_item(item_id)
    self.items.find_by_id(item_id)
  end

  def add_item(item_id)
    if line_item = line_items.find_by(item_id: item_id)
      line_item.quantity += 1
    else
      line_item = line_items.new({:item_id => item_id})
    end
      line_item
  end

end
