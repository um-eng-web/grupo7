class Aposta
	attr_accessor :id, :valor, :odd, :resultadoEsperado, :data
	
	def initialize(valor, jogo, resultadoEsperado)
		@valor = valor
		@odd = jogo.getRecentOdd()
		@resultadoEsperado = resultadoEsperado
		@data = Time.new
	end
	
	def to_s()
		return "ID: #{@id}, Valor: #{@valor}, Odd: #{@odd.to_s}, Resultado Esperado: #{@resultadoEsperado}, Data: #{@data}"
	end
	
end