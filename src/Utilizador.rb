class Utilizador
	attr_accessor :email, :nome, :saldo, :notificacoes
	
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
	
	def update(notif)
		@notificacoes[Time.new] = notif
	end
	
	def fecharAposta(premio)
	
		if(premio == nil)
			notificacoes[Time.new] = "Um jogo onde apostou foi fechado mas você não ganhou a aposta"
		else
			deposit(premio)
			notificacoes[Time.new] = "Parabéns ganhou #{premio} numa aposta"
		end
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