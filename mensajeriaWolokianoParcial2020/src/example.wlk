class Mensaje{
	
	var propietario
	
	var tipoDeMensaje
	
	method propietario()= propietario
	
	method pesoDelMensaje() = 1.5 + tipoDeMensaje.peso() * 1.3
	
	method contiene(palabra) = propietario.includes(palabra) || tipoDeMensaje.contiene(palabra)
	
}

class Contacto{
	
	var usuarioEnviado
	
	method peso() = 3
	
	method contiene(palabra)= usuarioEnviado.includes(palabra)
	
}


class Texto{
	
	var contenido
	
	var cantidadCaracteres
	
	method peso() = cantidadCaracteres
	
	method contiene(palabra) = contenido.includes(palabra)
	
}

class Audio{
	
	var duracion
	
	method peso() = duracion *1.2
	
	method contiene(palabra) = false
	
}

class Imagen{
	
	var alto
	var ancho
	var tipoDeComprension
	
	method peso() = tipoDeComprension.cantPixeles(alto*ancho)*2
	
	method contiene(palabra) = false
	
	
}

object comprensionOriginal{
	
	method cantPixeles(pixeles) = pixeles
	
}

object comprensionVariable{
	
	var comprension
	
	method cantPixeles(pixeles) = pixeles * comprension
}

object comprensionMaxima{
	
	method cantPixeles(pixeles) = pixeles.min(10000)
	
}

class Gif inherits Imagen{
	var cuadros
	
	override method peso() = super() * cuadros
}