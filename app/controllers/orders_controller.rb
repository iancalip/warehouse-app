class OrdersController < ApplicationController
    before_action :set_order, :check_user, only: [:show, :edit, :update, :delivered, :canceled]
    before_action :authenticate_user!

    def index
        @orders = current_user.orders
    end

    def new
        @order = Order.new
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
    end

    def create
        @order = Order.new(order_params)
        @order.user = current_user
        if @order.save
            redirect_to @order, notice: 'Pedido registrado com sucesso.'
        else
            flash.now[:notice] = 'Pedido não registrado, preencha todos os campos.'
            render :new
        end
    end

    def show; end

    def search
        @code = params["query"]
        @orders = Order.where("code LIKE ?", "%#{@code}%")
    end

    def edit
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
    end

    def update
        if @order.update(order_params)
            redirect_to @order, notice: 'Pedido atualizado com sucesso.'
        else
            flash.now[:notice] = 'Pedido não atualizado.'
            render :new
        end
    end

    def delivered
        @order.delivered!
        @order.order_items.each do |item|
            item.quantity.times do
                StockProduct.create!(order: @order, product_model: item.product_model,
                                    warehouse: @order.warehouse)
            end
        end
        redirect_to @order
    end

    def canceled
        @order.canceled!
        redirect_to @order
    end

    private

    def check_user
        return redirect_to new_user_session_path unless current_user

        if @order.user != current_user
           return redirect_to root_path, alert: 'Você não possui acesso a esse pedido.'
        end
    end

    def set_order
        @order = Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    end
end