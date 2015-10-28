class PrintController < ApplicationController
	before_filter :authenticate_user!

  def selectLarge

    products = Product.all
    @autocomplete_codes = Array.new
    @autocomplete_desc = Array.new

    @dataSource = ''
    products.each do |product|
      c = product.getStringCode
      @autocomplete_codes.push c
      c = product.description
      @autocomplete_desc.push c
      
    end

    @product_code_post = params[:product_code]
    if @product_code_post.nil? || @product_code_post == ""
      @description = "seleccione codigo de producto"
      @product_name = "seleccione codigo de producto"
      @packaging_type = "seleccione codigo de producto"
      product_ok = false
    else
      prod = Product.getProductByCode(@product_code_post)
      @product_name = ProductType.find_by_id(prod.product_type_id).name
      @packaging_type = PackingType.find_by_id(prod.packing_type_id).description
      @packaging_net_type = PackingType.find_by_id(prod.packing_type_id).netDescription
      product_ok = true
      productTypeP = prod.product_type_id
    end

    @batch_code_post = params[:batch_code]
    if @batch_code_post.nil? || @batch_code_post == ""
      @elaboration_date = "Seleccione codigo del lote"
      @expiration_date = "Seleccione codigo del lote"
      batch_ok = false
    else
      bat = Batch.getBatchByCode(@batch_code_post)
      @elaboration_date = bat.getElaborationDate().strftime("%m-%Y")
      @expiration_date = bat.getExpirationDate().strftime("%m-%Y")
      batch_ok = true
      productTypeB = bat.product_type_id
    end

    if productTypeB == productTypeP
      @productMatch = true
    else
      @productMatch = false
    end

    if batch_ok && product_ok
      @ready = true
    else
      @ready = false
    end

    batches = Batch.all
    @autocomplete_batches = Array.new
    @dataSource = ''
    batches.each do |batch|
      c = batch.getStringCode
      @autocomplete_batches.push c
      
    end
  end

  def select
  	@codeCount = 3#12

    products = Product.all
    @autocomplete_codes = Array.new
    @dataSource = ''
    products.each do |product|
      c = product.getStringCode
      @autocomplete_codes.push c
      
    end
  end

  def sheet
  	@codes = Array.new
  	@codes.push 'NOT'
  	@codeCount = params['codeCount'].to_i
  	for i in 1..@codeCount
  		codeT = 'code_' + i.to_s
  		@codes.push params[codeT]
  	end
  end

  def selectSamples
    @codeCount = 6

    products = Product.all
    @autocomplete_codes = Array.new
    @dataSource = ''
    products.each do |product|
      c = product.getStringCode
      @autocomplete_codes.push c      
    end
  end

  def sheetSample
    @codes = Array.new
    @codes.push 'NOT'
    @codeCount = params['codeCount'].to_i
    for i in 1..@codeCount
      codeT = 'code_' + i.to_s
      @codes.push params[codeT]
    end

    products = Product.all
    @description = Array.new
    products.each do |product|
      index = @codes.index(product.getStringCode)
      if index != nil
        @description.insert(index, product.description)  
      end
    end

  end

  def selectBatches
    @codeCount = 3#12

    batches = Batch.all
    @autocomplete_codes = Array.new
    @dataSource = ''
    batches.each do |batch|
      c = batch.getStringCode
      @autocomplete_codes.push c
      
    end
  end

  def selectSamplesBatches
    @codeCount = 6

    batches = Batch.all
    @autocomplete_codes = Array.new
    @dataSource = ''
    batches.each do |batch|
      c = batch.getStringCode
      @autocomplete_codes.push c      
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def print_params
      params.require(:print).permit(:product_code)
    end

end
