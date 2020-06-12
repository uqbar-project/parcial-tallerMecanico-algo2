package ar.edu.taller

interface CarController {

	def int getRpm()
	def void setRpm(int i)
	def void fixSparkPlug(int i)
	def int getSparkPlugsLength()
	def int status()

}
