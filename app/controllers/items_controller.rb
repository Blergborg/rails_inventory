class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  # authenticate user for all methods except index and show
  before_action :authenticate_user!, except: [:index, :show]
  # Ensure the correct user id is present before using edit, update, or destroy
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    # @item = Item.new
    @item = current_user.items.build
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    # @item = Item.new(item_params)
    @item = current_user.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    redirect_to items_path, notice: "Not authorized to edit this item" if @item.nil?
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:item_name, :item_price, :item_description, :item_stock, :user_id)
    end
end
