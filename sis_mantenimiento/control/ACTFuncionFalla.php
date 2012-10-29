<?php
/**
*@package pXP
*@file gen-ACTFuncionFalla.php
*@author  (admin)
*@date 30-09-2012 21:41:13
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFuncionFalla extends ACTbase{    
			
	function listarFuncionFalla(){
		$this->objParam->defecto('ordenacion','id_funcion_falla');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarFuncionFalla');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarFuncionFalla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFuncionFalla(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_funcion_falla')){
			$this->res=$this->objFunc->insertarFuncionFalla($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarFuncionFalla($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFuncionFalla(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarFuncionFalla($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>