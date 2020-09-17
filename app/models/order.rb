class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_quantity
    item_orders.sum(:quantity)
  end

  def change_status_cancel
    update_attribute(:order_status, "cancelled")
  end

  def change_status_packaged
    if item_orders.where(order_status: 'fulfilled').count == item_orders.count
      update_attribute(:order_status, 'packaged')
    end
  end

  def merchant_items(merch_id)
    items.select("items.id, items.name, items.image, items.price, item_orders.quantity").joins(:item_orders).where(merchant_id: merch_id)
  end
end
