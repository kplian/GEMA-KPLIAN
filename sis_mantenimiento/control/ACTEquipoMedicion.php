<?php
/**
*@package pXP
*@file gen-ACTEquipoMedicion.php
*@author  (admin)
*@date 27-09-2012 03:02:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTEquipoMedicion extends ACTbase{    
			
	function listarEquipoMedicion(){
		$this->objParam->defecto('ordenacion','id_equipo_medicion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODEquipoMedicion','listarEquipoMedicion');
		} else{
			$this->objFunc=$this->create('MODEquipoMedicion');	
			$this->res=$this->objFunc->listarEquipoMedicion();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarEquipoMedicionDinamico(){
		//$this->objParam->defecto('ordenacion','fecha');

		//$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODEquipoMedicion','listarEquipoMedicionDinamico');
		} else{
			$this->objFunc=$this->create('MODEquipoMedicion');	
			$this->res=$this->objFunc->listarEquipoMedicionDinamico();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function insertarEquipoMedicionDinamico(){
		
		
		$id33 = $this->objParam->getParametro('id_mediciones_mes');
		
		
		$codigo=$id33['id_mediciones_mes'];
		
		
		$id334 = $this->objParam->getParametro(0);
		
		
		

		
		if(!isset($id334)){
		   $codigo= $this->objParam->getParametro('id_mediciones_mes');
			
		}
		$this->objFunc=$this->create('MODEquipoMedicion');
		$this->res=$this->objFunc->insertarEquipoMedicionDinamico();	
				
		//todas la funciones van a ser dfe insercionb 
		//en base se controlare si es necesario modificar o no
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEquipoMedicion(){
		$this->objFunc=$this->create('MODEquipoMedicion');	
		if($this->objParam->insertar('id_equipo_medicion')){
			$this->res=$this->objFunc->insertarEquipoMedicion();			
		} else{			
			$this->res=$this->objFunc->modificarEquipoMedicion();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
	
	function eliminarEquipoMedicionDinamico(){
		$this->objFunc=$this->create('MODEquipoMedicion');	
		$this->res=$this->objFunc->eliminarEquipoMedicionDinamico();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
						
	function eliminarEquipoMedicion(){
		$this->objFunc=$this->create('MODEquipoMedicion');	
		$this->res=$this->objFunc->eliminarEquipoMedicion();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarMedicionGraf(){
		$this->objParam->defecto('ordenacion','id_equipo_medicion');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODEquipoMedicion','listarMedicionGraf');
		} else{
			$this->objFunc=$this->create('MODEquipoMedicion');	
			$this->res=$this->objFunc->listarMedicionGraf();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>