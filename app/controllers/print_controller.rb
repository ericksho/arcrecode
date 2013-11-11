class PrintController < ApplicationController
	before_filter :authenticate_user!
  def select
  	@codeCount = 12

    products = Product.all
    @autocomplete_codes = Array.new
    @dataSource = ''
    products.each do |product|
      c = product.codeNumber.to_s + product.codeText
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
end
