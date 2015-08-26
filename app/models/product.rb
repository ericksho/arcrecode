class Product < ActiveRecord::Base

	def getEnterprise
		ent = ''
		case self.enterprise
		when 1
			ent = 'GrainOils'
		end
		ent
				
				
	end

	def getBarcode

		barcode_value = self.getArrayCode.join
		Product.getImg barcode_value

	end

	def self.getImg barcode_value
		full_path = "app/assets/images/" + barcode_value + ".png"
		# coding: utf-8
 
		require 'rubygems'
		 
		# Load libraries of barby.
		require 'barby'
		require 'barby/barcode/ean_13'
		require 'barby/outputter/png_outputter'
		 
		barcode =Barby::EAN13.new(barcode_value)

		png = barcode.to_png(:margin => 3, :xdim => 1, :height => 55)
		img = png.to_yaml.gsub('--- !binary |-','')
	end

	def getStringCode
		(getArrayCode+[self.getVerifyDigit]).join
	end

	def getArrayCode
		country = self.country.to_s.scan(/\d/).map { |x| x.to_i }
		enterprise = self.enterprise.to_s.scan(/\d/).map { |x| x.to_i }
		product_type = self.product_type_id.to_s.scan(/\d/).map { |x| x.to_i }
		package_type = self.packing_type_id.to_s.scan(/\d/).map { |x| x.to_i }

		case country.count
		when 2
			country = [0] + country 
		when 1
			country = [0,0] + country
		end

		case enterprise.count
		when 3
			enterprise = [0] + enterprise 
		when 2
			enterprise = [0,0] + enterprise
		when 1 
			enterprise = [0,0,0] + enterprise
		end

		case product_type.count
		when 2 
			product_type = [0] + product_type
		when 1 
			product_type = [0,0] + product_type
		end

		case package_type.count
		when 1 
			package_type = [0] + package_type
		end

		digits = country + enterprise + product_type + package_type
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
