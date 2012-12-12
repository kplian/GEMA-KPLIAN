<?php
/**
*@package pXP
*@file gen-ACTPresupuesto.php
*@author  Gonzalo Sarmiento Sejas
*@date 26-11-2012 21:35:35
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
require_once(dirname(__FILE__).'/../../sis_mantenimiento/reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../../sis_mantenimiento/reportes/RPresupuesto.php');
require_once(dirname(__FILE__).'/../../sis_mantenimiento/reportes/pxpReport/DataSource.php');

class ACTPresupuesto extends ACTbase{    
			
	function listarPresupuesto(){
		$this->objParam->defecto('ordenacion','id_presupuesto');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODPresupuesto','listarPresupuesto');
		} else{
			$this->objFunc=$this->create('MODPresupuesto');	
			$this->res=$this->objFunc->listarPresupuesto();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPresupuesto(){
		$this->objFunc=$this->create('MODPresupuesto');	
		if($this->objParam->insertar('id_presupuesto')){
			$this->res=$this->objFunc->insertarPresupuesto();			
		} else{			
			$this->res=$this->objFunc->modificarPresupuesto();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPresupuesto(){
		$this->objFunc=$this->create('MODPresupuesto');	
		$this->res=$this->objFunc->eliminarPresupuesto();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
    function reportePresupuesto(){
        $dataSource = new DataSource();
        $idPresupuesto = $this->objParam->getParametro('id_presupuesto');
        $this->objParam->addParametroConsulta('id_presupuesto',$idPresupuesto);
        $this->objParam->addParametroConsulta('ordenacion','id_presupuesto');
        $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
        $this->objParam->addParametroConsulta('cantidad',1000);
        $this->objParam->addParametroConsulta('puntero',0);
        $this->objFunc = $this->create('MODPresupuesto');
        $resultPresupuesto = $this->objFunc->reportePresupuesto();
        $datosPresupuesto = $resultPresupuesto->getDatos();
        
        $dataSource->putParameter('moneda', $datosPresupuesto[0]['moneda']);
        
        $presupuestoDataSource = new DataSource();
        $presupuestoDataSource->setDataSet($resultPresupuesto->getDatos());
        $dataSource->putParameter('presupuestoDataSource', $presupuestoDataSource);
        
        //build the report
        $reporte = new RPresupuesto();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'ReportePresupuesto.pdf';
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