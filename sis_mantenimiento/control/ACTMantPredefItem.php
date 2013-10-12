<?php
/**
*@package pXP
*@file gen-ACTMantPredefItem.php
*@author  (admin)
*@date 10-10-2013 23:53:04
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMantPredefItem extends ACTbase{    
			
	function listarMantPredefItem(){
		$this->objParam->defecto('ordenacion','id_mant_predef_item');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_mant_predef')!=''){
			$this->objParam->addFiltro("maprit.id_mant_predef = ".$this->objParam->getParametro('id_mant_predef'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODMantPredefItem','listarMantPredefItem');
		} else{
			$this->objFunc=$this->create('MODMantPredefItem');
			
			$this->res=$this->objFunc->listarMantPredefItem($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMantPredefItem(){
		$this->objFunc=$this->create('MODMantPredefItem');	
		if($this->objParam->insertar('id_mant_predef_item')){
			$this->res=$this->objFunc->insertarMantPredefItem($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarMantPredefItem($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMantPredefItem(){
			$this->objFunc=$this->create('MODMantPredefItem');	
		$this->res=$this->objFunc->eliminarMantPredefItem($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>