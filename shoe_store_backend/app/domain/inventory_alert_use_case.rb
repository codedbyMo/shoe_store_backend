class InventoryAlertUseCase
    def initialize(alert_service)
      @alert_service = alert_service
    end
  
    def process_inventory_update(store, model, inventory)
      if @alert_service.check_inventory(inventory)
        notify_low_stock(store, model, inventory)
      end
    end
  
    private
  
    def notify_low_stock(store, model, inventory)
      # Notify via WebSocket or HTTP
      puts "Alert: #{store} - #{model} has low inventory: #{inventory} pairs left"
      # This would connect to the WebSocket broadcast in the adapter layer
    end
  end