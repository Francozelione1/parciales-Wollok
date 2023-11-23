class Personaje{
	
	var copas
	
	var tipo
	
	method copas() = copas
	
	method sumarCopas(copasNuevas){
		copas+= copasNuevas	
	} 
	
}

class Arquero{
	
	var agilidad
	var rango
	
	method destreza() = agilidad*rango
	method tieneEstrategia()= rango>100
}

class Ballestero inherits Arquero{
	
	override method destreza()= super()*2
}

class Guerrera{
	
	var tieneEstrategia
	
	var fuerza
	
	method tieneEstrategia() = tieneEstrategia
	
	method destreza() = fuerza*1.5
	
}

class Mision{
	
	method puedeSuperar()
	
	method copasAEntregar()
	
	method realizarMision(){
		
		if(!self.puedeEmpezar()){
			throw new DomainException(message="No se pudo iniciar la mision")
		}
	
		self.hacerMision()
			
	}
	
	method hacerMision() 
	
	method puedeEmpezar() 
}

class MisionIndividual inherits Mision{
	
	var personaje
	
	var dificultad
	
	override method puedeSuperar() = personaje.tieneEstrategia() || personaje.destreza()>dificultad
	
	override method copasAEntregar() = dificultad*2
	
	override method puedeEmpezar() = personaje.copas()>10
	
	override method hacerMision(){
		if(self.puedeSuperar()){
			personaje.sumarCopas(self.copasAEntregar())
		}
		else{
			personaje.sumarCopas(-(self.copasAEntregar()))
		}
	}
	
}

class MisionPorEquipos inherits Mision{
	
	var participantesInscriptos
	
	override method copasAEntregar() = 50 / participantesInscriptos.size()
	
	override method puedeSuperar() = self.estanAptos()
	
	method estanAptos() = participantesInscriptos.filter({participante=> participante.tieneEstrategia()}).size()>=(participantesInscriptos.size()/2) || participantesInscriptos.all({participante=> participante.destreza()>400})
	
	override method puedeEmpezar() = participantesInscriptos.sum({participante=>participante.copas()})>=60
	
	override method hacerMision(){
		if(self.puedeSuperar()){
			participantesInscriptos.map({personaje=>personaje.sumarCopas(self.copasAEntregar())})
		}
		else{
			participantesInscriptos.map({personaje=>personaje.sumarCopas(-(self.copasAEntregar()))})
		}
	}
	
	
}