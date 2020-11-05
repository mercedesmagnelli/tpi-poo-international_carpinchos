import wollok.game.*
import lago.*
import juego.*
import personaje.*
import necesidades.*
import pantallas.*

class Carpincho {

	var imagen = "carpincho.png"

	var posicion = game.at(10,10) 

	var property necesidad 

	var yaMuto = false
	
	constructor () {
		necesidad = tiposDeNecesidades.dameUnaNecesidadInicial()
	}
	
	method elementoNecesario() = necesidad.objetoNecesario()
	
	method position() = posicion 

	method image() = imagen

	method avanzarAutomaticamente() {
		game.onTick(1000, "carpincho avanza", { =>  self.avanzarLineaRecta()})
	}

	method avanzarLineaRecta() {
		posicion = self.position().left(1)
	}

	method aparecerEnBorde(){
		const y = 4.randomUpTo(game.height() - 4)
		posicion = game.at(30, y)
	}

	method desaparecer() {
		juego.incrementarCarpinchosSalvados()
		game.removeTickEvent("carpincho avanza")
		game.removeTickEvent("carpincho muestra su necesidad")
        game.removeVisual(self)

	}
	
	method necesidadSatisfecha(unPersonaje) {
		const elementos = unPersonaje.elementosAgarrados()
		return elementos.contains(necesidad.objetoNecesario())
	}

	method interaccionConPersonaje(unPersonaje) {
		if(self.necesidadSatisfecha(unPersonaje)){
				const elemento = self.elementoNecesario()
				self.mutarOMorir()				
				unPersonaje.quitarElemento(elemento)
		}
		else if (unPersonaje.tieneAlgunElemento()) {
				game.say(self, "No quiero ese elemento!")
				
		}
	}	
	
	method interaccionConAgua() {
		game.clear()
		pantallas.mostrarReporte()
	}

	method aparecerYMover() {
		self.aparecerEnBorde()
		self.avanzarAutomaticamente()
		self.mostrarNecesidad()
	}
	
	method mostrarNecesidad() {
		const mensaje = necesidad.mensaje()
		game.onTick(3000, "carpincho muestra su necesidad", { =>  game.say(self, mensaje)})
	}

	method mutarOMorir(){
        if(not yaMuto){
            self.mutar()
        }else {
            self.desaparecer()
        }
    }

    method mutar(){
        juego.reproducirSonido("ruidoDeMate.mp3")
        yaMuto = true
		necesidad = tiposDeNecesidades.dameUnaNecesidadMutada()
       	imagen = necesidad.imagenAsociada()
       	game.removeTickEvent("carpincho muestra su necesidad")
       	self.mostrarNecesidad()
     
    }
}
