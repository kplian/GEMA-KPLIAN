<?php
/**
*@package pXP
*@file gen-ACTAnalisisMant.php
*@author  (admin)
*@date 30-09-2012 21:44:06
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAnalisisMant extends ACTbase{    
			
	function listarAnalisisMant(){
		$this->objParam->defecto('ordenacion','id_analisis_mant');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarAnalisisMant');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarAnalisisMant($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAnalisisMant(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_analisis_mant')){
			$this->res=$this->objFunc->insertarAnalisisMant($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAnalisisMant($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAnalisisMant(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarAnalisisMant($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>