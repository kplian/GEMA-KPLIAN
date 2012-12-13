<?php
/**
*@package pXP
*@file gen-ACTLocalizacionMed.php
*@author  (admin)
*@date 07-12-2012 14:20:30
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLocalizacionMed extends ACTbase{    
			
	function listarLocalizacionMed(){
		$this->objParam->defecto('ordenacion','fecha_med');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarLocalizacionMed');
		} else{
			$this->objFunc=$this->create('MODLocalizacionMed');
			$this->res=$this->objFunc->listarLocalizacionMed();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLocalizacionMed(){
		$this->objFunc=$this->create('MODLocalizacionMed');	
		if($this->objParam->insertar('id_localizacion_med')){
			$this->res=$this->objFunc->insertarLocalizacionMed();			
		} else{			
			$this->res=$this->objFunc->modificarLocalizacionMed();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLocalizacionMed(){
		$this->objFunc=$this->create('MODLocalizacionMed');	
		$this->res=$this->objFunc->eliminarLocalizacionMed();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>