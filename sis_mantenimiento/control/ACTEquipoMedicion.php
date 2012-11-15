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
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarEquipoMedicion');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarEquipoMedicion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarEquipoMedicionDinamico(){
		//$this->objParam->defecto('ordenacion','fecha');

		//$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarEquipoMedicionDinamico');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarEquipoMedicionDinamico($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function insertarEquipoMedicionDinamico(){
		$this->objFunc=new FuncionesMantenimiento();
		
		$id33 = $this->objParam->getParametro('id_mediciones_mes');
		
		
		$codigo=$id33['id_mediciones_mes'];
		
		
		$id334 = $this->objParam->getParametro(0);
		
		
		

		
		if(!isset($id334)){
		   $codigo= $this->objParam->getParametro('id_mediciones_mes');
			
		}
		
		$this->res=$this->objFunc->insertarEquipoMedicionDinamico($this->objParam);	
				
		//todas la funciones van a ser dfe insercionb 
		//en base se controlare si es necesario modificar o no
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarEquipoMedicion(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_equipo_medicion')){
			$this->res=$this->objFunc->insertarEquipoMedicion($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarEquipoMedicion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
	
	function eliminarEquipoMedicionDinamico(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarEquipoMedicionDinamico($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
						
	function eliminarEquipoMedicion(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarEquipoMedicion($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarMedicionGraf(){
		$this->objParam->defecto('ordenacion','id_equipo_medicion');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarMedicionGraf');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarMedicionGraf($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>