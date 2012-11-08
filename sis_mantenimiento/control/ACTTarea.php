<?php
/**
*@package       pXP
*@file          gen-ACTTarea.php
*@author        (rac)
*@date          17-10-2012 18:22:11
*@description   Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTarea extends ACTbase{    
			
	function listarTarea(){
		$this->objParam->defecto('ordenacion','id_tarea');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarTarea');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarTarea($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTarea(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_tarea')){
			$this->res=$this->objFunc->insertarTarea($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTarea($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTarea(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarTarea($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}
?>