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
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarAnalisisPorque');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarAnalisisPorque($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAnalisisPorque(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_analisis_porque')){
			$this->res=$this->objFunc->insertarAnalisisPorque($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAnalisisPorque($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAnalisisPorque(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarAnalisisPorque($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>