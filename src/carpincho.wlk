import wollok.game.*
import movimientos.*
import lago.*
import juego.*
import personaje.*
import necesidades.*

class Carpincho {

	var imagen = "carpincho.png"

	var posicion = game.at(10,10) // lo pusimos asi para q no nos tire problema con la generacion del carpincho
	
	const necesidades = #{hambriento} // maximo de 2

	method necesidades() = necesidades
	
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

	method estaSatisfecho() {
		//desaparece el carpincho 
	}

	method pisaAgua() {
		imagen = "carpinchoEnojado.jpg"
	}
	
	method tocaSuperficieDeAgua() = lago.superficiesDeAgua().any({superficie => self.position() == superficie.position()})
	
	method atrapado(){}
	
	/*method carpinchoPisaLago(){
		if(self.algunCarpinchoTocaElAgua()){
			game.stop()
		}
	}
	
	method algunCarpinchoTocaElAgua() = juego.carpinchos().any({carpincho => carpincho.tocaSuperficieDeAgua()})*/
	
	method colisionDeCarpinchoConObjeto(){}// Necesario para que no tire mensaje de error (un carpincho choca con otro carpincho, aunque no sería necesario, pues se generan en distintos tiempos y posiciones, pero Wollok lo pide)
	
	method borrarse() {
		game.schedule(5000, { =>  game.removeVisual(self)}) // Queda ver cómo eliminar la referencia apra evitar un memory leak, ya que removeVisual sólo elimina la representación gráfica del objeto
	}

	method interaccionConElPersonaje(unPersonaje){
		var elementoEnComun = unPersonaje.elementosDelPersonajeQueSatisfacenAlCarpincho(self) 
		// segun el modelado actual (correspondencia uno a uno entre necesidades y elementos que las satisfacen) 
		//este elemento puede ser uno solo
		
		if(not elementoEnComun.isEmpty()){
		// darle la frutita implica : carpincho eliminar la necesidad
    	//					 		  personaje eliminar objeto de la lista bolsita
		//							  frutita eliminar el objeto de la pantalla

		} //falta completar a futuro porque ahora solo lo estamos haciendo con una unica necesidad (posiblemente, ampliemos la cantidad de necesidades - ver)
	}


	

}

/*Juego:
Cosas a definir: ¿Como ganaria el jugador?
Aparecen carpinchos cada X tiempo con una necesidad cada carpincho. Jugador tiene que 
Darle lo que necesita antes de que llegue al otro lado. Si le da lo que necesita, 
desaparece de la pantalla, y si llega al otro lado, el juego termina y pierde.

Carpincho:
- Avanza 
- Recibir elemento (validar si cubre o no necesidad)
  cubrir necesidad (desaparecer)
- desaparecer

Jugador:
- Agarrar
- Entregar


Al llegar a la abscisa 0, el juego se termina*/

