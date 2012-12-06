<?php
/**
*@package   pXP
*@file      ACTTpmTarjeta.php
*@author    Gonzalo Sarmiento Sejas
*@date 29-11-2012 02:21:39
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RTpm_Tarjeta.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');

class ACTTpmTarjeta extends ACTbase{    
			
	function listarTpmTarjeta(){
		$this->objParam->defecto('ordenacion','id_tpm_tarjeta');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODTpmTarjeta','listarTpmTarjeta');
		} else{
			$this->objFunc=$this->create('MODTpmTarjeta');	
			$this->res=$this->objFunc->listarTpmTarjeta();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarTpmTarjeta(){
		$this->objFunc=$this->create('MODTpmTarjeta');	
		if($this->objParam->insertar('id_tpm_tarjeta')){
			$this->res=$this->objFunc->insertarTpmTarjeta();			
		} else{			
			$this->res=$this->objFunc->modificarTpmTarjeta();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarTpmTarjeta(){
		$this->objFunc=$this->create('MODTpmTarjeta');	
		$this->res=$this->objFunc->eliminarTpmTarjeta();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
    function planillaTpmTarjeta(){
        $dataSource = new DataSource();
        $idTpmTarjeta = $this->objParam->getParametro('id_tpm_tarjeta');
        $this->objParam->addParametroConsulta('id_tpm_tarjeta',$idTpmTarjeta);
        $this->objParam->addParametroConsulta('ordenacion','id_tpm_tarjeta');
        $this->objParam->addParametroConsulta('dir_ordenacion','ASC');
        $this->objParam->addParametroConsulta('cantidad',1000);
        $this->objParam->addParametroConsulta('puntero',0);
        $this->objFunc = $this->create('MODTpmTarjeta');
        $resultTpmTarjeta = $this->objFunc->listarTpmTarjetaReporte();
        $datosTpmTarjeta = $resultTpmTarjeta->getDatos();
        //armamos el array parametros y metemos ahi los data sets de las otras tablas
        
        $dataSource->putParameter('codigo', $datosTpmTarjeta[0]['codigo']);
        $dataSource->putParameter('tipo', $datosTpmTarjeta[0]['tipo']);
        $dataSource->putParameter('revision', $datosTpmTarjeta[0]['revision']);
        $dataSource->putParameter('localizacion', $datosTpmTarjeta[0]['localizacion']);
        if($datosTpmTarjeta[0]['fecha_mod'] != null) {
            $dataSource->putParameter('fechaEmision', $datosTpmTarjeta[0]['fecha_mod']);
        } else {
            $dataSource->putParameter('fechaEmision', $datosTpmTarjeta[0]['fecha_reg']);
        }
        
        //get detalle
        //Reset all extra params:
        $this->objParam->defecto('ordenacion', 'id_tpm_tarjeta_det');
        $this->objParam->defecto('cantidad', 1000);
        $this->objParam->defecto('puntero', 0);
        $this->objParam->addParametro('id_tpm_tarjeta', $idTpmTarjeta);
        
        $modTpmTarjetaDet = $this->create('MODTpmTarjetaDet');
        $resultDetalle = $modTpmTarjetaDet->listarTpmTarjetaDet();
        $detalleDataSource = new DataSource();
        $detalleDataSource->setDataSet($resultDetalle->getDatos());
        $dataSource->putParameter('detalleDataSource', $detalleDataSource);
                
        //build the report
        $reporte = new RTpm_Tarjeta();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'PlanillaControl_TpmTarjeta.pdf';
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