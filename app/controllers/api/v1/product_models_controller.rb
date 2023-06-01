 class Api::V1::ProductModelsController < Api::V1::ApiController

    def show
        product_model = ProductModel.find(params[:id])
        render status: 200, json: product_model.as_json(except: [:supplier_id])
    end

    def index
        product_models = ProductModel.all.order(:name)
        render status: 200, json: product_models
    end

    def create
        product_models_params = params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :category,
                                                                    :identifier, :description, :image, :supplier_id)
        product_model = ProductModel.new(product_models_params)
        if product_model.save
            render status: 201, json: product_model
        else
            render status: 412, json: { errors: product_model.errors.full_messages }
        end
    end
 end