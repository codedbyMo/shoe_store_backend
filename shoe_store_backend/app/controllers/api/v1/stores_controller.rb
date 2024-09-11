module Api
  module V1
    class StoresController < ApplicationController
      def inventory
        store = Store.find(params[:id]) # This will raise an error if the store is not found
        shoe_models = store.shoe_models

        render json: { store: store.name, shoe_models: shoe_models }
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Store not found" }, status: :not_found
      end
    end

    def suggest_transfers
      stores = Store.all
  
      transfer_suggestions = []
  
      stores.each do |store|
        store.shoe_models.each do |shoe_model|
          if shoe_model.inventory < 5
            # Find other stores with high stock of the same shoe model
            source_store = Store.joins(:shoe_models)
                                .where('shoe_models.model = ? AND shoe_models.inventory > ?', shoe_model.model, 50)
                                .first
            if source_store
              transfer_suggestions << {
                from: source_store.name,
                to: store.name,
                model: shoe_model.model,
                inventory_to_transfer: 10 # Suggest transferring 10 pairs
              }
            end
          end
        end
      end
  
      render json: { suggestions: transfer_suggestions }
    end
  end
end
