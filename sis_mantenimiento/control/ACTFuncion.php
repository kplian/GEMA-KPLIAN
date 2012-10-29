<?php
/**
*@package pXP
*@file gen-ACTFuncion.php
*@author  (admin)
*@date 30-09-2012 21:41:09
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFuncion extends ACTbase{    
			
	function listarFuncion(){
		$this->objParam->defecto('ordenacion','id_funcion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarFuncion');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarFuncion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFuncion(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_funcion')){
			$this->res=$this->objFunc->insertarFuncion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarFuncion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFuncion(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarFuncion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>