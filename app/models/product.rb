class Product < ActiveRecord::Base

	def getBarcode

		barcode_value = self.codeNumber.to_s + self.codeText
		Product.getImg barcode_value

	end

	def self.getImg barcode_value
		require 'barby'
		require 'barby/barcode/code_128'
		require 'barby/outputter/png_outputter'
		 
		full_path = "app/assets/images/" + barcode_value + ".png"
		barcode = Barby::Code128B.new(barcode_value)

		png = barcode.to_png(:margin => 3, :xdim => 1, :height => 55)
		img = png.to_yaml.gsub('--- !binary |-','')
	end
	
end
