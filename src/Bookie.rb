class Bookie
	attr_accessor :email, :nome, :listaInteresse, :notificacoes
	
	def initialize(email, nome)
		@email = email
		@nome = nome
		@listaInteresse = Hash.new
		@notificacoes = Hash.new
	end
	
	def addInteresse(jogo)
		@listaInteresse[jogo.id] = jogo
		puts jogo
	end
	
	def removeInteresse(jogo)
		@listaInteresse.delete(jogo.id)
	end
	
	def update(id, odd)
		@notificacoes[Time.new] = "A Odd do jogo #{id} foi alterada para #{odd.to_s}"
	end
	
	def to_s()
		return "Email: #{@email}, Nome: #{@nome}"
	end
	
end