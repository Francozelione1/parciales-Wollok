class Vikingo{
	
	var especialidad
	
	var oro
	
	var claseSocial
	
	method ganarMonedas(cantMonedas){
		oro+=cantMonedas
	}
	
	method especialidad()= especialidad
	
	method ascensoSocial(){
		claseSocial.ascenso()		 		
	}	
	
	method puedeIrAExpedicion()= especialidad.esProductivo() && claseSocial.puedeIrAExpedicion()
	
	method irAExpedicion()
}

class Jarl inherits Vikingo{
	
	var tieneArmas
	
	override method puedeIrAExpedicion()= !tieneArmas
	
	method ascenso()= self.especialidad().ascenso()
}

class Soldado{
	var vidasCobradas
	var tieneArmas
	
	method ascenso(){
		tieneArmas+=10
	}
	
	method vidasCobradas()= vidasCobradas
	
	method tieneArmas()=tieneArmas
	
	method esProductivo()= (self.tieneArmas()>=1) && self.vidasCobradas()>20
	
}

class Granjero{
	
	var cantidadDeHijos
	var hectareas
	
	method ascenso(){
		cantidadDeHijos+=2
		hectareas+=2
	}
	
	method cantidadDeHijos()= cantidadDeHijos
	
	method hectareas()=hectareas
	
	method esProductivo()= (hectareas/cantidadDeHijos)>= 2
	
}

class Expedicion{
	
	var objetivos = []
	
	var integrantes = []
	
	
	method valeLaPena(soldados)= objetivos.all({objetivo=> objetivo.valeLaPena(soldados)})
	
	method subirSoldado(soldado){
		
		if(soldado.puedeIrAExpedicion()){
			integrantes.add(soldado)
		}
		else{
			throw new DomainException(message="El soldado no puede ir a la expedicion")
		}
		
	}
	
	method realizarExpedicion(){
		objetivos.forEach({objetivo=>})
	}
	
}

class Capital{
	
	var botin
	
	var factorDeRiqueza
	
	method valeLaPena(soldados)= (botin/soldados.length()) >=3
	
	method botin(soldados)= soldados.length()*factorDeRiqueza
	
	
}

class Aldea{
	
	var botin
	
	var crucifijos
	
	method botin()= crucifijos
	
	method valeLaPena(soldados)= botin>=15
}

class Amurallada inherits Aldea{
	
	var vikingosEnComitiva
	
	override method valeLaPena(soldados)= vikingosEnComitiva>=3
	
}