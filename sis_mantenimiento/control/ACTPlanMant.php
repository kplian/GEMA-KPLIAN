<?php
/**
*@package       pXP
*@file          gen-ACTPlanMant.php
*@author        (rac)
*@date          12-10-2012 16:15:31
*@description   Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RPlan_Mant.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');

class ACTPlanMant extends ACTbase{    
			
	function listarPlanMant(){
		$this->objParam->defecto('ordenacion','id_plan_mant');
		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODPlanMant','listarPlanMant');
		} else{
			$this->objFunc=$this->create('MODPlanMant');	
			$this->res=$this->objFunc->listarPlanMant();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarPlanMant(){
		$this->objFunc=$this->create('MODPlanMant');	
		if($this->objParam->insertar('id_plan_mant')){
			$this->res=$this->objFunc->insertarPlanMant();			
		} else{			
			$this->res=$this->objFunc->modificarPlanMant();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPlanMant(){
		$this->objFunc=$this->create('MODPlanMant');	
		$this->res=$this->objFunc->eliminarPlanMant();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
    function reportePlanMant(){
        $dataSource = new DataSource();
        $idPlanMant = $this->objParam->getParametro('id_plan_mant');
        $this->objParam->addParametroConsulta('id_plan_mant',$idPlanMant);
        $this->objParam->addParametroConsulta('ordenacion','id_plan_mant');
        $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
        $this->objParam->addParametroConsulta('cantidad',1000);
        $this->objParam->addParametroConsulta('puntero',0);
        $this->objFunc = $this->create('MODPlanMant');
        $resultPlanMant = $this->objFunc->reportePlanMant();                
        //var_dump($resultPlanMant);
        $datosPlanMant = $resultPlanMant->getDatos();
                
        
        //armamos el array parametros y metemos ahi los data sets de las otras tablas
        $dataSource->putParameter('localizacion', $datosPlanMant[0]['localizacion']);
        $dataSource->putParameter('nombre_sis', $datosPlanMant[0]['nombre_sis']);
        $dataSource->putParameter('nombre_sub', $datosPlanMant[0]['nombre_sub']);
        $dataSource->putParameter('tag', $datosPlanMant[0]['tag']);
        $dataSource->putParameter('preparado_por', $datosPlanMant[0]['preparado_por']);
        $dataSource->putParameter('revisado_por', $datosPlanMant[0]['revisado_por']);
		$dataSource->putParameter('fecha_emi', $datosPlanMant[0]['fecha_emision']);
        $dataSource->putParameter('fecha_rev', $datosPlanMant[0]['fecha_rev']);
		$dataSource->putParameter('descripcion', $datosPlanMant[0]['descripcion']);
		$dataSource->putParameter('codigo', 'GMAN-RG-SM-010');
		$dataSource->putParameter('revision', '1');
		$dataSource->putParameter('fecha_emision', '29/06/2012');
        if($datosPlanMant[0]['fecha_mod'] != null) {
            $dataSource->putParameter('fechaEmision', $datosPlanMant[0]['fecha_mod']);
        } else {
            $dataSource->putParameter('fechaEmision', $datosPlanMant[0]['fecha_reg']);
        }
        
        //get detalle
        //Reset all extra params:
        $this->objParam->addParametroConsulta('ordenacion', 'fun.orden,funfall.orden,mfall.orden');
        $this->objParam->defecto('cantidad', 1000);
        $this->objParam->defecto('puntero', 0);
        $this->objParam->addParametro('id_plan_mant', $idPlanMant);
        
        $modTarea = $this->create('MODTarea');
        $resultTarea = $modTarea->reporteTarea();
        $tareaDataSource = new DataSource();
        $tareaDataSource->setDataSet($resultTarea->getDatos());
        $dataSource->putParameter('tareaDataSource', $tareaDataSource);
                
        //build the report
        $reporte = new RPlan_Mant();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'PlanRCM.pdf';
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