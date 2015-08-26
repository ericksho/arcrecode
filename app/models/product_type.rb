class ProductType < ActiveRecord::Base
	validates :name, uniqueness: { case_sensitive: false, message: "El nombre debe ser único"}
	validates :code, uniqueness: {message: "el código debe ser único"}

end
