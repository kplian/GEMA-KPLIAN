<?php
/**
*@package pXP
*@file gen-ACTPresupuestoLoc.php
*@author  (admin)
*@date 11-06-2013 19:38:04
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPresupuestoLoc extends ACTbase{    
			
	function listarPresupuestoLoc(){
		$this->objParam->defecto('ordenacion','id_presupuesto_loc');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_presupuesto')!=''){
			$this->objParam->addFiltro("geprlo.id_presupuesto = ".$this->objParam->getParametro('id_presupuesto'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPresupuestoLoc','listarPresupuestoLoc');
		} else{
			$this->objFunc=$this->create('MODPresupuestoLoc');
			
			$this->res=$this->objFunc->listarPresupuestoLoc($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPresupuestoLoc(){
		$this->objFunc=$this->create('MODPresupuestoLoc');	
		if($this->objParam->insertar('id_presupuesto_loc')){
			$this->res=$this->objFunc->insertarPresupuestoLoc($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPresupuestoLoc($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPresupuestoLoc(){
			$this->objFunc=$this->create('MODPresupuestoLoc');	
		$this->res=$this->objFunc->eliminarPresupuestoLoc($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarPresupuestoLocRegistro(){
		$this->objParam->defecto('ordenacion','id_presupuesto_loc');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_presupuesto')!=''){
			$this->objParam->addFiltro("geprlo.id_presupuesto = ".$this->objParam->getParametro('id_presupuesto'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPresupuestoLoc','listarPresupuestoLocRegistro');
		} else{
			$this->objFunc=$this->create('MODPresupuestoLoc');
			
			$this->res=$this->objFunc->listarPresupuestoLocRegistro($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>