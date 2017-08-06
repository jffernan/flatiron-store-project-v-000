class Item < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  has_many :order_items

  def remove_inventory(order_value)
    self.inventory = self.inventory - order_value
    save
  end

  def formatted_price
    self.price.to_f/100.round(2)
  end

  def in_stock?
    if inventory > 0
      true
    end
  end

  def self.available_items
    available_items = all.to_a.keep_if {|item| item.inventory > 0}
  end

end
