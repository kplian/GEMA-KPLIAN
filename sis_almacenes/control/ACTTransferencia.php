<?php
/**
 * @Package pxP
 * @file 	ACTTransferencia.php
 * @author 	Gonzalo Sarmiento
 * @date 	24-09-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */
 
 class ACTTransferencia extends ACTbase{    
			
	function listarTransferencia(){
		$this->objParam->defecto('ordenacion','fecha_mov');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('FuncionesAlmacenes','listarTransferencia');
		} else{
			$this->objFunc=new FuncionesAlmacenes();	
			$this->res=$this->objFunc->listarTransferencia($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTransferencia(){
		$this->objFunc=new FuncionesAlmacenes();	
		if($this->objParam->insertar('id_movimiento')){
			$this->res=$this->objFunc->insertarTransferencia($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarTransferencia($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTransferencia(){
		$this->objFunc=new FuncionesAlmacenes();	
		$this->res=$this->objFunc->eliminarTransferencia($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}			
} 
?>
