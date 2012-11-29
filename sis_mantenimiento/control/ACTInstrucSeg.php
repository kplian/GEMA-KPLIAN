<?php
/**
*@package pXP
*@file gen-ACTInstrucSeg.php
*@author  (admin)
*@date 22-11-2012 15:45:32
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTInstrucSeg extends ACTbase{    
			
	function listarInstrucSeg(){
		$this->objParam->defecto('ordenacion','id_instruc_seg');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODInstrucSeg','listarInstrucSeg');
		} else{
			$this->objFunc=$this->create('MODInstrucSeg');	
			$this->res=$this->objFunc->listarInstrucSeg();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarInstrucSeg(){
		$this->objFunc=$this->create('MODInstrucSeg');	
		if($this->objParam->insertar('id_instruc_seg')){
			$this->res=$this->objFunc->insertarInstrucSeg();			
		} else{			
			$this->res=$this->objFunc->modificarInstrucSeg();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarInstrucSeg(){
		$this->objFunc=$this->create('MODInstrucSeg');	
		$this->res=$this->objFunc->eliminarInstrucSeg();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>