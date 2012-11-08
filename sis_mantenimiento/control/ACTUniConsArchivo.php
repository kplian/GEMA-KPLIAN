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
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarUniConsArchivo');
		} else{
			$this->objFunc=new FuncionesMantenimiento();	
			$this->res=$this->objFunc->listarUniConsArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarUniConsArchivo(){
		$this->objFunc=new FuncionesMantenimiento();	
		if($this->objParam->insertar('id_uni_cons_archivo')){
			$this->res=$this->objFunc->insertarUniConsArchivo($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarUniConsArchivo($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarUniConsArchivo(){
		$this->objFunc=new FuncionesMantenimiento();	
		$this->res=$this->objFunc->eliminarUniConsArchivo($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
    function subirArchivo(){
        $this->objFunc=new FuncionesMantenimiento();
        $this->res=$this->objFunc->subirUniConsArchivo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
	function subirVersionArchivo(){
        $this->objFunc= new FuncionesMantenimiento();
        $this->res=$this->objFunc->subirVersionUniConsArchivo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function listarVersionArchivo(){
        $this->objParam->defecto('ordenacion','id_uni_cons_archivo');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objFunc= new FuncionesMantenimiento();
        $this->res=$this->objFunc->listarVersionArchivo($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    		
}
?>