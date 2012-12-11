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
		
		if($this->objParam->getParametro('id_localizacion')!='') {

			$this->objParam->addFiltro("locusu.id_localizacion = ".$this->objParam->getParametro('id_localizacion'));	
		}

		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODLocalizacionUsuario','listarLocalizacionUsuario');
		} else{
			$this->objFunc=$this->create('MODLocalizacionUsuario');	
			$this->res=$this->objFunc->listarLocalizacionUsuario();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLocalizacionUsuario(){
		$this->objFunc=$this->create('MODLocalizacionUsuario');	
		if($this->objParam->insertar('id_localizacion_usuario')){
			$this->res=$this->objFunc->insertarLocalizacionUsuario();			
		} else{			
			$this->res=$this->objFunc->modificarLocalizacionUsuario();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLocalizacionUsuario(){
		$this->objFunc=$this->create('MODLocalizacionUsuario');	
		$this->res=$this->objFunc->eliminarLocalizacionUsuario();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>