class Batch < ActiveRecord::Base
	validates :elaboration_day, uniqueness: { message: "Este lote ya fue creado, el código debe ser único", scope: [:elaboration_month, :elaboration_year, :lifespan, :daily_batch, :intern_use_1, :intern_use_2, :verify_digit] }   
   
	def getBarcode
		barcode_value = self.getArrayCode.join
		Batch.getImg barcode_value

	end

	def self.controlDate
		DateTime.new(2015,1,16)
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

	def getElaborationDate
		DateTime.new(self.elaboration_year, self.elaboration_month, self.elaboration_day)
		## este metodo durara por 28 años
	end

	def getExpirationDate
		getElaborationDate + self.lifespan.months
	end

	def getElaborationDateCode
		elaborationDateCode = (self.getElaborationDate - Batch.controlDate).to_i

		## 6561 is EA in Hex (Esteban Armand)
		elaborationDateCode = ((6561 + elaborationDateCode ) % 10000).to_s.scan(/\d/).map { |x| x.to_i }

		case elaborationDateCode.count
		when 3 
			elaborationDateCode = [0] + elaborationDateCode
		when 2 
			elaborationDateCode = [0,0] + elaborationDateCode
		when 1 
			elaborationDateCode = [0,0,0] + elaborationDateCode
		end

		elaborationDateCode
	end

	def self.getDateFromCode elaborationDateCode
		## 6561 is EA in Hex (Esteban Armand)
		inDays = (elaborationDateCode.to_i - 6561) % 10000
		date = Batch.controlDate + inDays.days
	end

	def getArrayCode
		product_type = self.product_type_id.to_s.scan(/\d/).map { |x| x.to_i }
		lifespan = self.lifespan.to_s.scan(/\d/).map { |x| x.to_i }
		daily_batch = self.daily_batch.to_s.scan(/\d/).map { |x| x.to_i }
		intern_use_1 = self.intern_use_1.to_s.scan(/\d/).map { |x| x.to_i }
		intern_use_2 = self.intern_use_2.to_s.scan(/\d/).map { |x| x.to_i }

		case product_type.count
		when 2 
			product_type = [0] + product_type
		when 1 
			product_type = [0,0] + product_type
		end

		case lifespan.count
		when 1 
			lifespan = [0] + lifespan
		end

		digits = self.getElaborationDateCode + lifespan + product_type + daily_batch + intern_use_1 + intern_use_2
	end

	def self.getBatchByCode code
		elaborationDate = Batch.getDateFromCode(code[0] + code[1] + code[2] + code[3]) #review this
		elaboration_day = elaborationDate.day.to_i
		elaboration_month = elaborationDate.month.to_i
		elaboration_year = elaborationDate.year.to_i
		lifespan = (code[4] + code[5]).to_i
		product_type_id = (code[6] + code[7]  + code[8]).to_i
		daily_batch = code[9].to_i
		intern_use_1 = code[10].to_i
		intern_use_2 = code[11].to_i
		batch = Batch.where(elaboration_year: elaboration_year, elaboration_month: elaboration_month, elaboration_day: elaboration_day,lifespan: lifespan, product_type_id: product_type_id, daily_batch: daily_batch, intern_use_1: intern_use_1, intern_use_2: intern_use_2)
		batch = batch[0]
	end
	
	def getVerifyDigit 

		digits = self.getArrayCode

		evenSum = digits.values_at(* digits.each_index.select{|i| i.even?}).inject{|sum,x| sum + x }

		oddSum = digits.values_at(* digits.each_index.select{|i| i.odd?}).inject{|sum,x| sum + x } * 3

	    sum = evenSum + oddSum
	    
	    mod = 10 - sum % 10
	    mod == 10 ? 0 : mod
	end
end
