package ar.edu.taller

import java.util.List
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.Data

enum POSICION_CUBIERTA {
	DELANTERA_IZQUIERDA,
	DELANTERA_DERECHA,
	TRASERA_IZQUIERDA,
	TRASERA_DERECHA
}

@Accessors
class Auto {
	static int DESGASTE_INICIAL_CUBIERTA = 8
	
	String marca
	String patente
	Map<POSICION_CUBIERTA, Integer> cubiertas
	Motor motor
	Suspension suspension
	Modelo modelo
	
	def boolean patentePar() {
		Integer.parseInt(patente.substring(patente.length - 1)) % 2 == 0
	}
	
	def cambiarCubiertas(List<POSICION_CUBIERTA> cubiertas) {
		cubiertas.forEach [ cubiertaAMejorar |
			this.cubiertas.put(cubiertaAMejorar, DESGASTE_INICIAL_CUBIERTA)
		]
	}

	def cambiarCubierta(POSICION_CUBIERTA posicionCubierta) {
		this.cubiertas.put(posicionCubierta, DESGASTE_INICIAL_CUBIERTA)
	}
	
	def regularMotor() {
		motor.regular
	}
	
	def arreglarSuspension(boolean delantera) {
		suspension.arreglar(delantera)
	}
	
	def costoBase() {
		modelo.costoBase
	}

}

@Data
class Modelo {
	int costoBase
	String description
}

class Suspension {
	int desgasteDelantera
	int desgasteTrasera
	
	def void arreglar(boolean delantera) {
		if (delantera) this.desgasteDelantera = 0 else this.desgasteTrasera = 0
	}
}

class Motor {
	CarController carController
	
	def boolean estaOk() {
		carController.status === 0
	}
	
	def void regular() {
		this.arreglarBujias
		this.regularRPM
		this.chequearEstado
	}
	
	def regularRPM() {
		while (carController.rpm != 1000) {
			val valor = if (carController.rpm < 1000) 10 else -10
			carController.rpm = valor
		}
	}
	
	protected def void arreglarBujias() {
		(1..carController.sparkPlugsLength).forEach [ i | 
			carController.fixSparkPlug(i)
			this.chequearEstado()
		]
	}
	
	def void chequearEstado() {
		if (!this.estaOk) throw new Exception("Anomalía general en el motor.")
	}
}
