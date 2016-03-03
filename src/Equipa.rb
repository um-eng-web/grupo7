class Equipa
	attr_accessor :id, :nome
	
	def initialize(nome)
		@nome = nome
	end
	
	def to_s()
		return "ID: #{@id}, Nome: #{@nome}"
	end
	
end