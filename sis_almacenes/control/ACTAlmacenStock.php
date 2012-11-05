<?php
/**
*@package pXP
*@file 	  ACTAlmacenStock.php
*@author  Gonzalo Sarmiento
*@date 	  01-10-2012
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAlmacenStock extends ACTbase{    
			
	function listarAlmacenItem(){
		$this->objParam->defecto('ordenacion','id_almacen_item');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesAlmacenes','listarAlmacenItem');
		} else{
			$this->objFunc=new FuncionesAlmacenes();	
			$this->res=$this->objFunc->listarAlmacenItem($this->objParam);
			$this->res->imprimirRespuesta($this->res->generarJson());
		}
	}
				
	function insertarAlmacenItem(){
		$this->objFunc=new FuncionesAlmacenes();	
		if($this->objParam->insertar('id_almacen_stock')){
			$this->res=$this->objFunc->insertarAlmacenItem($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAlmacenItem($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAlmacenItem(){
		$this->objFunc=new FuncionesAlmacenes();	
		$this->res=$this->objFunc->eliminarAlmacenItem($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>