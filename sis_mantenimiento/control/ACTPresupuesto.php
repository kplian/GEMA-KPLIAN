<?php
/**
*@package pXP
*@file gen-ACTPresupuesto.php
*@author  (admin)
*@date 12-06-2013 08:25:14
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPresupuesto extends ACTbase{    
			
	function listarPresupuesto(){
		$this->objParam->defecto('ordenacion','id_presupuesto');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPresupuesto','listarPresupuesto');
		} else{
			$this->objFunc=$this->create('MODPresupuesto');
			
			$this->res=$this->objFunc->listarPresupuesto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPresupuesto(){
		$this->objFunc=$this->create('MODPresupuesto');	
		if($this->objParam->insertar('id_presupuesto')){
			$this->res=$this->objFunc->insertarPresupuesto($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPresupuesto($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPresupuesto(){
			$this->objFunc=$this->create('MODPresupuesto');	
		$this->res=$this->objFunc->eliminarPresupuesto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarPresupuestoPeriodo(){
		$this->objParam->defecto('ordenacion','id_presupuesto');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPresupuesto','listarPresupuestoPeriodo');
		} else{
			$this->objFunc=$this->create('MODPresupuesto');
			$this->res=$this->objFunc->listarPresupuestoPeriodo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>