class Bookie
	attr_accessor :email, :nome, :listaInteresse, :listaNotificacoes
	
	def initialize(email, nome)
		@email = email
		@nome = nome
		@listaInteresse = Hash.new
		@listaNotificacoes = Hash.new
	end
	
	def setNome(nome)
		@nome = nome
	end
	
	def setEmail(email)
		@email = email
	end
	
	def addInteresse(jogo)
		@listaInteresse[jogo.id] = jogo
		puts jogo
	end
	
	def to_s()
		return "Email: #{@email}, Nome: #{@nome}"
	end
	
end