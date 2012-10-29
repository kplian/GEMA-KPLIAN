<?php
/**
*@package pXP
*@file gen-ACTTipoMant.php
*@author  (admin)
*@date 17-08-2012 12:04:42
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoMant extends ACTbase{    
			
	function listarTipoMant(){
		$this->objParam->defecto('ordenacion','id_tipo_mant');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarTipoMant');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarTipoMant($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoMant(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_tipo_mant')){
			$this->res=$this->objFunc->insertarTipoMant($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoMant($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoMant(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarTipoMant($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>