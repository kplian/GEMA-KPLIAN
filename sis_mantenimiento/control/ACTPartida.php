<?php
/**
*@package pXP
*@file gen-ACTPartida.php
*@author  (admin)
*@date 23-11-2012 16:37:48
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPartida extends ACTbase{    
			
	function listarPartida(){
		$this->objParam->defecto('ordenacion','id_partida');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarPartida');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarPartida($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPartida(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_partida')){
			$this->res=$this->objFunc->insertarPartida($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPartida($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPartida(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarPartida($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>