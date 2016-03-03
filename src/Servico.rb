class Servico
	attr_reader :listaUtilizadores, :listaBookies, :listaJogos, :listaJogosAcabados, :listaEquipas, :listaApostas, :loggedIn
	
	def initialize()
		@listaUtilizadores = Hash.new
		@listaBookies = Hash.new
		@listaJogos = Hash.new
		@listaJogosAcabados = Hash.new
		@listaEquipas = Hash.new
		@listaApostas = Hash.new
		
		@idJogos = 1
		@idEquipas = 1
		@idApostas = 1
		
		@loggedIn = nil
	end
	
	#LOGIN
	def loginUtilizador(email)
		success = @listaUtilizadores.has_key?(email)
		
		if(success)
			@loggedIn = @listaUtilizadores[email]
			puts "Login efectuado com sucesso"
		else
			puts "Login inválido"
		end
		
		return success
	end
	
	def loginBookie(email)
		success = @listaBookies.has_key?(email)
		
		if(success)
			@loggedIn = @listaBookies[email]
			puts "Login efectuado com sucesso"
		else
			puts "Login inválido"
		end
		
		return success
	end
	
	def logout()
		@loggedIn = nil
	end
	
	#ADD
	def addUtilizador(util)
		if(@listaUtilizadores.has_key?(util.email))
			puts "Email já está a ser usado"
		else
			@listaUtilizadores[util.email] = util
			puts "Utilizador '#{util.nome}' inserido com sucesso"
		end
	end
	
	def addBookie(boo)
		if(@listaBookies.has_key?(boo.email))
			puts "Email já está a ser usado"
		else
			@listaBookies[boo.email] = boo
			puts "Bookie '#{boo.nome}' inserido com sucesso"
		end
	end
	
	def addJogo(j)
		j.id = @idJogos
		@listaJogos[j.id] = j
		puts "Jogo #{j.id} (#{j.equipa1.nome} vs #{j.equipa2.nome}) inserido com sucesso"
		@idJogos += 1
	end
	
	def addEquipa(eq)
		eq.id = @idEquipas
		@listaEquipas[eq.id] = eq
		puts "Equipa #{eq.id} (#{eq.nome}) inserida com sucesso"
		@idEquipas += 1
	end
	
	def addAposta(ap,ut=@loggedIn)
		ap.id = @idApostas
		
		ut.withdraw(ap.valor)
		
		@listaApostas[ap.id] = ap
		puts "Aposta #{ap.id} inserida com sucesso"
		@idApostas += 1
	end
	
	
	#PRINT
	def printUtilizadores()
		@listaUtilizadores.values.each do |value|
			puts value.to_s
		end
	end
	
	def printBookies()
		@listaBookies.values.each do |value|
			puts value.to_s
		end
	end
	
	def printJogos()
		@listaJogos.values.each do |value|
			puts value.to_s
		end
	end
	
	def printApostas()
		@listaApostas.values.each do |value|
			puts value.to_s
		end
	end
	
end