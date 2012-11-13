<?php
/**
*@package pXP
*@file gen-ACTEquipoVariable.php
*@author  (rac)
*@date 15-08-2012 17:09:17
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEquipoVariable extends ACTbase{    
			
	function listarEquipoVariable(){
		$this->objParam->defecto('ordenacion','id_equipo_variable');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarEquipoVariable');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarEquipoVariable($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarColumnasEquipoVariable(){
		$this->objParam->defecto('ordenacion','id_equipo_variable');

		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_uni_cons')!=''){
			$this->objParam->addFiltro("eqv.id_uni_cons = ".$this->objParam->getParametro('id_uni_cons'));	
		}
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->listarEquipoVariable($this->objParam);
		
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
				
	function insertarEquipoVariable(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_equipo_variable')){
			$this->res=$this->objFunc->insertarEquipoVariable($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEquipoVariable($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarEquipoVariable(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarEquipoVariable($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarVariables(){
		$this->objParam->defecto('ordenacion','id_equipo_variable');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarVariables');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarVariables($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>