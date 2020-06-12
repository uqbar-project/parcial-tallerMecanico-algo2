package ar.edu.taller

import java.util.List

class Taller {
	List<Tecnico> tecnicos

	// Diagnóstico
	def OrdenDeTrabajo generarOrdenDeTrabajo(Auto unAuto) {
		new OrdenDeTrabajo => [
			tecnico = this.seleccionAutomaticaDeTecnico(unAuto)
			auto = unAuto
		]
	}
	
	def seleccionAutomaticaDeTecnico(Auto auto) {
		this.tecnicos.findFirst [ acepta(auto) ]
	}
}