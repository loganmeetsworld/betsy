module OrderitemsHelper
  def ship_status(orderitem)
    orderitem.shipped ? "Cancel Shipping" : "Ship it"    
  end
end
