class Plato{
	
	const cocinero
	
	method cocinero() = cocinero
	
	method azucar()
	method esBonito()
	
	method calorias()= (3*self.azucar()) +100
	
}

class Entrada inherits Plato{
	
	override method azucar() = 0
	
	override method esBonito() = true
	
}

class Principales inherits Plato{
	
	const esBonito
	const azucar
	
	override method esBonito() = esBonito
	
	override method azucar() = azucar

}

class Postre inherits Plato{
	
	var colores
	
	override method azucar() = 120
	
	override method esBonito(){
		if(colores>3){
			return true
		}
		else{
			return false
		}
	}
}