require_relative 'Equipa.rb'
require_relative 'Jogo.rb'
require_relative 'Aposta.rb'
require 'observer'

class Servico
	attr_reader :listaUtilizadores, :listaBookies, :listaJogos, :listaJogosFechados, :listaEquipas, :listaApostas, :loggedIn
	#attr_accessor :idJogos
	
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
	
	def addAposta(ap,ut=@loggedIn)
		ap.id = @idApostas
		
		ut.withdraw(ap.valor)
		
		@listaApostas[ap.id] = ap
		puts "Aposta #{ap.id} inserida com sucesso"
		listaJogos[ap.idJogo].add_observer(ut)
		@idApostas += 1
	end
	
	#Altera Dados
	def alterarDadosUti(ut=@loggedIn)
		email = getString("Introduza o seu email:")
		nome = getString("Introduza o seu nome:")
		utilizador = @listaUtilizadores[ut.email]
		utilizador.setEmail(email)
		utilizador.setNome(nome)
		@listaUtilizadores.delete(ut.email)
		@listaUtilizadores[utilizador.email] = utilizador
		puts "O novo mail é #{utilizador.email} e o nome é #{utilizador.nome}"
		@loggedIn = @listaUtilizadores[utilizador.email]
	end
	
	def alterarDadosBookie(ut=@loggedIn)
		email = getString("Introduza o seu email:")
		nome = getString("Introduza o seu nome:")
		bookie = @listaBookies[ut.email]
		bookie.setEmail(email)
		bookie.setNome(nome)
		@listaBookies.delete(ut.email)
		@listaBookies[bookie.email] = bookie
		puts "O novo mail é #{bookie.email} e o nome é #{bookie.nome}"
		@loggedIn = @listaBookies[bookie.email]
	end
	
	#Bookie
	def menuCriarJogo(ut=@loggedIn)
		#lista = @listaEquipas
		puts "Lista de equipas:"
		printEquipas()
		puts("Introduza o ID da equipa da casa: ")
		id1 = gets.to_i
		puts("Introduza o ID da equipa que joga fora: ")
		id2 = gets.to_i
		puts("Introduza a Odd de vitória da equipa da casa: ")
		odd1 = gets.to_i
		puts("Introduza a Odd de vitória da equipa forasteira: ")
		odd2 = gets.to_i
		puts("Introduza a Odd de empate: ")
		oddx = gets.to_i
		j = Jogo.new(listaEquipas[id1],listaEquipas[id2], ut)
		j.addOdd(odd1,oddx,odd2)
		addJogo(j)
	end
	
	def menuNovaOddJogo()
		puts "Lista de Jogos abertos"
		printJogosBookieAbertos()
		begin
			puts "Introduza o ID do jogo que deseja introduzir nova Odd:"
			idj = gets.to_i
		end while (!listaJogos.has_key?(idj)) 
		puts("Introduza a Odd de vitória da equipa da casa: ")
		odd1 = gets.to_i
		puts("Introduza a Odd de vitória da equipa forasteira: ")
		odd2 = gets.to_i
		puts("Introduza a Odd de empate: ")
		oddx = gets.to_i
		listaJogos[idj].addOdd(odd1,oddx,odd2)
	end
	
	def menuAdicionarInteresse(ut=@loggedIn)
		puts "Lista de Jogos abertos"
		printJogosAbertosSemInteresse()
		begin
			puts "Introduza o ID do jogo que quer marcar interesse"
			idj = gets.to_i
		end while ((ut.listaInteresse.has_key?(idj)) and (!listaJogos.has_key?(idj)))
		listaBookies[ut.email].addInteresse(listaJogos[idj])
		
		printJogosInteresseBookie()
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
			if(ut.email == value.bookie.email)
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
		puts "Lista de notificações"
		ut.notificacoes.each do |value|
			puts value
		end
	end
	
	def printEquipas()
		@listaEquipas.values.each do |value|
			puts value.to_s
		end
	end
	
end