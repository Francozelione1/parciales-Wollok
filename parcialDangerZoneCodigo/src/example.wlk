class Mision{
	
	var habilidadesRequeridas
	
	var peligrosidad
	
	method habilidadesRequeridas() = habilidadesRequeridas
	
	method peligrosidad() = peligrosidad
	
	method danioInfligido() = peligrosidad
	
}


class Empleado{
	
	var especialidad
	
	method ascenderParaEspia(){
		if(especialidad.estrellas()>=3){
			especialidad = new Espia(salud=100)
		}
		else{
			throw new DomainException(message="No se puede ascender todavia")
		}
	}
	
	method puedeUsarHabilidad(habilidad) = !especialidad.quedaIncapacitado() && especialidad.habilidades().contains(habilidad)
	
	method puedeCumplirMision(mision) = mision.habilidadesRequeridas().all({habilidadRequerida=> self.puedeUsarHabilidad(habilidadRequerida)})
	
	method cumplirMision(mision){
		
		if(self.puedeCumplirMision(mision)){
			especialidad.cumplirMision(mision)
		}
		else{
			throw new DomainException(message="No se pudo completar la mision")
		}
	} 

}

class Jefe inherits Empleado{
	
	var subordinados 
	
	override method puedeUsarHabilidad(habilidad)= super(habilidad) || subordinados.anySatisfy({subordinado=> subordinado.habilidades().contains(habilidad)})
	
}

class Espia{
	
	var saludCritica = 15
	
	var salud
	
	var habilidades=[]
	
	method habilidades() = habilidades
	
	method saludCritica() = saludCritica
	
	method quedaIncapacitado()= salud<saludCritica
	
	method habilidadesNuevas(mision) = habilidades.filter({habilidadConocida=> mision.habilidadesRequeridas().contains(habilidadConocida)})
	
	method cumplirMision(mision){
		
		if(mision.danioInfligido()<salud){
			self.habilidadesNuevas(mision).forEach({habilidadNueva=> habilidades.add(habilidadNueva)})
		}
		else{
			throw new DomainException(message="No se pudo completar la mision")
		}
		
	}
	
}

class Oficinista{
	
	var saludCritica = 15
	
	var salud
	
	var estrellas= 0
	
	var habilidades=[]
	
	method habilidades() = habilidades
	
	method estrellas() = estrellas
	
	method saludCritica() = 40 - (5*estrellas)
	
	method quedaIncapacitado()= salud<saludCritica
	
	method cumplirMision(mision){
		
		if(mision.danioInfligido()<salud){
			estrellas++
		}
		else{
			throw new DomainException(message="No se pudo completar la mision")
		}
		
	}
	
}


const mision = new Mision(habilidadesRequeridas=[2,3], peligrosidad=10)
const especialidadEspia = new Espia(salud=100, habilidades=[1,2,3])
const especialidadOficinista = new Oficinista(salud=100,habilidades=[1,2,3])
const empleado = new Empleado(especialidad=especialidadOficinista)