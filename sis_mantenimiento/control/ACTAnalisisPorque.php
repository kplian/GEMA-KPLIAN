<?php
/**
*@package   pXP
*@file      ACTAnalisisPorque.php
*@author    Gonzalo Sarmiento Sejas
*@date      28-11-2012 20:22:29
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAnalisisPorque extends ACTbase{    
			
	function listarAnalisisPorque(){
		$this->objParam->defecto('ordenacion','id_analisis_porque');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAnalisisPorque','listarAnalisisPorque');
		} else{
			$this->objFunc=$this->create('MODAnalisisPorque');	
			$this->res=$this->objFunc->listarAnalisisPorque();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAnalisisPorque(){
		$this->objFunc=$this->create('MODAnalisisPorque');	
		if($this->objParam->insertar('id_analisis_porque')){
			$this->res=$this->objFunc->insertarAnalisisPorque();			
		} else{			
			$this->res=$this->objFunc->modificarAnalisisPorque();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAnalisisPorque(){
		$this->objFunc=$this->create('MODAnalisisPorque');	
		$this->res=$this->objFunc->eliminarAnalisisPorque();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>