<?php
/**
*@package   pXP
*@file      ACTTpmTarjeta.php
*@author    Gonzalo Sarmiento Sejas
*@date 29-11-2012 02:21:39
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTpmTarjeta extends ACTbase{    
			
	function listarTpmTarjeta(){
		$this->objParam->defecto('ordenacion','id_tpm_tarjeta');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarTpmTarjeta');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarTpmTarjeta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTpmTarjeta(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_tpm_tarjeta')){
			$this->res=$this->objFunc->insertarTpmTarjeta($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTpmTarjeta($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTpmTarjeta(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarTpmTarjeta($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>