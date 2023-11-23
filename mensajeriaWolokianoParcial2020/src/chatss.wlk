import example.*

class Chat {
	
	var mensajes = []
	var integrantes= []
	
	method agregarMensaje(mensaje){
		
		if(self.puedeEnviarMensaje(mensaje)){
			mensajes.add(mensaje)
			self.notificar()
		}
		else{
			throw new DomainException(message="No se pudo enviar el mensaje")
		}
		
	}
	
	method notificar(){
		integrantes.forEach({integrante=>integrante.agregarNotificacion(new Notificacion(chat=self))})
	}
	
	method pesoDelChat() = mensajes.sum({mensaje=> mensaje.pesoDelMensaje() })
	
	method puedeEnviarMensaje(mensaje) = integrantes.includes(mensaje.propietario()) && integrantes.all({integrante=> integrante.puedeRecibirMensaje(mensaje)})
	
	method mensajes() = mensajes
	
	method mensajeMasPesado() = self.mensajes().max({mensaje=> mensaje.pesoDelMensaje() })
}

class ChatPremium inherits Chat{
	
	var restriccionAdicional
	
	var creador
	
	override method puedeEnviarMensaje(mensaje)= restriccionAdicional.puedeEnviar(mensaje,creador)
}

class difusion{
	method puedeEnviar(mensaje,creador) = mensaje.propietario() == creador
}

class restringido{
	
	var limite
	
	method puedeEnviar(mensaje,creador)= true
}

class Ahorro{
	var maxPeso
	
	method puedeEnviar(mensaje,creador)= mensaje.pesoDelMensaje()<= maxPeso
}

class Notificacion{
	
	var estaLeida = false
	
	var chat
	
	method chat() = chat
	
	method leerChat(){
		estaLeida=true
	}
	
}