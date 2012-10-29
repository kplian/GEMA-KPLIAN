<?php
/**
 * @Package pxP
 * @file 	ACTSalida.php
 * @author 	Gonzalo Sarmiento
 * @date 	25-09-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */
 
 class ACTSalida extends ACTbase{    
			
	function listarSalida(){
		$this->objParam->defecto('ordenacion','fecha_mov');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesAlmacenes','listarSalida');
		} else{
			$this->objFunc=new FuncionesAlmacenes();	
			$this->res=$this->objFunc->listarSalida($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarSalida(){
		$this->objFunc=new FuncionesAlmacenes();	
		if($this->objParam->insertar('id_movimiento')){
			$this->res=$this->objFunc->insertarSalida($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarSalida($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarSalida(){
		$this->objFunc=new FuncionesAlmacenes();	
		$this->res=$this->objFunc->eliminarSalida($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}			
} 
?>
