<?php
/**
*@package pXP
*@file gen-ACTFalla.php
*@author  (rac)
*@date 21-08-2012 20:44:06
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFalla extends ACTbase{    
			
	function listarFalla(){
		$this->objParam->defecto('ordenacion','id_falla');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarFalla');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarFalla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFalla(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_falla')){
			$this->res=$this->objFunc->insertarFalla($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarFalla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFalla(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarFalla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>