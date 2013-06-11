<?php
/**
*@package pXP
*@file gen-ACTFuncionarioHonorario.php
*@author  (admin)
*@date 22-09-2012 01:44:56
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTFuncionarioHonorario extends ACTbase{    
			
	function listarFuncionarioHonorario(){
		$this->objParam->defecto('ordenacion','id_funcionario_honorario');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_funcionario')!=''){
			$this->objParam->addFiltro("gefuho.id_funcionario = ".$this->objParam->getParametro('id_funcionario'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODFuncionarioHonorario','listarFuncionarioHonorario');
		} else{
			$this->objFunc=$this->create('MODFuncionarioHonorario');	
			$this->res=$this->objFunc->listarFuncionarioHonorario();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarFuncionarioHonorario(){
		$this->objFunc=$this->create('MODFuncionarioHonorario');	
		if($this->objParam->insertar('id_funcionario_honorario')){
			$this->res=$this->objFunc->insertarFuncionarioHonorario();			
		} else{			
			$this->res=$this->objFunc->modificarFuncionarioHonorario();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarFuncionarioHonorario(){
		$this->objFunc=$this->create('MODFuncionarioHonorario');	
		$this->res=$this->objFunc->eliminarFuncionarioHonorario();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>