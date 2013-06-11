<?php
/**
*@package pXP
*@file gen-ACTMantPredef.php
*@author  (admin)
*@date 28-08-2012 20:25:32
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTMantPredef extends ACTbase{    
			
	function listarMantPredef(){
		$this->objParam->defecto('ordenacion','id_mant_predef');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODMantPredef','listarMantPredef');
		} else{
			$this->objFunc=$this->create('MODMantPredef');	
			$this->res=$this->objFunc->listarMantPredef();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMantPredef(){
		$this->objFunc=$this->create('MODMantPredef');	
		if($this->objParam->insertar('id_mant_predef')){
			$this->res=$this->objFunc->insertarMantPredef();			
		} else{			
			$this->res=$this->objFunc->modificarMantPredef();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMantPredef(){
		$this->objFunc=$this->create('MODMantPredef');	
		$this->res=$this->objFunc->eliminarMantPredef();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarMantPredefUC(){
		$this->objParam->defecto('ordenacion','id_mant_predef');
		$this->objParam->defecto('dir_ordenacion','asc');
		//var_dump($this->objParam->getParametro('id_uni_cons'));
		//var_dump($this->objParam);
		//if($node=='id'){
		//	echo 'id_uni_cons:' .$id_uni_cons;exit;
			//$this->objParam->addParametro('id_uni_cons',$id_uni_cons);
		//}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODMantPredef','listarMantPredefUC');
		} else{
			$this->objFunc=$this->create('MODMantPredef');	
			$this->res=$this->objFunc->listarMantPredefUC();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>