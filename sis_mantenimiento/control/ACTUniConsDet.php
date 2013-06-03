<?php
/**
*@package pXP
*@file gen-ACTUniConsDet.php
*@author  (admin)
*@date 08-11-2012 21:12:55
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniConsDet extends ACTbase{    
			
	function listarUniConsDet(){
		$this->objParam->defecto('ordenacion','id_uni_cons_det');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsDet','listarUniConsDet');
		} else{
			$this->objFunc=$this->create('MODUniConsDet');	
			$this->res=$this->objFunc->listarUniConsDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsDet(){
		$this->objFunc=$this->create('MODUniConsDet');	
		if($this->objParam->insertar('id_uni_cons_det')){
			$this->res=$this->objFunc->insertarUniConsDet();			
		} else{			
			$this->res=$this->objFunc->modificarUniConsDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsDet(){
		$this->objFunc=$this->create('MODUniConsDet');	
		$this->res=$this->objFunc->eliminarUniConsDet();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarCaract(){
		$this->objParam->defecto('ordenacion','nombre');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsDet','listarCaract');
		} else{
			$this->objFunc=$this->create('MODUniConsDet');	
			$this->res=$this->objFunc->listarCaract();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarColumnasFichaTec(){
		$this->objParam->defecto('ordenacion','id_uni_cons_det');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_tipo_equipo')!=''){
			$this->objParam->addFiltro("ucons.id_tipo_equipo = ".$this->objParam->getParametro('id_tipo_equipo'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsDet','listarColumnasFichaTec');
		} else{
			$this->objFunc=$this->create('MODUniConsDet');	
			$this->res=$this->objFunc->listarColumnasFichaTec();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarColumnasFichaTecVar(){
		$this->objParam->defecto('ordenacion','id_uni_cons_det');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsDet','listarColumnasFichaTecVar');
		} else{
			$this->objFunc=$this->create('MODUniConsDet');	
			$this->res=$this->objFunc->listarColumnasFichaTecVar();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarFichaTecnicaVariables(){
		$this->objParam->defecto('ordenacion','id_uni_cons_det');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			//var_dump($this->objParam);exit;
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsDet','listarFichaTecnicaVariables');
		} else{
			$this->objFunc=$this->create('MODUniConsDet');	
			$this->res=$this->objFunc->listarFichaTecnicaVariables();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>