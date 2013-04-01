<?php
/**
*@package pXP
*@file gen-ACTTipoEquipoCol.php
*@author  (admin)
*@date 19-03-2013 11:20:37
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTTipoEquipoCol extends ACTbase{    
			
	function listarTipoEquipoCol(){
		$this->objParam->defecto('ordenacion','id_tipo_equipo_col');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		if($this->objParam->getParametro('id_tipo_equipo')!=''){
			$this->objParam->addFiltro("teqcol.id_tipo_equipo = ".$this->objParam->getParametro('id_tipo_equipo'));	
		}
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTipoEquipoCol','listarTipoEquipoCol');
		} else{
			$this->objFunc=$this->create('MODTipoEquipoCol');
			
			$this->res=$this->objFunc->listarTipoEquipoCol($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTipoEquipoCol(){
		$this->objFunc=$this->create('MODTipoEquipoCol');	
		if($this->objParam->insertar('id_tipo_equipo_col')){
			$this->res=$this->objFunc->insertarTipoEquipoCol($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTipoEquipoCol($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTipoEquipoCol(){
			$this->objFunc=$this->create('MODTipoEquipoCol');	
		$this->res=$this->objFunc->eliminarTipoEquipoCol($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>