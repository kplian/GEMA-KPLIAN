<?php
/**
*@package       pXP
*@file          gen-ACTPlanMant.php
*@author        (rac)
*@date          12-10-2012 16:15:31
*@description   Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPlanMant extends ACTbase{    
			
	function listarPlanMant(){
		$this->objParam->defecto('ordenacion','id_plan_mant');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarPlanMant');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarPlanMant($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPlanMant(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_plan_mant')){
			$this->res=$this->objFunc->insertarPlanMant($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPlanMant($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPlanMant(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarPlanMant($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}
?>