import example.*
import usuarios.*


class Usuario {
	
	var nombre 
	
	var memoria = 100
	
	var notificaciones = []
	
	var chats=[]
	
	method notificaciones() = notificaciones
	
	method agregarNotificacion(notificacion){
		notificaciones.add(notificacion)
	}
	
	method propietario() = self
	
	method espacioDisponible() = memoria
	
	method recibirMensaje(mensaje){
		
		memoria-=mensaje.pesoDelMensaje()
		
	}
	
	method puedeRecibirMensaje(mensaje) = mensaje.pesoDelMensaje()<= self.espacioDisponible()
	
	method mensajeMasPesado() = chats.map({chat=> chat.mensajeMasPesado()})
	
	method busquedaDeTexto(palabra) = chats.filter({chat=> chat.mensajes().includes(palabra)})
	
	method leerChat(chat){
		notificaciones.filter({x=> x.chat() == chat }).forEach({notificacion=> notificacion.leerChat()})
	}
	
	method notificacionesSinleer() = notificaciones.filter({notificacion=> !notificacion.leida()})
}
