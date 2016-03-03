class Utilizador
	attr_accessor :email, :nome, :saldo, :listaApostas, :notificacoes
	
	def initialize(email, nome, saldo = 0.0)
		@email = email
		@nome = nome
		@saldo = saldo
		@listaApostas = Hash.new
		@notificacoes = Hash.new
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