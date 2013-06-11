<?php
/**
*@package pXP
*@file gen-ACTTipoMant.php
*@author  (admin)
*@date 17-08-2012 12:04:42
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoMant extends ACTbase{    
			
	function listarTipoMant(){
		$this->objParam->defecto('ordenacion','id_tipo_mant');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoMant','listarTipoMant');
		} else{
			$this->objFunc=$this->create('MODTipoMant');	
			$this->res=$this->objFunc->listarTipoMant();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoMant(){
		$this->objFunc=$this->create('MODTipoMant');	
		if($this->objParam->insertar('id_tipo_mant')){
			$this->res=$this->objFunc->insertarTipoMant();			
		} else{			
			$this->res=$this->objFunc->modificarTipoMant();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoMant(){
		$this->objFunc=$this->create('MODTipoMant');	
		$this->res=$this->objFunc->eliminarTipoMant();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>