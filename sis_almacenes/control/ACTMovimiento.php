<?php
/**
 * @Package pxP
 * @file 	ACTMovimiento.php
 * @author 	Gonzalo Sarmiento
 * @date 	02-10-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */
 
 class ACTMovimiento extends ACTbase{    
			
	function listarMovimiento(){
		$this->objParam->defecto('ordenacion','fecha_mov');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesAlmacenes','listarMovimiento');
		} else{
			$this->objFunc=new FuncionesAlmacenes();	
			$this->res=$this->objFunc->listarMovimiento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarMovimiento(){
		$this->objFunc=new FuncionesAlmacenes();	
		if($this->objParam->insertar('id_movimiento')){
			$this->res=$this->objFunc->insertarMovimiento($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarMovimiento($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarMovimiento(){
		$this->objFunc=new FuncionesAlmacenes();	
		$this->res=$this->objFunc->eliminarMovimiento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function finalizarMovimiento(){
		$this->objFunc= new FuncionesAlmacenes();
		$this->res= $this->objFunc->finalizarMovimiento($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}			
} 
?>
