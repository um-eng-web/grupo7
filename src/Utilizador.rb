class Utilizador
	attr_accessor :email, :nome, :saldo, :listaApostas, :notificacoes
	
	def initialize(email, nome, saldo = 0.0)
		@email = email
		@nome = nome
		@saldo = saldo
		@listaApostas = Hash.new
		@notificacoes = Hash.new
	end
	
	def setNome(nome)
		@nome = nome
	end
	
	def setEmail(email)
		@email = email
	end
	
	def update(id, odd)
		@notificacoes[Time.new] = "A Odd do jogo #{id} foi alterada para #{odd.to_s}"
	end
	
	def deposit(valor)
		@saldo += valor
	end
	
	def withdraw(valor)
		@saldo -= valor
	end
	
	def to_s()
		return "Email: #{@email}, Nome: #{@nome}, Saldo: #{saldo}"
	end
	
end