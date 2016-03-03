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
		if(valor <= util.saldo & valor > 0)
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
				jogo = Menu.menuJogos(@serv)
				resultado = Menu.menuOdd(jogo)
				valor = getValorAposta(@serv.loggedIn)
				
				ap = Aposta.new(valor,jogo,resultado)
				@serv.addAposta(ap)
			when 2
				#alterar dados pessoais
			when 3
				#consultar dados pessoais
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
			when 2
				#alterar jogo
			when 3
				#ver interesse
			when 4
				#ver criados abertos
			when 5
				#ver criados fechados
			when 6
				#alterar dados pessoais
			when 7
				#mostrar interesse
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
				#mostrar jogos
				@serv.printJogos()
			when 4
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
	
	@serv.addEquipa(eq1)
	@serv.addEquipa(eq2)
	
	j = Jogo.new(eq1,eq2,boo1)
	j.addOdd(1,2,3)
	
	@serv.addJogo(j)
	
	ut1.deposit(101)
	ap = Aposta.new(100,j,0)
	
	@serv.addAposta(ap,ut1)
	
	puts "--------------------->Entidades inseridas"
end

#-------------------------------PROGRAM

puts "Program start"
@serv = Servico.new
addAll()
showMenuPrincipal()
puts "Program end"


