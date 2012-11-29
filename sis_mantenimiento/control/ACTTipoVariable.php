<?php
/**
*@package pXP
*@file gen-ACTTipoVariable.php
*@author  (rac)
*@date 15-08-2012 15:28:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoVariable extends ACTbase{    
			
	function listarTipoVariable(){
		$this->objParam->defecto('ordenacion','id_tipo_variable');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoVariable','listarTipoVariable');
		} else{
			$this->objFunc=$this->create('MODTipoVariable');	
			$this->res=$this->objFunc->listarTipoVariable();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoVariable(){
		$this->objFunc=$this->create('MODTipoVariable');	
		if($this->objParam->insertar('id_tipo_variable')){
			$this->res=$this->objFunc->insertarTipoVariable();			
		} else{			
			$this->res=$this->objFunc->modificarTipoVariable();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoVariable(){
		$this->objFunc=$this->create('MODTipoVariable');	
		$this->res=$this->objFunc->eliminarTipoVariable();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>