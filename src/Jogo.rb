class Jogo
	include Observable
	attr_accessor :id, :equipa1, :equipa2, :listaOdds, :aberto, :bookie, :data, :listaApostas, :resultadoFinal
	attr_reader :observers
	def initialize(equipa1, equipa2, bookie)
		@equipa1 = equipa1
		@equipa2 = equipa2
		@bookie = bookie
		
		@listaOdds = Hash.new
		@aberto = true
		@data = Time.new
		
		@listaApostas = Hash.new
	end
	
	def addOdd(odd1, oddX, odd2)
		@listaOdds[Time.new] = Odd.new(odd1,oddX,odd2)
		puts "Odd: #{getRecentOdd().to_s} adicionada com sucesso"
		changed
		notify_observers(id, getRecentOdd())
	end
	
	def getRecentOdd()
		return @listaOdds[@listaOdds.keys.sort[-1]]
	end
	
	def to_s()
		return "ID: #{@id}, Equipa1: #{@equipa1.to_s}, Equipa2: #{@equipa2.to_s}, Aberto?: #{@aberto}, Bookie: #{@bookie.to_s}, Data: #{@data}"
	end
	
	def to_menu()
		return "#{@equipa1.nome} vs #{@equipa2.nome} - #{getRecentOdd().to_s}"
	end
end