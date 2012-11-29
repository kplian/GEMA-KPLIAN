<?php
/**
*@package pXP
*@file gen-ACTModoFalla.php
*@author  (rac)
*@date 18-10-2012 04:54:08
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTModoFalla extends ACTbase{    
			
	function listarModoFalla(){
		$this->objParam->defecto('ordenacion','id_modo_falla');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODModoFalla','listarModoFalla');
		} else{
			$this->objFunc=$this->create('MODModoFalla');	
			$this->res=$this->objFunc->listarModoFalla();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarModoFalla(){
		$this->objFunc=$this->create('MODModoFalla');	
		if($this->objParam->insertar('id_modo_falla')){
			$this->res=$this->objFunc->insertarModoFalla();			
		} else{			
			$this->res=$this->objFunc->modificarModoFalla();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarModoFalla(){
		$this->objFunc=$this->create('MODModoFalla');	
		$this->res=$this->objFunc->eliminarModoFalla();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>