<?php
/**
*@package pXP
*@file gen-ACTUniConsMantPredef.php
*@author  (admin)
*@date 02-11-2012 15:07:12
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniConsMantPredef extends ACTbase{    
			
	function listarUniConsMantPredef(){
		$this->objParam->defecto('ordenacion','id_uni_cons_mant_predef');

		$this->objParam->defecto('dir_ordenacion','asc');
		//var_dump($this->objParam);exit;
		if($this->objParam->getParametro('id_uni_cons')!=''){
			$this->objParam->addFiltro("geeqma.id_uni_cons = ".$this->objParam->getParametro('id_uni_cons'));	
		} else{
			//echo 'asdasdasdsa';exit;
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsMantPredef','listarUniConsMantPredef');
		} else{
			$this->objFunc=$this->create('MODUniConsMantPredef');	
			$this->res=$this->objFunc->listarUniConsMantPredef();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsMantPredef(){
		$this->objFunc=$this->create('MODUniConsMantPredef');	
		if($this->objParam->insertar('id_uni_cons_mant_predef')){
			$this->res=$this->objFunc->insertarUniConsMantPredef();			
		} else{			
			$this->res=$this->objFunc->modificarUniConsMantPredef();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsMantPredef(){
		$this->objFunc=$this->create('MODUniConsMantPredef');	
		$this->res=$this->objFunc->eliminarUniConsMantPredef();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>