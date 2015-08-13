class PackingType < ActiveRecord::Base
	validates :code, uniqueness: {message: "el código debe ser único"}
end
