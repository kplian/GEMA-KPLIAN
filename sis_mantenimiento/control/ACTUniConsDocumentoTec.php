<?php
/**
*@package pXP
*@author  aao
*@date 20-11-2012 12:10:00
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniConsDocumentoTec extends ACTbase {
			
	function listarUniConsDocumentoTec() {
		$this->objParam->defecto('ordenacion','id_documento_tec');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsDocTec','listarUniConsDocumentoTec');
		} else {
			$this->objFunc = $this->create('MODUniConsDocTec');
			$this->res=$this->objFunc->listarUniConsDocumentoTec();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function guardarUniConsDocumentoTec() {
		$this->objFunc = $this->create('MODUniConsDocTec');
		if($this->objParam->insertar('id_documento_tec')) {
			$this->res=$this->objFunc->insertarUniConsDocumentoTec();			
		} else {
			$this->res=$this->objFunc->modificarUniConsDocumentoTec();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsDocumentoTec() {
		$this->objFunc=$this->create('MODUniConsDocTec');	
		$this->res=$this->objFunc->eliminarUniConsDocumentoTec();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
}

?>