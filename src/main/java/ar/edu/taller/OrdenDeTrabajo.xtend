package ar.edu.taller

import java.time.LocalDate
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class OrdenDeTrabajo {
	Tecnico tecnico
	Auto auto
	LocalDate fecha
	List<Mejora> mejoras

	// Costo total
	def costoTotal() {
		this.mejoras.fold(0, [ acum, mejora | acum + mejora.costo(auto) ])
	}
	
}