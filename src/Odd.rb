class Odd
	attr_accessor :odd1, :oddEmp, :odd2
	
	def initialize(odd1, oddEmp, odd2)
		@odd1 = odd1
		@oddEmp = oddEmp
		@odd2 = odd2
	end
	
	def to_s()
		return "Odd: (#{@odd1},#{@oddEmp},#{@odd2})"
	end
end