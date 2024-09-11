class InventoryAlertService
  MINIMUM_STOCK_THRESHOLD = 5
  
  def self.check_inventory(stock)
    stock < MINIMUM_STOCK_THRESHOLD
  end
end