<?php
/**
*@package   pXP
*@file      ACTAnalisisPorqueSol.php
*@author    Gonzalo Sarmiento Sejas
*@date 28-11-2012 22:28:33
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAnalisisPorqueSol extends ACTbase{    
			
	function listarAnalisisPorqueSol(){
		$this->objParam->defecto('ordenacion','id_analisis_porque_sol');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAnalisisPorqueSol','listarAnalisisPorqueSol');
		} else{
			$this->objFunc=$this->create('MODAnalisisPorqueSol');	
			$this->res=$this->objFunc->listarAnalisisPorqueSol();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAnalisisPorqueSol(){
		$this->objFunc=$this->create('MODAnalisisPorqueSol');	
		if($this->objParam->insertar('id_analisis_porque_sol')){
			$this->res=$this->objFunc->insertarAnalisisPorqueSol();			
		} else{			
			$this->res=$this->objFunc->modificarAnalisisPorqueSol();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAnalisisPorqueSol(){
		$this->objFunc=$this->create('MODAnalisisPorqueSol');	
		$this->res=$this->objFunc->eliminarAnalisisPorqueSol();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>