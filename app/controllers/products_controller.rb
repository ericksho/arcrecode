class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!


  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    products = Product.all
    @autocomplete_codes = Array.new
    products.each do |prod|
      @autocomplete_codes.push prod.codeText
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    unique = true;

    products = Product.where("codeNumber = ?",@product.codeNumber)
    if products.count > 1
      products.each do |productT| 
        if productT.codeText.eql? @product.codeText
          unique = false;
        end
      end
    end

    respond_to do |format|
      if unique 
        if @product.save
          format.html { redirect_to @product, notice: 'El producto se ha creado exitosamente.' }
          format.json { render action: 'show', status: :created, location: @product }
        else
          flash[:notice] = 'Error al ingresar el producto, por favor intentelo nuevamente.'
          format.html { render action: 'new'}
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      else
        flash[:notice] = 'No puede repetir el codigo del producto.'
        format.html { render action: 'new'}
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'El producto se ha actializado correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:codeText, :codeNumber, :description)
    end
end
