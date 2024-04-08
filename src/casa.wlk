object cuentaCombinada {

	var cuentaPrimaria = cuentaConGastos
	var cuentaSecundaria = cuentaCorriente

	method cuentaPrimaria(_cuentaPrimaria) {
		cuentaPrimaria = _cuentaPrimaria
	}

	method cuentaSecundaria(_cuentaSecundaria) {
		cuentaSecundaria = _cuentaSecundaria
	}

	method depositar(dinero) {
		cuentaPrimaria.depositar(dinero)
	}

	method extraer(dinero) {
		if (dinero < cuentaPrimaria.saldo()) {
			cuentaPrimaria.extraer(dinero)
		} else cuentaSecundaria.extraer(dinero)
	}

	method saldo() {
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}

}

object cuentaCorriente {

	var saldo = 0

	method saldo() {
		return saldo
	}

	method saldo(_saldo) {
		saldo = _saldo
	}

	method depositar(dinero) {
		saldo += dinero
	}

	method extraer(dinero) {
		saldo -= dinero
	}

}

object cuentaConGastos {

	var saldo = 0
	var costoXOperacion = 20

	method saldo() {
		return saldo
	}

	method saldo(_saldo) {
		saldo = _saldo
	}

	method costoXOperacion() {
		return costoXOperacion
	}

	method costoXOperacion(_costoXOperacion) {
		costoXOperacion = _costoXOperacion
	}

	method depositar(dinero) {
		saldo += dinero - self.costoXOperacion()
	}

	method extraer(dinero) {
		saldo -= dinero
	}

	method vaciarCuenta() {
		saldo = 0
	}

}

object casaJulian {

	var property viveres = 40
	var property montoReparaciones = 0
	var property cuentaBancaria = cuentaCorriente
	var property estrategiaAhorro = full

	method viveresSuficientes() {
		return viveres >= 40
	}

	method comprarViveres(_viveres, montoViveres) {
		viveres += _viveres
		self.cuentaBancaria().extraer(montoViveres)
	}

	method laCasaEstaEnOrden() {
		return !self.hayQueReparar() && self.viveresSuficientes()
	}

	method hayQueReparar() {
		return montoReparaciones != 0
	}

	method romperAlgo(valorRotura) {
		montoReparaciones += valorRotura
	}

	method arreglarTodo() {
		self.cuentaBancaria().extraer(montoReparaciones)
		self.montoReparaciones(0)
	}

	method mantenimientoCasa() {
		self.estrategiaAhorro().mantenerCasa(self)
	}

}

object casaPepe {

	var property viveres = 60
	var property montoReparaciones = 500
	var property cuentaBancaria = cuentaCombinada
	var property estrategiaAhorro = minimoEIndispensable

	method viveresSuficientes() {
		return viveres >= 40
	}

	method comprarViveres(_viveres, montoViveres) {
		viveres += _viveres
		self.cuentaBancaria().extraer(montoViveres)
	}

	method laCasaEstaEnOrden() {
		return !self.hayQueReparar() && self.viveresSuficientes()
	}

	method hayQueReparar() {
		return montoReparaciones != 0
	}

	method romperAlgo(valorRotura) {
		montoReparaciones += valorRotura
	}

	method arreglarTodo() {
		self.cuentaBancaria().extraer(montoReparaciones)
		self.montoReparaciones(0)
	}

	method mantenimientoCasa() {
		self.estrategiaAhorro().mantenerCasa(self)
	}

}

object full {

	const calidad = 5

	method mantenerCasa(casa) {
		if (casa.laCasaEstaEnOrden()) {
			casa.comprarViveres(self.porcentajeAComprar(casa, 100), self.montoCompraViveres(self.porcentajeAComprar(casa, 100)))
		} else {
			casa.comprarViveres(40, self.montoCompraViveres(40))
		}
		if (self.saldoCasaAlcanzaParaReparar(casa) && self.saldoCasa(casa) > 1000) {
			casa.arreglarTodo()
		}
	}

	method montoCompraViveres(viveresAComprar) {
		return viveresAComprar * calidad
	}

	method porcentajeAComprar(casa, maxViveres) {
		return maxViveres - casa.viveres()
	}

	method saldoCasaAlcanzaParaReparar(casa) {
		return casa.cuentaBancaria().saldo() >= casa.montoReparaciones()
	}

	method saldoCasa(casa) {
		return casa.cuentaBancaria().saldo()
	}

}

object minimoEIndispensable {

	var property calidad = 1

	method mantenerCasa(casa) {
		if (!casa.viveresSuficientes()) {
			casa.comprarViveres(self.porcentajeAComprar(casa, 40), self.montoCompraViveres(self.porcentajeAComprar(casa, 40)))
		}
	}

	method montoCompraViveres(viveresAComprar) {
		return viveresAComprar * self.calidad()
	}

	method porcentajeAComprar(casa, maxViveres) {
		return maxViveres - casa.viveres()
	}

}

