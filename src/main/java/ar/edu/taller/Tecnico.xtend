package ar.edu.taller

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

class TestTecnico {

	def void test1() {
		new Tecnico => [
			// (corolla o ford) y (patente par)
			preferencia = new PreferenciaAND => [
				preferencias = #[
					new PreferenciaOR => [
						preferencias = #[
							new AceptaPorMarca("corolla"),
							new AceptaPorMarca("ford")
						]
					],
					new AceptaPatentePar
				]
			]
		]
	}
}

@Accessors
class Tecnico {
	Preferencia preferencia

	def acepta(Auto auto) {
		this.preferencia.acepta(auto)
	}
}

interface Preferencia {
	def boolean acepta(Auto auto)
}

// Null Object Pattern
class AceptaCualquierAuto implements Preferencia {
	override acepta(Auto auto) {
		true
	}
}

class AceptaPorMarca implements Preferencia {
	String marca

	new(String marca) {
		this.marca = marca
	}

	override acepta(Auto auto) {
		this.marca === auto.marca
	}
}

class AceptaPatentePar implements Preferencia {
	override acepta(Auto auto) {
		auto.patentePar
	}
}

@Accessors
abstract class PreferenciaCompuesta implements Preferencia {
	List<Preferencia> preferencias
}

class PreferenciaAND extends PreferenciaCompuesta {
	override acepta(Auto auto) {
		this.preferencias.forall[acepta(auto)]
	}
}

class PreferenciaOR extends PreferenciaCompuesta {
	override acepta(Auto auto) {
		this.preferencias.exists[acepta(auto)]
	}
}
