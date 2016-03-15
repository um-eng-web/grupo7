class Aposta
	attr_accessor :id, :valor, :odd, :resultadoEsperado, :data, :idJogo, :apostador
	
	def initialize(apostador, valor, jogo, resultadoEsperado)
		@apostador = apostador
		@valor = valor
		@idJogo = jogo.id
		@odd = jogo.getRecentOdd()
		@resultadoEsperado = resultadoEsperado
		@data = Time.new
	end
	
	def getOddApostada
		case resultadoEsperado
			when 0
				return odd.oddEmp
			when 1
				return odd.odd1
			when 2
				return odd.odd2
			else
				printError(__method__)
				return nil
			end
	end
	
	def to_s()
		return "ID: #{@id}, idJogo #{@idJogo}, Valor: #{@valor}, Odd: #{@odd.to_s}, Resultado Esperado: #{@resultadoEsperado}, Data: #{@data}, Apostador: #{@apostador.email}"
	end
	
end