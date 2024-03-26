
object casa {
	
	var viveres = 40
	var montoReparaciones = 0
	
	method viveresSuficientes(){
		return viveres >= 40
	}
	
	method porcentajeViveres(){
		return viveres
	}
	
	method viveres(_viveres){
		viveres = _viveres
	}
	
	method laCasaEstaEnOrden(){
		return !self.hayQueReparar() && self.viveresSuficientes()
	}
	
	method hayQueReparar(){
		return montoReparaciones != 0
	}
	
	method romperAlgo(monto){
		montoReparaciones +=monto
	}
	
	method repararAlgo(monto){
		if (montoReparaciones < monto) {montoReparaciones = 0} else {montoReparaciones -=monto}
	}
	
	method arreglarTodo(){
		montoReparaciones = 0
	}	
}

object cuentaCorriente{
	var saldo = 0
	
	method saldo(){
		return saldo
	}
	
	method saldo(_saldo){
		saldo = _saldo
	}
	
	method depositar(dinero){
		saldo += dinero
	}
	
	method extraer(dinero){
		saldo -= dinero
	}	
}

object cuentaConGastos{
	
	var saldo = 0
	var costoXOperacion = 20
	
	method saldo(){
		return saldo
	}
	
	method saldo(_saldo){
		saldo = _saldo
	}
	
	method costoXOperacion(){
		return costoXOperacion
	}
	
	method costoXOperacion(_costoXOperacion){
		costoXOperacion = _costoXOperacion
	}
	
	method depositar(dinero){
		saldo += dinero - self.costoXOperacion()
	}
	
	method extraer(dinero){
		saldo -= dinero
	}	
	
	method vaciarCuenta(){
		saldo = 0
	}
}

object cuentaCombinada{
	
	var cuentaPrimaria = cuentaConGastos
	var cuentaSecundaria = cuentaCorriente
	
	method cuentaPrimaria(_cuentaPrimaria){
		cuentaPrimaria = _cuentaPrimaria
	}

	method cuentaSecundaria(_cuentaSecundaria){
		cuentaSecundaria = _cuentaSecundaria
	}
	
	method depositar(dinero){
		cuentaPrimaria.depositar(dinero)
	}	
	
	method extraer(dinero){
		if (dinero < cuentaPrimaria.saldo()) {
			cuentaPrimaria.extraer(dinero)
		}
		else cuentaSecundaria.extraer(dinero)
	}
	
	method saldo(){
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}
			
}
