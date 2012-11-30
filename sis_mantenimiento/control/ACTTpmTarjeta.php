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
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTpmTarjeta','listarTpmTarjeta');
		} else{
			$this->objFunc=$this->create('MODTpmTarjeta');	
			$this->res=$this->objFunc->listarTpmTarjeta();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTpmTarjeta(){
		$this->objFunc=$this->create('MODTpmTarjeta');	
		if($this->objParam->insertar('id_tpm_tarjeta')){
			$this->res=$this->objFunc->insertarTpmTarjeta();			
		} else{			
			$this->res=$this->objFunc->modificarTpmTarjeta();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTpmTarjeta(){
		$this->objFunc=$this->create('MODTpmTarjeta');	
		$this->res=$this->objFunc->eliminarTpmTarjeta();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>