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
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarInstrucSeg');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarInstrucSeg($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarInstrucSeg(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_instruc_seg')){
			$this->res=$this->objFunc->insertarInstrucSeg($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarInstrucSeg($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarInstrucSeg(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarInstrucSeg($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>