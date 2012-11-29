<?php
/**
*@package pXP
*@file gen-ACTLocalizacionUsuario.php
*@author  (admin)
*@date 25-11-2012 04:18:07
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLocalizacionUsuario extends ACTbase{    
			
	function listarLocalizacionUsuario(){
		$this->objParam->defecto('ordenacion','id_localizacion_usuario');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarLocalizacionUsuario');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarLocalizacionUsuario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLocalizacionUsuario(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_localizacion_usuario')){
			$this->res=$this->objFunc->insertarLocalizacionUsuario($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarLocalizacionUsuario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLocalizacionUsuario(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarLocalizacionUsuario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>