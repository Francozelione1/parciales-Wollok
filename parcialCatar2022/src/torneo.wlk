import example.*

class Torneo {
	
	var participantes= []
	
	var platosParaPresentar = [] 
	
	method anotarseEnTorneo(participante){
		participantes.add(participante)
		platosParaPresentar.add(participante.cocinar())
	}
	
	method ganador(){
		if(participantes.isEmpty()){
			throw new DomainException(message="No hay participantes")
		}
		else{
			return platosParaPresentar.max({plato=> self.calificacionTotal(plato)}).cocinero()
		}
	}
	
	method calificacionTotal(plato) = participantes.sum({catador=> catador.catarPlato(plato)})
}
