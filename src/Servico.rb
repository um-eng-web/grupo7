class Servico
	attr_reader :listaUtilizadores, :listaBookies, :listaJogos, :listaJogosFechados, :listaEquipas, :listaApostas, :loggedIn
	
	def initialize()
		@listaUtilizadores = Hash.new
		@listaBookies = Hash.new
		@listaJogos = Hash.new
		@listaJogosFechados = Hash.new
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
	
	def addAposta(ap)
		ap.id = @idApostas
		
		ap.apostador.withdraw(ap.valor)
		
		@listaApostas[ap.id] = ap
		@listaJogos[ap.idJogo].listaApostas[ap.id] = ap
		puts "Aposta #{ap.id} inserida com sucesso"
		listaJogos[ap.idJogo].add_observer(ap.apostador)
		@idApostas += 1
	end
	
	#Altera Dados
	def alterarDadosUti(ut=@loggedIn)
		email = getString("Introduza o seu email:")
		nome = getString("Introduza o seu nome:")

		@listaUtilizadores[email] = @listaUtilizadores.delete(ut.email)
		
		ut.setEmail(email)
		ut.setNome(nome)
		
		puts "O novo mail é #{ut.email} e o nome é #{ut.nome}"
	end
	
	def alterarDadosBookie(ut=@loggedIn)
		email = getString("Introduza o seu email:")
		nome = getString("Introduza o seu nome:")

		@listaBookies[email] = @listaBookies.delete(ut.email)
		
		ut.email = email
		ut.nome = nome
		
		puts "O novo mail é #{ut.email} e o nome é #{ut.nome}"
	end
	
	#Utilizador
	def menuCarregarDinheiro(ut=@loggedIn)
		valor = getFloat("Que valor deseja introduzir?\n")
		ut.deposit(valor)
		puts "Agora tem #{ut.saldo}$ na sua conta"
	end
	
	def menuLevantarDinheiro(ut=@loggedIn)
		begin
			valor = getFloat("Tem #{ut.saldo}$ na sua conta. Que valor deseja levantar?\n")
		end while(!(valor <= ut.saldo))
		
		ut.withdraw(valor)
		puts "Agora tem #{ut.saldo}$ na sua conta"
	end
	
	#Bookie
	def menuCriarJogo(ut=@loggedIn)
		puts "Lista de equipas:"
		printEquipas()
		id1 = getInt("Introduza o ID da equipa da casa: ")
		id2 = getInt("Introduza o ID da equipa que joga fora: ")
		odd1 = getInt("Introduza a Odd de vitória da equipa da casa: ")
		odd2 = getInt("Introduza a Odd de vitória da equipa forasteira: ")
		oddx = getInt("Introduza a Odd de empate: ")
		j = Jogo.new(listaEquipas[id1],listaEquipas[id2], ut)
		j.addOdd(odd1,oddx,odd2)
		addJogo(j)
	end
	
	def menuNovaOddJogo()
		puts "Lista de Jogos abertos:"
		printJogosBookieAbertos()
		begin
			idj = getInt("Introduza o ID do jogo que deseja introduzir nova Odd: ")
		end while (!listaJogos.has_key?(idj)) 
		
		odd1 = getInt("Introduza a Odd de vitória da equipa da casa: ")
		odd2 = getInt("Introduza a Odd de vitória da equipa forasteira: ")
		oddx = getInt("Introduza a Odd de empate: ")
		listaJogos[idj].addOdd(odd1,oddx,odd2)
	end
	
	def menuAdicionarInteresse(ut=@loggedIn)
		puts "Lista de Jogos abertos:"
		printJogosAbertosSemInteresse()
		begin
			idj = getInt("Introduza o ID do jogo que quer marcar interesse: ")
		end while ((ut.listaInteresse.has_key?(idj)) and (!listaJogos.has_key?(idj)))
		listaJogos[idj].add_observer(ut)
		ut.addInteresse(listaJogos[idj])
	end
	
	def menuRetirarInteresse(ut=@loggedIn)
		printJogosInteresseBookie()
		id = getInt("Introduza o ID do jogo que deseja retirar interesse (0 se quer sair)")
		if(id == 0) 
			return
		else
			ut.removeInteresse(listaJogos[id])
			listaJogos[id].delete_observer(ut)
		end
	end
	
		
	def encerrarJogo(boo = @loggedIn)
		jogos = getJogosAbertosBookie(boo)
		if(jogos.length == 0)
			puts "Não tem jogos disponíveis para encerrar!"
			return
		end
		puts "Lista de jogos disponiveis:"
		jogo = Menu.menuJogos(jogos)
		
		resultado = Menu.menuResultado(jogo)
		
		@listaJogos.delete(jogo.id)

		jogo.fecharJogo(resultado)
		
		@listaJogosFechados[jogo.id] = jogo
		
		puts "Jogo encerrado com sucesso!"
	end
	
	def getJogosAbertosBookie(boo)
		res = Hash.new
		@listaJogos.each do |key,value|
			if(boo.email == value.bookie.email)
				res[key] = value
			end
		end
		return res
	end
	
	#PRINT
	def printUtilizadores()
		@listaUtilizadores.values.each do |value|
			puts value.to_s
		end
	end
	
	def printUtilizador(ut=@loggedIn)
		puts ut.to_s
	end
	
	def printBookies()
		@listaBookies.values.each do |value|
			puts value.to_s
		end
	end
	
	def printBookie(ut=@loggedIn)
		puts ut.to_s
	end
	
	def printJogos()
		@listaJogos.values.each do |value|
			puts value.to_s
		end
	end
	
	def printJogosFechados()
		@listaJogosFechados.values.each do |value|
			puts value.to_s
		end
	end
	
	def printJogosBookieAbertos(ut=@loggedIn)
		@listaJogos.values.each do |value|
			if(ut.email == value.bookie.email)
				puts value.to_s
			end
		end
	end
	
	def printJogosBookieFechados(ut=@loggedIn)
		@listaJogosFechados.values.each do |value|
			if(ut.email == value.bookie.email)
				puts value.to_s
			end
		end
	end
	
	def printJogosAbertosSemInteresse(ut=@loggedIn)
		@listaJogos.values.each do |value|
			if(ut.email != value.bookie.email)
				if(!ut.listaInteresse.has_key?(value.id))
					puts value.to_s
				end
			end
		end
	end
	
	def printJogosInteresseBookie(ut=@loggedIn)
		if(ut.listaInteresse.empty?)
			puts "Ainda não está interessado em nenhum jogo"
		else
			ut.listaInteresse.values.each do |value|
				puts value.to_s
			end
		end
	end
	
	def printApostas()
		@listaApostas.values.each do |value|
			puts value.to_s
		end
	end
	
	def printNotificacoes(ut=@loggedIn)
		puts "Lista de notificações:"
		ut.notificacoes.each do |key,value|
			puts "[#{key}] #{value}"
		end
		puts "\n"
	end
	
	def printEquipas()
		@listaEquipas.values.each do |value|
			puts value.to_s
		end
	end
	
end