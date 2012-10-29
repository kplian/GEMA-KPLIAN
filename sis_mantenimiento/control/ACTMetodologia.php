<?php
/**
*@package pXP
*@file gen-ACTMetodologia.php
*@author  (admin)
*@date 17-08-2012 15:52:46
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMetodologia extends ACTbase{    
			
	function listarMetodologia(){
		$this->objParam->defecto('ordenacion','id_metodologia');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarMetodologia');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarMetodologia($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMetodologia(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_metodologia')){
			$this->res=$this->objFunc->insertarMetodologia($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarMetodologia($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMetodologia(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarMetodologia($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>