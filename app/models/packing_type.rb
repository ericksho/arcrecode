class PackingType < ActiveRecord::Base
	validates :code, uniqueness: {message: "el código debe ser único"}
	def description
    	"#{amount} #{measure}"
  	end
  	def netDescription
    	"#{gross_weight} #{measure}"
  	end
end
