<?php
/**
*@package pXP
*@file gen-ACTOrdenTrabajo.php
*@author  (admin)
*@date 30-08-2012 02:48:41
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTOrdenTrabajo extends ACTbase{    
			
	function listarOrdenTrabajo(){
		$this->objParam->defecto('ordenacion','id_orden_trabajo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODOrdenTrabajo','listarOrdenTrabajo');
		} else {
			if($this->objParam->getParametro('nombreVista') == 'registrarOT') {
				$this->objParam->addFiltro(" (geoott.cat_estado = ''Borrador'' or geoott.cat_estado = ''Pendiente'')");
			} elseif($this->objParam->getParametro('nombreVista') == 'ejecutarOT') {
				$this->objParam->addFiltro(" (geoott.cat_estado = ''Pendiente'' or geoott.cat_estado = ''Abierto'')");
			} elseif($this->objParam->getParametro('nombreVista') == 'revisarOT') {
				$this->objParam->addFiltro(" (geoott.cat_estado = ''Cerrado'' or geoott.cat_estado = ''Revisado'')");
			}
			$this->objFunc=$this->create('MODOrdenTrabajo');
			$this->res=$this->objFunc->listarOrdenTrabajo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarOrdenTrabajo(){
		$this->objFunc=$this->create('MODOrdenTrabajo');	
		if($this->objParam->insertar('id_orden_trabajo')){
			$this->res=$this->objFunc->insertarOrdenTrabajo();
		} else{
			$this->res=$this->objFunc->modificarOrdenTrabajo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarOrdenTrabajo(){
		$this->objFunc=$this->create('MODOrdenTrabajo');	
		$this->res=$this->objFunc->eliminarOrdenTrabajo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function generarOT(){
		$this->objFunc=$this->create('MODOrdenTrabajo');	
		$this->res=$this->objFunc->generarOT();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function procesarOT() {
		$this->objFunc = $this->create('MODOrdenTrabajo');
		$this->res=$this->objFunc->procesarOT();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}
?>