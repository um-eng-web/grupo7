def isInt(str)
	str =~ /\A[+-]?[0-9]+\z/ ? true : false
end

def isFloat(str)
	str =~ /\A[+-]?[0-9]+(\.[0-9]+)?\z/ ? true : false
end

def printError(method)
	puts ">>>ERROR IN '"+method.to_s+"'<<<"
end

def getString(msg)
	while(true)
		print msg
		res = gets.strip
		if(res != nil && res != "")
			return res
		else
			puts "Input inválido"
		end
	end
	
end

def getInt(msg)
	while(true)
		str = getString(msg)
		
		if(isInt(str))
			return str.to_i
		else
			puts "Número inválido"
		end
	end
	
end

def getFloat(msg)
	while(true)
		str = getString(msg)
		
		if(isFloat(str))
			return str.to_f
		else
			puts "Número inválido"
		end
	end
	
end