<?php
/**
*@package pXP
*@file gen-ACTPresupuestoLocalizacionUsuario.php
*@author  (admin)
*@date 02-07-2013 04:45:06
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPresupuestoLocalizacionUsuario extends ACTbase{    
			
	function listarPresupuestoLocalizacionUsuario(){
		$this->objParam->defecto('ordenacion','id_presupuesto_localizacion_usuario');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_presupuesto_localizacion')!=''){
			$this->objParam->addFiltro("gpreus.id_presupuesto_localizacion = ".$this->objParam->getParametro('id_presupuesto_localizacion'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODPresupuestoLocalizacionUsuario','listarPresupuestoLocalizacionUsuario');
		} else{
			$this->objFunc=$this->create('MODPresupuestoLocalizacionUsuario');
			
			$this->res=$this->objFunc->listarPresupuestoLocalizacionUsuario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPresupuestoLocalizacionUsuario(){
		$this->objFunc=$this->create('MODPresupuestoLocalizacionUsuario');	
		if($this->objParam->insertar('id_presupuesto_localizacion_usuario')){
			$this->res=$this->objFunc->insertarPresupuestoLocalizacionUsuario($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarPresupuestoLocalizacionUsuario($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPresupuestoLocalizacionUsuario(){
			$this->objFunc=$this->create('MODPresupuestoLocalizacionUsuario');	
		$this->res=$this->objFunc->eliminarPresupuestoLocalizacionUsuario($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>