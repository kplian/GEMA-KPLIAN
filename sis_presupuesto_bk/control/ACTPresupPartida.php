<?php
/**
*@package pXP
*@file gen-ACTPresupPartida.php
*@author  Gonzalo Sarmiento Sejas
*@date 26-11-2012 22:02:47
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPresupPartida extends ACTbase{    
			
	function listarPresupPartida(){
		$this->objParam->defecto('ordenacion','id_presup_partida');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODPresupPartida','listarPresupPartida');
		} else{
			$this->objFunc=$this->create('MODPresupPartida');	
			$this->res=$this->objFunc->listarPresupPartida();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPresupPartida(){
		$this->objFunc=$this->create('MODPresupPartida');	
		if($this->objParam->insertar('id_presup_partida')){
			$this->res=$this->objFunc->insertarPresupPartida();			
		} else{			
			$this->res=$this->objFunc->modificarPresupPartida();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPresupPartida(){
		$this->objFunc=$this->create('MODPresupPartida');	
		$this->res=$this->objFunc->eliminarPresupPartida();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>