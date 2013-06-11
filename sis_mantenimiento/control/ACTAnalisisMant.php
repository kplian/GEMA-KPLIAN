<?php
/**
*@package pXP
*@file gen-ACTAnalisisMant.php
*@author  (admin)
*@date 30-09-2012 21:44:06
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RAnalisis_Mant.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');

class ACTAnalisisMant extends ACTbase{    
			
	function listarAnalisisMant(){
		$this->objParam->defecto('ordenacion','id_analisis_mant');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAnalisisMant','listarAnalisisMant');
		} else{
			$this->objFunc=$this->create('MODAnalisisMant');	
			$this->res=$this->objFunc->listarAnalisisMant();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAnalisisMant(){
		$this->objFunc=$this->create('MODAnalisisMant');	
		if($this->objParam->insertar('id_analisis_mant')){
			$this->res=$this->objFunc->insertarAnalisisMant();			
		} else{			
			$this->res=$this->objFunc->modificarAnalisisMant();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAnalisisMant(){
		$this->objFunc=$this->create('MODAnalisisMant');	
		$this->res=$this->objFunc->eliminarAnalisisMant();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}    

    function reporteAnalisisMant(){
        $dataSource = new DataSource();
        $idAnalisisMant = $this->objParam->getParametro('id_analisis_mant');
        $this->objParam->addParametroConsulta('id_analisis_mant',$idAnalisisMant);
        $this->objParam->addParametroConsulta('ordenacion','id_analisis_mant');
        $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
        $this->objParam->addParametroConsulta('cantidad',1000);
        $this->objParam->addParametroConsulta('puntero',0);
        $this->objFunc = $this->create('MODAnalisisMant');        
        $resultAnalisisMant = $this->objFunc->reporteAnalisisMant();
        $datosAnalisisMant = $resultAnalisisMant->getDatos();
		//var_dump($datosAnalisisMant);exit;
        //armamos el array parametros y metemos ahi los data sets de las otras tablas
        
        $dataSource->putParameter('revision', $datosAnalisisMant[0]['revision']);
        $dataSource->putParameter('id_uni_cons', $datosAnalisisMant[0]['id_uni_cons']);
        $dataSource->putParameter('localizacion',$datosAnalisisMant[0]['localizacion']);
        $dataSource->putParameter('tag',$datosAnalisisMant[0]['tag']);
        $dataSource->putParameter('nombre_sis', $datosAnalisisMant[0]['nombre_sis']);
        $dataSource->putParameter('nombre_sub', $datosAnalisisMant[0]['nombre_sub']);
        $dataSource->putParameter('preparado_por', $datosAnalisisMant[0]['preparado_por']);
        $dataSource->putParameter('revisado_por', $datosAnalisisMant[0]['revisado_por']);
        $dataSource->putParameter('fecha_emision', $datosAnalisisMant[0]['fecha_emision']);
        $dataSource->putParameter('fecha_rev', $datosAnalisisMant[0]['fecha_rev']);
        $dataSource->putParameter('descripcion', $datosAnalisisMant[0]['descripcion']);
        
        //get funcion_analisis
        //Reset all extra params:
        $this->objParam->addParametroConsulta('id_analisis_mant', $idAnalisisMant);
        $this->objParam->addParametroConsulta('ordenacion', 'fun.orden, ffall.orden, mfall.orden');
        $this->objParam->addParametroConsulta('cantidad', 1000);
        $this->objParam->addParametroConsulta('puntero', 0);
		$this->objParam->addParametro('id_analisis_mant', $idAnalisisMant);
        
                
        $modFuncion = $this->create('MODFuncion');
        $resultFuncion = $modFuncion->listarReporteAnalisisRCM();        
        $datosResultFuncion = $resultFuncion->getDatos();
		//var_dump($datosResultFuncion);exit;
        
        /*for ($i=0; $i <count($datosResultFuncion) ; $i++) {             
        
            $idFuncion = $datosResultFuncion[$i]['id_funcion'];
            
            $this->objParam->addParametroConsulta('ordenacion', 'id_funcion_falla');
            $this->objParam->addParametroConsulta('cantidad', 1000);
            $this->objParam->addParametroConsulta('puntero', 0);
            $this->objParam->addParametro('id_funcion', $idFuncion);
                    
            $modFuncionFalla = $this->create('MODFuncionFalla');
            $resultFuncionFalla = $modFuncionFalla->listarFuncionFalla(); 
            
            $datosResultFuncionFalla=$resultFuncionFalla->getDatos();
			//var_dump($datosResultFuncionFalla);exit;
            for ($j=0; $j < count($datosResultFuncionFalla) ; $j++) {
                                 
                $idFuncionFalla = $datosResultFuncionFalla[$j]['id_funcion_falla'];
            
                $this->objParam->addParametroConsulta('ordenacion', 'id_modo_falla');
                $this->objParam->addParametroConsulta('cantidad', 1000);
                $this->objParam->addParametroConsulta('puntero', 0);
                $this->objParam->addParametro('id_funcion_falla', $idFuncionFalla);
                $modModoFalla = $this->create('MODModoFalla');
                $resultModoFalla = $modModoFalla->listarModoFallaFuncion();
                        
                $modoFallaDataSource = new DataSource();
                $modoFallaDataSource->setDataSet($resultModoFalla->getDatos());
                
                $datosResultFuncionFalla[$j]['dataset']=$modoFallaDataSource;
            }
            $resultFuncionFalla->setDatos($datosResultFuncionFalla);
            
            $funcionFallaDataSource = new DataSource();
            $funcionFallaDataSource->setDataSet($resultFuncionFalla->getDatos());
                
            $datosResultFuncion[$i]['dataset']=$funcionFallaDataSource;
                           
        }*/
        $resultFuncion->setDatos($datosResultFuncion);
       
        $funcionDataSource = new DataSource();        
        $funcionDataSource->setDataSet($resultFuncion->getDatos());
        $dataSource->putParameter('funcionDataSource', $funcionDataSource);
        
        //build the report
        $reporte = new RAnalisisMant();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'ReporteAnaMant.pdf';
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