class Product < ActiveRecord::Base

	def getEnterprise
		ent = ''
		case self.enterprise
		when 1
			ent = 'GrainOils'
		end
		ent
	end

	def getProductName
		ProductType.find_by_id(self.product_type_id).name
	end

	def getProductEnglishName
		ProductType.find_by_id(self.product_type_id).englishName
	end

	def getBarcode

		barcode_value = self.getArrayCode.join
		Product.getImg barcode_value

	end

	def getPackage
		PackingType.find_by_id(self.packing_type_id).description
	end

	def getPackageNet
		PackingType.find_by_id(self.packing_type_id).netDescription
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

	def self.getProductByCode code
		country = code[0] + code[1] + code[2]
		enterprise = code[3] + code[4] + code[5]  + code[6] 
		product_type =  code[7]  + code[8]  + code[9]  
		package_type =  code[10]  + code[11]
		product_type_id = ProductType.find_by_code(product_type).id
		packing_type_id = PackingType.find_by_code(package_type).id
		products = Product.where(country: country, enterprise: enterprise, product_type_id: product_type_id, packing_type_id: packing_type_id)
		product = products[0]
	end

	def getStringCode
		(getArrayCode+[self.getVerifyDigit]).join
	end

	def getArrayCode
		country = self.country.to_s.scan(/\d/).map { |x| x.to_i }
		enterprise = self.enterprise.to_s.scan(/\d/).map { |x| x.to_i }
		product_type = ProductType.find_by_id(self.product_type_id).code.to_s.scan(/\d/).map { |x| x.to_i }
		package_type = PackingType.find_by_id(self.packing_type_id).code.to_s.scan(/\d/).map { |x| x.to_i }

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
