<?php
/**
*@package   pXP
*@file      ACTAnalisisPorque.php
*@author    Gonzalo Sarmiento Sejas
*@date      28-11-2012 20:22:29
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RAnalisis_Porque.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');


class ACTAnalisisPorque extends ACTbase{    
			
	function listarAnalisisPorque(){
		$this->objParam->defecto('ordenacion','id_analisis_porque');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAnalisisPorque','listarAnalisisPorque');
		} else{
			$this->objFunc=$this->create('MODAnalisisPorque');	
			$this->res=$this->objFunc->listarAnalisisPorque();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAnalisisPorque(){
		$this->objFunc=$this->create('MODAnalisisPorque');	
		if($this->objParam->insertar('id_analisis_porque')){
			$this->res=$this->objFunc->insertarAnalisisPorque();			
		} else{			
			$this->res=$this->objFunc->modificarAnalisisPorque();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAnalisisPorque(){
		$this->objFunc=$this->create('MODAnalisisPorque');	
		$this->res=$this->objFunc->eliminarAnalisisPorque();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
    function planillaAnalisisPorque(){
        $dataSource = new DataSource();
        $idAnalisisPorque = $this->objParam->getParametro('id_analisis_porque');
        $this->objParam->addParametroConsulta('id_analisis_porque',$idAnalisisPorque);
        $this->objParam->addParametroConsulta('ordenacion','id_analisis_porque');
        $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
        $this->objParam->addParametroConsulta('cantidad',1000);
        $this->objParam->addParametroConsulta('puntero',0);
        $this->objFunc = $this->create('MODAnalisisPorque');
        $resultAnalisisPorque = $this->objFunc->listarAnalisisPorqueReporte();
        $datosAnalisisPorque = $resultAnalisisPorque->getDatos();
        
        //armamos el array parametros y metemos ahi los data sets de las otras tablas
       
        $dataSource->putParameter('codigo', $datosAnalisisPorque[0]['codigo']);
        $dataSource->putParameter('revision', $datosAnalisisPorque[0]['revision']);
        if($datosAnalisisPorque[0]['fecha_mod'] != null) {
            $dataSource->putParameter('fechaEmision', $datosAnalisisPorque[0]['fecha_mod']);
        } else {
            $dataSource->putParameter('fechaEmision', $datosAnalisisPorque[0]['fecha_reg']);
        }
        $dataSource->putParameter('numero', $datosAnalisisPorque[0]['nro_analisis']);
        $dataSource->putParameter('localizacion', $datosAnalisisPorque[0]['nombre_loc']);
        $finded = strpos($datosAnalisisPorque[0]['nombre_loc'], 'Estación');
        $dataSource->putParameter('estacion_planta', $finded===false?'Planta':'Estacion');
        $dataSource->putParameter('id_uni_cons', $datosAnalisisPorque[0]['maquina']);
        $dataSource->putParameter('tag', $datosAnalisisPorque[0]['tag']);
        $dataSource->putParameter('problema', $datosAnalisisPorque[0]['problema']);
        $dataSource->putParameter('fecha', $datosAnalisisPorque[0]['fecha']);
        $dataSource->putParameter('estado', $datosAnalisisPorque[0]['estado']);
        $operadores=explode("\n", $datosAnalisisPorque[0]['operadores']);
        $dataSource->putParameter('operador1',$operadores[0]);
        $dataSource->putParameter('operador2',$operadores[1]);
        $dataSource->putParameter('operador3',$operadores[2]);
        $dataSource->putParameter('operador4',$operadores[3]);
        $coordinadores=explode("\n", $datosAnalisisPorque[0]['coordinadores']);
        $dataSource->putParameter('coordinador1',$coordinadores[0]);
        $dataSource->putParameter('coordinador2',$coordinadores[1]);
        $dataSource->putParameter('coordinador3',$coordinadores[2]);        
        $tecnicos=explode("\n", $datosAnalisisPorque[0]['tecnicos']);
        $dataSource->putParameter('tecnico1',$tecnicos[0]);
        $dataSource->putParameter('tecnico2',$tecnicos[1]);                
                
        //get detalle
        //Reset all extra params:
        $this->objParam->defecto('ordenacion', 'id_analisis_porque_det');
        $this->objParam->defecto('cantidad', 1000);
        $this->objParam->defecto('puntero', 0);
        $this->objParam->addParametro('id_analisis_porque', $idAnalisisPorque);
        
        $modAnalisisPorqueDet = $this->create('MODAnalisisPorqueDet');
        $resultDetalle = $modAnalisisPorqueDet->listarAnalisisPorqueDet();
        $detalleDataSource = new DataSource();
        $detalleDataSource->setDataSet($resultDetalle->getDatos());
        $dataSource->putParameter('detalleDataSource', $detalleDataSource);
                
        //get solucion
        //Reset all extra params:
        $this->objParam->defecto('ordenacion', 'id_analisis_porque_sol');
        $this->objParam->defecto('cantidad', 1000);
        $this->objParam->defecto('puntero', 0);
        $this->objParam->addParametro('id_analisis_porque', $idAnalisisPorque);
        
        $modAnalisisPorqueSol = $this->create('MODAnalisisPorqueSol');
        $resultSolucion = $modAnalisisPorqueSol->reporteAnalisisPorqueSol();
        $solucionDataSource = new DataSource();
        $solucionDataSource->setDataSet($resultSolucion->getDatos());
        $dataSource->putParameter('solucionDataSource', $solucionDataSource);
        
        //build the report
        $reporte = new RAnalisisPorque();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'RegistroAnalisisPorque.pdf';
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