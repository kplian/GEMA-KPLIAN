<?php
/**
*@package pXP
*@file gen-ACTOrdenTrabajoSol.php
*@author  (admin)
*@date 02-01-2013 15:59:36
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/ROrdenTrabajo_Solicitado.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');

class ACTOrdenTrabajoSol extends ACTbase{    
			
	function listarOrdenTrabajoSol(){
		$this->objParam->defecto('ordenacion','id_orden_trabajo_sol');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODOrdenTrabajoSol','listarOrdenTrabajoSol');
		} else{
			$this->objFunc=$this->create('MODOrdenTrabajoSol');
			$this->res=$this->objFunc->listarOrdenTrabajoSol($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarOrdenTrabajoSol(){
		$this->objFunc=$this->create('MODOrdenTrabajoSol');
		//var_dump($this->objParam);
		if($this->objParam->insertar('id_orden_trabajo_sol')){
			$this->res=$this->objFunc->insertarOrdenTrabajoSol($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarOrdenTrabajoSol($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarOrdenTrabajoSol(){
		$this->objFunc=$this->create('MODOrdenTrabajoSol');	
		$this->res=$this->objFunc->eliminarOrdenTrabajoSol($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function finalizarOrdenTrabajoSol(){
		$this->objFunc=$this->create('MODOrdenTrabajoSol');	
		$this->res=$this->objFunc->finalizarOrdenTrabajoSol($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

    function reporteOTSolicitado(){
        $dataSource = new DataSource();
        $this->objParam->defecto('ordenacion','id_orden_trabajo_sol');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objParam->defecto('puntero','0');
        $this->objParam->defecto('cantidad','1000');
        $this->objFunc=$this->create('MODOrdenTrabajoSol');
        $this->res=$this->objFunc->listarOrdenTrabajoRep($this->objParam);
        $dataSource->setDataSet($this->res->getDatos());
		
		//Insumos
		$this->objParam->addParametroConsulta('filtro', 'otsoin.id_orden_trabajo_sol = '.$this->objParam->getParametro('id_orden_trabajo_sol'));
		$this->objParam->addParametroConsulta('ordenacion', 'otsoin.id_orden_trabajo_sol_insumo');
		$modInsum = $this->create('MODOrdenTrabajoSolInsumo');
		$resultInsum = $modInsum->listarOrdenTrabajoSolInsumo();
		$insumDataSource = new DataSource();
		$insumDataSource->setDataset($resultInsum->getDatos());
		$dataSource->putParameter('insumDataSource', $insumDataSource);
		//
		
		//var_dump($dataSource);exit;
		        
        $reporte = new ROrdenTrabajoSolicitado();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'ReporteOrdenTrabajoSolicitado.pdf';
        $reportWriter = new ReportWriter($reporte, dirname(__FILE__).'/../../reportes_generados/'.$nombreArchivo);
		$reportWriter->writeReport(ReportWriter::PDF);
        
        $mensajeExito = new Mensaje();
        $mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
                                        'Se generó con éxito el reporte: '.$nombreArchivo,'control');
        $mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->res = $mensajeExito;
        $this->res->imprimirRespuesta($this->res->generarJson());        
    }
			
}

?>