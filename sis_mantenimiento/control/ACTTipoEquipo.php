<?php
/**
*@package pXP
*@file gen-ACTTipoEquipo.php
*@author  (rac)
*@date 08-08-2012 23:50:13
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoEquipo extends ACTbase{    
			
	function listarTipoEquipo(){
		$this->objParam->defecto('ordenacion','id_tipo_equipo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoEquipo','listarTipoEquipo');
		} else{
			$this->objFunc=$this->create('MODTipoEquipo');	
			$this->res=$this->objFunc->listarTipoEquipo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoEquipo(){
		$this->objFunc=$this->create('MODTipoEquipo');	
		if($this->objParam->insertar('id_tipo_equipo')){
			$this->res=$this->objFunc->insertarTipoEquipo();			
		} else{			
			$this->res=$this->objFunc->modificarTipoEquipo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoEquipo(){
		$this->objFunc=$this->create('MODTipoEquipo');	
		$this->res=$this->objFunc->eliminarTipoEquipo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>