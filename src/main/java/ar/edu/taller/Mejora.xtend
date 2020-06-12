package ar.edu.taller

import java.util.List

abstract class Mejora {
	def void ejecutar(Auto auto)
	def int costo(Auto auto) {
		auto.costoBase()		
	}
}

class ReparacionCubiertas extends Mejora {
	List<POSICION_CUBIERTA> cubiertasAMejorar
	
	override ejecutar(Auto auto) {
		cubiertasAMejorar.forEach [ auto.cambiarCubierta(it) ]	
	}
	
	override costo(Auto auto) {
		200 * cubiertasAMejorar.size + super.costo(auto)
	}
	
}

class RegulacionMotor extends Mejora {
	int tiempoArreglo
	boolean desmontado
		
	override ejecutar(Auto auto) {
		auto.regularMotor
	}
	
	override costo(Auto auto) {
		this.costoPorDesmonte + this.costoPorRegulacion
	}
	
	def costoPorDesmonte() {
		if (desmontado) 1000 else 0
	}
	
	def costoPorRegulacion() {
		if (tiempoArreglo > 20) 1500 else 0
	}
}

class ArregloSuspension extends Mejora {
	boolean delantera
	
	override ejecutar(Auto auto) {
		auto.arreglarSuspension(delantera)
	}
	
	override costo(Auto auto) {
		super.costo(auto) * 2		
	}

}