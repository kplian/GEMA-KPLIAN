<?php
/**
 * @Package pxP
 * @file 	ACTIngreso.php
 * @author 	Gonzalo Sarmiento
 * @date 	24-09-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */
 
 class ACTIngreso extends ACTbase{    
			
	function listarIngreso(){
		$this->objParam->defecto('ordenacion','fecha_mov');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesAlmacenes','listarIngreso');
		} else{
			$this->objFunc=new FuncionesAlmacenes();	
			$this->res=$this->objFunc->listarIngreso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarIngreso(){
		$this->objFunc=new FuncionesAlmacenes();	
		if($this->objParam->insertar('id_movimiento')){
			$this->res=$this->objFunc->insertarIngreso($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarIngreso($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarIngreso(){
		$this->objFunc=new FuncionesAlmacenes();	
		$this->res=$this->objFunc->eliminarIngreso($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}			
} 
?>
