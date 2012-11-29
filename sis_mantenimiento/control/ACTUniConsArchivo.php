<?php
/**
*@package       pXP
*@file          ACTUniConsArchivo.php
*@author        (rac)
*@date          26-10-2012 18:08:27
*@description   Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTUniConsArchivo extends ACTbase{    
			
	function listarUniConsArchivo(){
		$this->objParam->defecto('ordenacion','id_uni_cons_archivo');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniConsArchivo','listarUniConsArchivo');
		} else{
			$this->objFunc=$this->create('MODUniConsArchivo');	
			$this->res=$this->objFunc->listarUniConsArchivo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsArchivo(){
		$this->objFunc=$this->create('MODUniConsArchivo');	
		if($this->objParam->insertar('id_uni_cons_archivo')){
			$this->res=$this->objFunc->insertarUniConsArchivo();			
		} else{			
			$this->res=$this->objFunc->modificarUniConsArchivo();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsArchivo(){
		$this->objFunc=$this->create('MODUniConsArchivo');	
		$this->res=$this->objFunc->eliminarUniConsArchivo();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
    function subirArchivo(){
        $this->objFunc=$this->create('MODUniConsArchivo');
        $this->res=$this->objFunc->subirUniConsArchivo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
	function subirVersionArchivo(){
        $this->objFunc= $this->create('MODUniConsArchivo');
        $this->res=$this->objFunc->subirVersionUniConsArchivo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function listarVersionArchivo(){
        $this->objParam->defecto('ordenacion','id_uni_cons_archivo');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objFunc= $this->create('MODUniConsArchivo');
        $this->res=$this->objFunc->listarVersionArchivo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    		
}
?>