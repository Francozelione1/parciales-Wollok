class Persona{
	
	var monedas = 20
	
	var edad = 20
	
	var viveEn = null
	
	method recursos() = monedas
	
	method esDestacado() = edad.between(18,65) || self.recursos()>30
	
	method modificarMonedas(cantidad){
		monedas+=cantidad
	}
	
	method edad() = edad
	
	method cumplirAnios(){
		edad++
	}
	
}

class Productor inherits Persona{
	
	var tecnicas= #{}
	
	override method recursos() = super()*tecnicas.size()
	
	override method esDestacado() = super() || (tecnicas.size()>5)
	
	method realizarTecnica(tecnica, tiempo){
		
		if(tecnicas.includes(tecnica)){
			monedas+=tiempo*3
		}
		else{
			monedas-=1
		}
	}
	
	method aprenderTecnica(tecnicaNueva)= tecnicas.add(tecnicaNueva)
	
	method trabajar(tiempo,planeta){
		if(planeta==viveEn){
			self.realizarTecnica(tecnicas.last(),tiempo)
		}
		else{
			throw new DomainException(message="No vive en el planeta")
		}
	}
	
}

class Constructor inherits Persona{
	
	var construccionesRealizadas= []
	
	var region
	
	method construccionesRealizadas() = construccionesRealizadas
	
	override method recursos()= super()+10*construccionesRealizadas.size()
	
	override method esDestacado() = construccionesRealizadas.size() >5
	
	method trabajar(tiempo, planeta){
		construccionesRealizadas.add(region.construir(tiempo,self))
	}
	
	
}


class Construccion{
	
	var tipoDeConstruccion
	
	method valor() = tipoDeConstruccion.valor()
	
}

class Muralla{
	
	var longitud
	
	method valor() = 10*longitud
	
}

class Museo{
	
	var superficieCubierta
	
	const indiceDeImportancia
	
	method valor() = superficieCubierta*(indiceDeImportancia.min(5)).max(1)
	
}

class Planeta{
	
	var habitantes= #{}
	
	var construcciones= []
	
	//var delegacionDiplomatica= #{}
	
	method delegacionDiplomatica() = habitantes.filter({habitante=>habitante.esDestacado()|| self.esHabitanteConMasRecursos(habitante)})
	
	method esHabitanteConMasRecursos(habitante) = habitante== self.habitanteConMasRecursos()
	
	method habitanteConMasRecursos() = habitantes.max({habitante=> habitante.recursos()})
		
	method esValioso() = construcciones.sum({construccion=>construccion.valor()}) >100
	
}

object montania{
	
	method construir(tiempo,constructor) = new Muralla(longitud= tiempo/2)
	
}

object costa{
	method construir(tiempo,constructor)= new Museo(superficieCubierta= tiempo, indiceDeImportancia=1)
}

object llanura{
	method construir(tiempo,constructor) = {
		
		if(constructor.esDestacado()){
			return new Museo(superficieCubierta= tiempo, indiceDeImportancia=constructor.recursos()/10)
		}
		else{
			return new Muralla(longitud= tiempo/2)
		}
		
	}
}
