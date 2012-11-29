<?php
/**
*@package pXP
*@file gen-ACTCalendarioPlanificado.php
*@author  (admin)
*@date 02-11-2012 15:04:36
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTCalendarioPlanificado extends ACTbase{    

	function listarCalendarioPlanificado(){
		$this->objParam->defecto('ordenacion','id_calendario_planificado');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){

			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarCalendarioPlanificado');
		} else{
			$this->objFunc=$this->create('MODCalendarioPlanificado');
			$this->res=$this->objFunc->listarCalendarioPlanificado($this->objParam);

		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function insertarCalendarioPlanificado(){
		$this->objFunc=$this->create('MODCalendarioPlanificado');	
		if($this->objParam->insertar('id_calendario_planificado')){
			$this->res=$this->objFunc->insertarCalendarioPlanificado();			
		} else{			
			$this->res=$this->objFunc->modificarCalendarioPlanificado();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function eliminarCalendarioPlanificado(){
		$this->objFunc=$this->create('MODCalendarioPlanificado');	
		$this->res=$this->objFunc->eliminarCalendarioPlanificado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarMesesCalendario(){


		$this->objParam->defecto('ordenacion','id_mes');
        $this->objParam->defecto('dir_ordenacion','asc');
		$this->objFunc=$this->create('MODCalendarioPlanificado');	
		$this->res=$this->objFunc->listarMesesCalendario();


		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarMesesCalendarioDet(){


		$this->objParam->defecto('ordenacion','id_mes');
        $this->objParam->defecto('dir_ordenacion','asc');

		$this->objFunc=$this->create('MODCalendarioPlanificado');	
	    $this->res=$this->objFunc->listarMesesCalendarioDet();

		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarCalendarioPlanificadoDet(){
		$this->objParam->defecto('ordenacion','nombre_uni_cons');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarCalendarioPlanificadoDet');

		} else{
			$this->objFunc=$this->create('MODCalendarioPlanificado');	
			$this->res=$this->objFunc->listarCalendarioPlanificadoDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function OtenerCalPla(){
		$this->objFunc=$this->create('MODCalendarioPlanificado');	
		$this->res=$this->objFunc->OtenerCalPla();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function UpdateCalPla(){
		$this->objFunc=$this->create('MODCalendarioPlanificado');
		$this->res=$this->objFunc->UpdateCalPla();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

}
?>