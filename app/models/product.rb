class Product < ActiveRecord::Base

	def getBarcode

		barcode_value = self.codeNumber.to_s + self.codeText
		Product.getImg barcode_value

	end

	def self.getImg barcode_value
		full_path = "app/assets/images/" + barcode_value + ".png"
		# coding: utf-8
 
		require 'rubygems'
		 
		# Load libraries of barby.
		require 'barby'
		require 'barby/barcode/ean_13'
		require 'barby/barcode/ean_8'
		require 'barby/outputter/png_outputter'
		 
		#barcode = Barby::EAN13.new('491234567890')
		barcode =Barby::EAN13.new('49123456789')

		png = barcode.to_png(:margin => 3, :xdim => 1, :height => 55)
		img = png.to_yaml.gsub('--- !binary |-','')
	end

	def getArrayCode
		country = self.country.to_s.scan(/\d/).map { |x| x.to_i }
		enterprise = self.enterprise.to_s.scan(/\d/).map { |x| x.to_i }
		product = self.product.to_s.scan(/\d/).map { |x| x.to_i }

		case country.count
		when 2
			digits = [0] + country 
		when 1
			digits = [0,0] + country
		end

		case enterprise.count
		when 3
			digits = [0] + enterprise 
		when 2
			digits = [0,0] + enterprise
		when 1 
			digits = [0,0,0] + enterprise
		end

		case product.count
		when 4
			digits = [0] + product 
		when 3
			digits = [0,0] + product
		when 2 
			digits = [0,0,0] + product
		when 1 
			digits = [0,0,0,0] + product
		end

		digits = country + enterprise + product
	end
	
	def getVerifyDigit 

		digits = self.getArrayCode

		evenSum = digits.values_at(* digits.each_index.select{|i| i.even?}).inject{|sum,x| sum + x }

		oddSum = digits.values_at(* digits.each_index.select{|i| i.odd?}).inject{|sum,x| sum + x } * 3

	    sum = evenSum + oddSum
	    
	    mod = 10 - sum % 10
	    mod==10 ? 0 : mod
	end

end
