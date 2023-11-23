class Linea{
	var numero
	
	var packsActivos=[]
	
	var consumos = []
	
	method costoPromedioEntre(fechaInicio, fechaFinal)= self.consumosEntre(fechaFinal,fechaFinal).sum({consumo=> consumo.costo()}) / consumos.size()
		
	method consumosEntre(fechaInicio,fechaFinal) = consumos.filter({consumo=> consumo.realizadoEntre(fechaInicio, fechaFinal)})
	
	method consumoElUltimoMes()= self.consumosEntre(new Date().minusDays(30), new Date()).sum({consumo=> consumo.costo()})
	
	method puedeRealizarConsumo(consumo) = packsActivos.any({pack=> pack.cubre(consumo)})
	
	method realizarConsumo(consumo){
		if(self.puedeRealizarConsumo(consumo)){
			consumos.add(consumo)
			consumo.gastar()
		}
		else{
			throw new DomainException(message="No se pudo realizar el consumo")
		}
	}
	
	method agregarPack(packNuevo){
		packsActivos.add(packNuevo)
	}
}

object diaDeHoy{
	method treintaDiasMenos() = new Date().minusDays(30)
	method diaActual()= new Date()
}

class Consumo{
	
	method fechaRealizado() = new Date()
	
	method realizadoEntre(fechaInicio,fechaFinal) = self.fechaRealizado().between(fechaInicio,fechaFinal)
	
	method costo()
	
}

class ConsumoInternet inherits Consumo{
	
	var precioPorMb = 0.1
	
	var cantidadDeMb= 0
	
	method cantidadDeSegundos() = 0
	
	method cantidadDeMb() = cantidadDeMb
	
	method cantidadGastada() = self.cantidadDeMb()
	
	override method costo() = cantidadDeMb*precioPorMb
	
}

class ConsumoLlamada inherits Consumo{
	
	//var precioFijo = 1
	
	//var precioPorSegundo = 0.05
	
	var segundos = 0
	
	method cantidadDeMb() = 0
	
	method cantidadDeSegundos() = segundos
	
	method cantidadGastada() = self.cantidadDeSegundos()
	
	override method costo() {
		if(segundos>=30){
			return 0.05*segundos
		}
		else{
			return 1
		}
	}
	
	
}


class Pack{
	
	var fechaDeVencimiento = new Date(day=10, month=10, year=2025)
	
	var tipoDePack
	
	method puedeSatisfacer(pack) = tipoDePack.cubre(pack)
	
}

class PackCreditoDisponible{
	
	var cantidadDeCredito
	
	var remanente
	
	method gastar(creditoGastado){
		remanente -= creditoGastado
	}
	
	method cubre(consumo) = consumo.costo() <= cantidadDeCredito
	
}

class PackMbLibres{
	
	var cantidadMbLibres
	
	var remanente = cantidadMbLibres
	
	method gastar(cantidadGastada){
		remanente-= cantidadGastada
	}
	
	method cubre(consumo) = consumo.cantidadDeMb() <= cantidadMbLibres
	
}

class LlamadasGratis{
	
	method cubre(consumo) = true
}

class InternetLibreFinDeSemana{
	
	method diasFinde() = [friday,saturday,sunday]
	
	method esFinde(fecha) = self.diasFinde().includes(fecha.dayOfWeek())
	
}


