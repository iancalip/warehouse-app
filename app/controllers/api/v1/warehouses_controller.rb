 class Api::V1::WarehousesController < ActionController::API
    def show
        begin
            warehouse = Warehouse.find(params[:id])
            render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
        rescue
            return render status: 404 if warehouse.nil?
        end
    end

    def index
        warehouses = Warehouse.all.order(:name)
        render status: 200, json: warehouses
    end
 end