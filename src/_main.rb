require 'observer'

require_relative 'Utils.rb'

require_relative 'Aposta.rb'
require_relative 'Bookie.rb'
require_relative 'Equipa.rb'
require_relative 'Jogo.rb'
require_relative 'Odd.rb'
require_relative 'Servico.rb'
require_relative 'Menu.rb'
require_relative 'Utilizador.rb'


#-------------------------------METHODS
def getValorAposta(util)
	while(true)
		valor = getFloat("Introduza o valor da aposta: ")
		if(valor <= util.saldo and valor > 0)
			return valor
		else
			puts "Quantidade inválida"
		end
	end
end




def showMenuPrincipal()
	exit = false

	while exit==false do
		case Menu.menuPrincipal
			when 0
				#sair
				exit = true
			when 1
				#novo utilizador
				email = getString("Introduza o seu email:")
				nome = getString("Introduza o seu nome:")
				
				@serv.addUtilizador(Utilizador.new(email,nome))
			when 2
				#login utilizador
				email = getString("Introduza o seu email:")
				if @serv.loginUtilizador(email)
					@serv.printNotificacoes()
					showMenuUtilizador()
				end
			when 3
				#novo bookie
				email = getString("Introduza o seu email:")
				nome = getString("Introduza o seu nome:")
				
				@serv.addBookie(Bookie.new(email,nome))
			when 4
				#login bookie
				email = getString("Introduza o seu email:")
				if @serv.loginBookie(email)
					@serv.printNotificacoes()
					showMenuBookie()
				end
			when 5
				#login adminstrador
				showMenuAdministrador()
			else
				printError(__method__)
		end
	end
end

def showMenuUtilizador()
	exit = false

	while exit==false do
		case Menu.menuUtilizador
			when 0
				#logout
				@serv.logout()
				exit = true
			when 1
				#lista jogos
				if(@serv.listaJogos.length == 0)
					puts "Não há jogos disponéveis"	
				else
					puts "Lista de jogos disponiveis para apostas:"
					jogo = Menu.menuJogos(@serv.listaJogos)

					resultado = Menu.menuOdd(jogo)
					valor = getValorAposta(@serv.loggedIn)
					
					ap = Aposta.new(@serv.loggedIn,valor,jogo,resultado)
					@serv.addAposta(ap)
				end
			when 2
				#alterar dados pessoais
				@serv.alterarDadosUti()
			when 3
				#consultar dados pessoais
				@serv.printUtilizador()
			when 4
				#depositar dinheiro
				@serv.menuCarregarDinheiro()
			when 5
				#levantar dinheiro
				@serv.menuLevantarDinheiro()
			else
				printError(__method__)
		end
	end
end

def showMenuBookie()
	exit = false

	while exit==false do
		case Menu.menuBookie
			when 0
				#logout
				@serv.logout()
				exit = true
			when 1
				#novo jogo
				@serv.menuCriarJogo()
			when 2
				#introduzir nova Odd num jogo
				@serv.menuNovaOddJogo()
			when 3
				#retirar interesse
				@serv.menuRetirarInteresse()
			when 4
				#ver criados abertos
				@serv.printJogosBookieAbertos()
			when 5
				#ver criados fechados
				@serv.printJogosBookieFechados()
			when 6
				#alterar dados pessoais
				@serv.alterarDadosBookie()
			when 7
				#mostrar interesse
				@serv.menuAdicionarInteresse()
			when 8
				#consultar dados
				@serv.printBookie()
			when 9
				#fechar jogo
				@serv.encerrarJogo()
			else
				printError(__method__)
		end
	end
end

def showMenuAdministrador()
	exit = false

	while exit==false do
		case Menu.menuAdministrador
			when 0
				#logout
				@serv.logout()
				exit = true
			when 1
				#mostrar utilizadores
				@serv.printUtilizadores()
			when 2
				#mostrar bookies
				@serv.printBookies()
			when 3
				#mostrar jogos abertos
				@serv.printJogos()
			when 4
				@serv.printJogosFechados()
			when 5
				#mostrar apostas
				@serv.printApostas()
			else
				printError(__method__)
		end
	end
end


def addAll()
	puts "--------------------->Inserindo entidades base"

	ut1 = Utilizador.new('mail1@teste.com','André')
	ut2 = Utilizador.new('mail2@teste.com','Pedro')
	ut3 = Utilizador.new('mail3@teste.com','ABC')
	ut4 = Utilizador.new('mail4@teste.com','UtilTeste')
	
	@serv.addUtilizador(ut1)
	@serv.addUtilizador(ut2)
	@serv.addUtilizador(ut3)
	@serv.addUtilizador(ut4)
	
	boo1 = Bookie.new('boo1@mail.com','Bookie 1')
	boo2 = Bookie.new('boo2@mail.com','Bookie 2')
	boo3 = Bookie.new('boo3@mail.com','Bookie 3')
	
	@serv.addBookie(boo1)
	@serv.addBookie(boo2)
	@serv.addBookie(boo3)
	
	eq1 = Equipa.new('Equipa X')
	eq2 = Equipa.new('Equipa Y')
	eq3 = Equipa.new('Equipa A')
	eq4 = Equipa.new('Equipa B')
	
	@serv.addEquipa(eq1)
	@serv.addEquipa(eq2)
	@serv.addEquipa(eq3)
	@serv.addEquipa(eq4)
	
	j = Jogo.new(eq1,eq2,boo1)
	j.addOdd(1,2,3)
	j2 = Jogo.new(eq4,eq3,boo1)
	j2.addOdd(2,3,5)
	j3 = Jogo.new(eq2,eq4,boo2)
	j3.addOdd(4,2,3)
	
	@serv.addJogo(j)
	@serv.addJogo(j2)
	@serv.addJogo(j3)
	
	ut1.deposit(101)
	ap = Aposta.new(ut1,100,j,0)
	
	ut3.deposit(300)
	ap2 = Aposta.new(ut3,50,j,2)
	ap3 = Aposta.new(ut3,100,j2,1)
	
	@serv.addAposta(ap)
	@serv.addAposta(ap2)
	@serv.addAposta(ap3)
	
	puts "--------------------->Entidades inseridas"
end

#-------------------------------PROGRAM

puts "Program start"
@serv = Servico.new
addAll()
showMenuPrincipal()
puts "Program end"


