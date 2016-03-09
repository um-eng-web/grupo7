class Aposta
	attr_accessor :id, :valor, :odd, :resultadoEsperado, :data, :idJogo
	
	def initialize(valor, jogo, resultadoEsperado)
		@valor = valor
		@idJogo = jogo.id
		@odd = jogo.getRecentOdd()
		@resultadoEsperado = resultadoEsperado
		@data = Time.new
	end
	
	def to_s()
		return "ID: #{@id}, Valor: #{@valor}, Odd: #{@odd.to_s}, Resultado Esperado: #{@resultadoEsperado}, Data: #{@data}"
	end
	
end