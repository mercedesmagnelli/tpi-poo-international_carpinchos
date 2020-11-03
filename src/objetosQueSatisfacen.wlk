import wollok.game.*

class Elemento {
	
	var image
	
	var position

	method interaccionConPersonaje(unPersonaje){
		unPersonaje.agarrarElemento(self)
	}	
	
	method image() = image
	
	method position() = position
	
}

object zanahoria inherits Elemento{
	override method position() = game.at(12,0)
	
	override method image() = "zanahoria.png"
	
	method posicionVisual() = game.at(0, 19)
}

object comidita inherits Elemento {
	override method position() = game.at(16,0)
	
	override method image() = "comidita.png"
	
	method posicionVisual() = game.at(1, 19)
}
