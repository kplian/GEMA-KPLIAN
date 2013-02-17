<?php
/**
*@package pXP
*@file gen-ACTOrdenTrabajoSolInsumo.php
*@author  (admin)
*@date 17-02-2013 07:39:55
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTOrdenTrabajoSolInsumo extends ACTbase{    
			
	function listarOrdenTrabajoSolInsumo(){
		$this->objParam->defecto('ordenacion','id_orden_trabajo_sol_insumo');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_orden_trabajo_sol')!=''){
			$this->objParam->addFiltro("otsoin.id_orden_trabajo_sol = ".$this->objParam->getParametro('id_orden_trabajo_sol'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODOrdenTrabajoSolInsumo','listarOrdenTrabajoSolInsumo');
		} else{
			$this->objFunc=$this->create('MODOrdenTrabajoSolInsumo');
			
			$this->res=$this->objFunc->listarOrdenTrabajoSolInsumo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarOrdenTrabajoSolInsumo(){
		$this->objFunc=$this->create('MODOrdenTrabajoSolInsumo');	
		if($this->objParam->insertar('id_orden_trabajo_sol_insumo')){
			$this->res=$this->objFunc->insertarOrdenTrabajoSolInsumo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarOrdenTrabajoSolInsumo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarOrdenTrabajoSolInsumo(){
			$this->objFunc=$this->create('MODOrdenTrabajoSolInsumo');	
		$this->res=$this->objFunc->eliminarOrdenTrabajoSolInsumo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>