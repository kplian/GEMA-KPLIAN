<?php
/**
*@package pXP
*@file gen-ACTOrdenTrabajoSol.php
*@author  (admin)
*@date 02-01-2013 15:59:36
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTOrdenTrabajoSol extends ACTbase{    
			
	function listarOrdenTrabajoSol(){
		$this->objParam->defecto('ordenacion','id_orden_trabajo_sol');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarOrdenTrabajoSol');
		} else{
			$this->objFunc=$this->create('MODOrdenTrabajoSol');
			$this->res=$this->objFunc->listarOrdenTrabajoSol($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarOrdenTrabajoSol(){
		$this->objFunc=$this->create('MODOrdenTrabajoSol');	
		if($this->objParam->insertar('id_orden_trabajo_sol')){
			$this->res=$this->objFunc->insertarOrdenTrabajoSol($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarOrdenTrabajoSol($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarOrdenTrabajoSol(){
		$this->objFunc=$this->create('MODOrdenTrabajoSol');	
		$this->res=$this->objFunc->eliminarOrdenTrabajoSol($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function finalizarOrdenTrabajoSol(){
		$this->objFunc=$this->create('MODOrdenTrabajoSol');	
		$this->res=$this->objFunc->finalizarOrdenTrabajoSol($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>