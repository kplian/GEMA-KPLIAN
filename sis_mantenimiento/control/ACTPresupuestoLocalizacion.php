<?php
/**
*@package pXP
*@file gen-ACTPresupuestoLocalizacion.php
*@author  (admin)
*@date 02-07-2013 00:18:34
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPresupuestoLocalizacion extends ACTbase{    
			
	function listarPresupuestoLocalizacion(){
		$this->objParam->defecto('ordenacion','id_presupuesto_localizacion');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_presupuesto')!=''){
			$this->objParam->addFiltro("gprelo.id_presupuesto = ".$this->objParam->getParametro('id_presupuesto'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPresupuestoLocalizacion','listarPresupuestoLocalizacion');
		} else{
			$this->objFunc=$this->create('MODPresupuestoLocalizacion');
			
			$this->res=$this->objFunc->listarPresupuestoLocalizacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPresupuestoLocalizacion(){
		$this->objFunc=$this->create('MODPresupuestoLocalizacion');	
		if($this->objParam->insertar('id_presupuesto_localizacion')){
			$this->res=$this->objFunc->insertarPresupuestoLocalizacion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPresupuestoLocalizacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPresupuestoLocalizacion(){
			$this->objFunc=$this->create('MODPresupuestoLocalizacion');	
		$this->res=$this->objFunc->eliminarPresupuestoLocalizacion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function habilitarPresupuesto(){
		$this->objFunc=$this->create('MODPresupuestoLocalizacion');	
		$this->res=$this->objFunc->habilitarPresupuesto($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>