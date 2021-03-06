class Menu
	
	def self.menuPrincipal()
		return show(['Sair','Novo Utilizador','Login de Utilizador','Novo Bookie','Login de Bookie','Adminstrador'])
	end
	
	def self.menuUtilizador()
		return show(['Logout','Consultar Lista de Jogos','Alterar Dados Pessoais','Consultar Dados Pessoais','Carregar Dinheiro','Levantar Dinheiro'])
	end
	
	def self.menuBookie()
		return show(['Logout','Criar Jogo','Introduzir Nova Odd num Jogo','Remover Interesse de Jogo','Ver Jogos Criados e Abertos','Ver Jogos Criados e Fechados','Alterar Dados Pessoais','Mostrar Interesse num Jogo','Consultar dados pessoais', 'Fechar Jogo'])
	end
	
	def self.menuAdministrador()
		return show(['Logout','Mostrar Utilizadores','Mostrar Bookies','Mostrar Jogos abertos','Mostrar Jogos Fechados','Mostrar Apostas'])
	end
	
	def self.menuJogos(listaJogos)
		lista = Array.new
		jogos = listaJogos.values
		jogos.each do |jogo|
			lista.push(jogo.to_menu)
		end
		puts "Escolha um jogo da lista:"
		chosen = show(lista)
		
		return jogos.at(chosen)
	end
	
	def self.menuOdd(jogo)
		lista = Array.new
		odd = jogo.getRecentOdd()
		
		lista.push("Odd: #{odd.oddEmp} - Empate")
		lista.push("Odd: #{odd.odd1} - Vitória de #{jogo.equipa1.nome}")
		lista.push("Odd: #{odd.odd2} - Vitória de #{jogo.equipa2.nome}")
		
		return show(lista)
	end
	
	def self.menuResultado(jogo)
		lista = Array.new
		
		lista.push("Empate")
		lista.push("Vitória de #{jogo.equipa1.nome}")
		lista.push("Vitória de #{jogo.equipa2.nome}")
		
		return show(lista)
	end
	
	def self.show(menu)
		while true do
			for i in 0..(menu.length-1)
				puts "#{i} -> "+menu[i]
			end
			print "Opção: "
			
			op = gets.strip
			if(isInt(op) && op.to_i >=0 && op.to_i <= menu.length-1)
				return op.to_i
			else
				puts "Opção inválida"
			end
		end
	end
	
end