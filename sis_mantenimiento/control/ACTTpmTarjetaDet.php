<?php
/**
*@package   pXP
*@file      ACTTpmTarjetaDet.php
*@author    Gonzalo Sarmiento Sejas 
*@date 29-11-2012 14:51:50
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTpmTarjetaDet extends ACTbase{    
			
	function listarTpmTarjetaDet(){
		$this->objParam->defecto('ordenacion','id_tpm_tarjeta_det');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTpmTarjetaDet','listarTpmTarjetaDet');
		} else{
			$this->objFunc=$this->create('MODTpmTarjetaDet');	
			$this->res=$this->objFunc->listarTpmTarjetaDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTpmTarjetaDet(){
		$this->objFunc=$this->create('MODTpmTarjetaDet');	
		if($this->objParam->insertar('id_tpm_tarjeta_det')){
			$this->res=$this->objFunc->insertarTpmTarjetaDet();			
		} else{			
			$this->res=$this->objFunc->modificarTpmTarjetaDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTpmTarjetaDet(){
		$this->objFunc=$this->create('MODTpmTarjetaDet');	
		$this->res=$this->objFunc->eliminarTpmTarjetaDet();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>