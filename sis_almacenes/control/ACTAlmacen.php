<?php
/**
 * @Package pxP
 * @file 	ACTAlmacen.php
 * @author 	Gonzalo Sarmiento
 * @date 	21-09-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */
 
 class ACTAlmacen extends ACTbase{    
			
	function listarAlmacen(){
		$this->objParam->defecto('ordenacion','codigo');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesAlmacenes','listarAlmacen');
		} else{
			$this->objFunc=new FuncionesAlmacenes();	
			$this->res=$this->objFunc->listarAlmacen($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAlmacen(){
		$this->objFunc=new FuncionesAlmacenes();	
		if($this->objParam->insertar('id_almacen')){
			$this->res=$this->objFunc->insertarAlmacen($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAlmacen($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAlmacen(){
		$this->objFunc=new FuncionesAlmacenes();	
		$this->res=$this->objFunc->eliminarAlmacen($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}			
} 
?>
