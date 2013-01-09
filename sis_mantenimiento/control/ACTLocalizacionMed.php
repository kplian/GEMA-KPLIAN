<?php
/**
*@package pXP
*@file gen-ACTLocalizacionMed.php
*@author  (admin)
*@date 07-12-2012 14:20:30
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RMedicion_Indicadores.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');


class ACTLocalizacionMed extends ACTbase{    
			
	function listarLocalizacionMed(){
		$this->objParam->defecto('ordenacion','fecha_med');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		/*echo 'dd:'. $this->objParam->getParametro('id_localizacion');
		exit;*/
		
		/*if($this->objParam->getParametro('id_localizacion')!=''){
			$this->objParam->addParametro('id_localizacion',$id_localizacion);
		}*/
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('MODLocalizacionMed','listarLocalizacionMed');
		} else{
			$this->objFunc=$this->create('MODLocalizacionMed');
			$this->res=$this->objFunc->listarLocalizacionMed();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarLocalizacionMed(){
		$this->objFunc=$this->create('MODLocalizacionMed');	
		if($this->objParam->insertar('id_localizacion_med')){
			$this->res=$this->objFunc->insertarLocalizacionMed();			
		} else{			
			$this->res=$this->objFunc->modificarLocalizacionMed();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLocalizacionMed(){
		$this->objFunc=$this->create('MODLocalizacionMed');	
		$this->res=$this->objFunc->eliminarLocalizacionMed();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function listarIndicadores(){
		$this->objParam->defecto('ordenacion','fecha_med');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		/*echo 'sd:'. $this->objParam->getParametro('id_localizacion');
		exit;*/
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('MODLocalizacionMed','listarIndicadores');
		} else{
			$this->objFunc=$this->create('MODLocalizacionMed');
			$this->res=$this->objFunc->listarIndicadores();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
    function reporteLocalizacionMed(){
        $dataSource = new DataSource();
        $this->objParam->defecto('ordenacion','fecha_med');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objParam->defecto('cantidad',1000);
        $this->objParam->defecto('puntero',0);
        $this->objFunc = $this->create('MODLocalizacionMed');
        $resultLocalizacionMed = $this->objFunc->reporteLocalizacionMed();
        $datosLocalizacionMed = $resultLocalizacionMed->getDatos();
        
        //var_dump($resultLocalizacionMed);        
        //armamos el array parametros y metemos ahi los data sets de las otras tablas
        $fecha=explode('/',$this->objParam->getParametro('fecha_ini'));
        $dataSource->putParameter('mes',$fecha[1]);
        $dataSource->putParameter('anio',$fecha[2]);
        if($datosLocalizacionMed[0]['nombre_sistema']!=null){
            $dataSource->putParameter('sistema', $datosLocalizacionMed[0]['nombre_sistema']);      
        }else{
            $dataSource->putParameter('sistema', $this->objParam->getParametro('localizacion'));
        }
        $dataSource->putParameter('codigo', $datosLocalizacionMed[0]['codigo']);
        $dataSource->putParameter('localizacion', $datosLocalizacionMed[0]['nombre_localizacion']);
        //$dataSource->putParameter('sistema', $datosLocalizacionMed[0]['nombre_sistema']);
        $dataSource->putParameter('mes_literal', $datosLocalizacionMed[0]['mes_literal']);
        //$dataSource->putParameter('mes', $datosLocalizacionMed[0]['mes']);
        //$dataSource->putParameter('anio', $datosLocalizacionMed[0]['anio']);
        if($datosLocalizacionMed[0]['fecha_mod'] != null) {
            $dataSource->putParameter('fechaEmision', $datosLocalizacionMed[0]['fecha_mod']);
        } else {
            $dataSource->putParameter('fechaEmision', $datosLocalizacionMed[0]['fecha_reg']);
        }
                
        $dataSource->setDataSet($resultLocalizacionMed->getDatos());
        
        //var_dump($dataSource);
                
        //build the report
        $reporte = new RMedicionIndicadores();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'ReporteMedicionIndicadores.pdf';
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