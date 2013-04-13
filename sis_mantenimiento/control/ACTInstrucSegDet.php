<?php
/**
*@package pXP
*@file gen-ACTInstrucSegDet.php
*@author  (admin)
*@date 13-04-2013 03:01:16
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTInstrucSegDet extends ACTbase{    
			
	function listarInstrucSegDet(){
		$this->objParam->defecto('ordenacion','id_instruc_seg_det');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_instruc_seg')!=''){
			$this->objParam->addFiltro("insede.id_instruc_seg = ".$this->objParam->getParametro('id_instruc_seg'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODInstrucSegDet','listarInstrucSegDet');
		} else{
			$this->objFunc=$this->create('MODInstrucSegDet');
			
			$this->res=$this->objFunc->listarInstrucSegDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarInstrucSegDet(){
		$this->objFunc=$this->create('MODInstrucSegDet');	
		if($this->objParam->insertar('id_instruc_seg_det')){
			$this->res=$this->objFunc->insertarInstrucSegDet($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarInstrucSegDet($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarInstrucSegDet(){
			$this->objFunc=$this->create('MODInstrucSegDet');	
		$this->res=$this->objFunc->eliminarInstrucSegDet($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>