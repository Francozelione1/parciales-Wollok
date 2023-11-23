import postres.*

class Cocinero{
	
	var especialidad
	
	method cambiarEspecialidad(nuevaEspecialidad){
		especialidad = nuevaEspecialidad
	}
	
	method catarPlato(plato) = especialidad.catarPlato(plato)
	
	method cocinar() = especialidad.cocinar()
	
}

class Pastelero{
	
	var nivelDeseadoDeDulzor
	
	method catarPlato(plato) = ((plato.azucar()*5)/nivelDeseadoDeDulzor).min(10)
	
	method cocinar() = new Postre(cocinero=self,colores= nivelDeseadoDeDulzor / 50)
	
}

class Chef{
	
	var caloriasAprobadas 	
	
	method cocinar() = new Principales(cocinero=self,esBonito= true, azucar= caloriasAprobadas)
	
	method catarPlato(plato){
		if(self.seCumplenLasExpectativas(plato)){
			return 10
		}
		else{
			return 0
		}
	}
	
	method seCumplenLasExpectativas(plato) = plato.esBonito() && caloriasAprobadas<= plato.calorias()
	
}


class SousChef inherits Chef{
	
	override method catarPlato(plato){
		if(self.seCumplenLasExpectativas(plato)){
			return super(plato)
		}
		else{
			return (plato.calorias()/100).min(6)
		}
	}
	
	override method cocinar()= new Entrada(cocinero=self)
}


