class Chica{
	
	var nivelDeFelicidad =1000
	
	var emocionDominante 
	
	var recuerdosDelDia= []
	
	var pensamientosCentrales = #{}

	
	var recuerdosRecientesDelDia = [] // esto puede ser innecesario ya que puedo hacer un metodo que filtre los ultimos 5 sin modificar la lista de los recuerdos del dia
	
	var coeficienteDeFelicidad = 100
	
	method nivelDeFelicidad() = nivelDeFelicidad
	
	method emocionDominante() = emocionDominante
	
	method recuerdosRecientesDelDia() = recuerdosRecientesDelDia
	
	method pensamientosCentrales() = pensamientosCentrales
	
	method vivirEvento(evento){
		recuerdosDelDia.add(evento)
	}
	
	method agregarPensamientoCentral(recuerdo){
		pensamientosCentrales.add(recuerdo)
	}
	
	method modificarCoeficienteDeFelicidad(porcentaje){
	
		coeficienteDeFelicidad*= porcentaje
		
		if(coeficienteDeFelicidad<1){
			//throw new Error() lanzar excepcion
		}
	}
	
	method asentarRecuerdo(recuerdo){
		recuerdo.asentarse(self)
	}
	
	method calcularRecuerdosRecientesDelDia(){
		var contador= 5
		recuerdosDelDia.reverse().forEach({recuerdo=> 
			if(contador>0){
			recuerdosRecientesDelDia.add(recuerdo)
			}
			contador--
		})
	}
	
	method pensamientosCentralesDificilesDeExplicar(){
		pensamientosCentrales.filter({recuerdo=>recuerdo})
	}
	

	
}

class Recuerdo{
	
	var descripcion
	var fecha = new Date()
	
	var emocion
	
	method descripcion() = descripcion
	method fecha() = fecha
	method emocion() = emocion
	
	method emocionDominanteDelMomento()= emocion
	
	method asentarse(persona){
		emocion = persona.emocionDominante()
	}
	
}

class RecuerdoFeliz inherits Recuerdo{
	
	override method asentarse(persona){
		super(persona)
		if(persona.nivelDeFelicidad() > 500){
			persona.agregarPensamientoCentral(self)
		}
	}
	
}

class RecuerdoTriste inherits Recuerdo{
	
	override method asentarse(persona){
		super(persona)
		persona.agregarPensamientoCentral(self)
		persona.modificarCoeficienteDeFelicidad(0.9)
	}
	
}
const tristeza = new RecuerdoTriste(descripcion="hola",fecha= new Date(), emocion="hca")



class A {
	const x 
	method m1() = x
}

class B inherits A {
	const y
	method m2(z) = self.m1() * y + z
}

class C inherits B {
	override method m2(z) = super(super(z))
	override method m1() = 1000
}

class D inherits B(x = 100){
	
}



class Vehiculo {

	const velocidadMaxima

	method obtenerVelocidadMaxima() = velocidadMaxima
}

class Auto inherits Vehiculo {
	const potenciador

	method calcularAceleracion(kilometros) = self.obtenerVelocidadMaxima() * potenciador + kilometros
}



class Deportivo inherits Auto {
	

	override method calcularAceleracion(kilometros) = super(super(kilometros)) 

	override method obtenerVelocidadMaxima() = 1000
}



class AutoElectrico inherits Auto(velocidadMaxima = 100) {

}

const autoNuevo = new AutoElectrico(potenciador=400)



/*  El programa tiene una clase Vehiculo, la cual deriva en varios tipos de vehiculos. Uno de ellos es el Auto. A su vez hay varios tipos de autos como por ejemplo el deportivo y el auto electrico.
    Los vehiculos cuentan con una velocidad maxima. Si ese vehiculo es un auto, se le puede calcular la aceleracion. Si el auto es un deportivo, su velocidad maxima es de 1000 y la forma de calcular
    la aceleracion es multiplicando la velocidad maxima por su potenciador y luego sumarle los kilometros. Lo mismo ocurre con el auto electrico pero a diferencia del deportivo, el auto electrico tiene una velocidad
    maxima de 100. 
    
 */


