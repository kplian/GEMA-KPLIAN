<?php
/**
*@package pXP
*@file gen-ACTCalendarioPlanificado.php
*@author  (admin)
*@date 02-11-2012 15:04:36
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RCalendario_Planificado.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');

class ACTCalendarioPlanificado extends ACTbase{    

	function listarCalendarioPlanificado(){
		$this->objParam->defecto('ordenacion','id_calendario_planificado');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){

			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarCalendarioPlanificado');
		} else{
			$this->objFunc=$this->create('MODCalendarioPlanificado');
			$this->res=$this->objFunc->listarCalendarioPlanificado($this->objParam);

		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function insertarCalendarioPlanificado(){
		$this->objFunc=$this->create('MODCalendarioPlanificado');	
		if($this->objParam->insertar('id_calendario_planificado')){
			$this->res=$this->objFunc->insertarCalendarioPlanificado();			
		} else{			
			$this->res=$this->objFunc->modificarCalendarioPlanificado();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function eliminarCalendarioPlanificado(){
		$this->objFunc=$this->create('MODCalendarioPlanificado');	
		$this->res=$this->objFunc->eliminarCalendarioPlanificado($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarMesesCalendario(){


		$this->objParam->defecto('ordenacion','id_mes');
        $this->objParam->defecto('dir_ordenacion','asc');
		$this->objFunc=$this->create('MODCalendarioPlanificado');	
		$this->res=$this->objFunc->listarMesesCalendario();


		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarMesesCalendarioDet(){


		$this->objParam->defecto('ordenacion','id_mes');
        $this->objParam->defecto('dir_ordenacion','asc');

		$this->objFunc=$this->create('MODCalendarioPlanificado');	
	    $this->res=$this->objFunc->listarMesesCalendarioDet();

		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	function listarCalendarioPlanificadoDet(){
		$this->objParam->defecto('ordenacion','nombre_uni_cons');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODCalendarioPlanificado','listarCalendarioPlanificadoDet');

		} else{
			$this->objFunc=$this->create('MODCalendarioPlanificado');	
			$this->res=$this->objFunc->listarCalendarioPlanificadoDet();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function OtenerCalPla(){
		$this->objFunc=$this->create('MODCalendarioPlanificado');	
		$this->res=$this->objFunc->OtenerCalPla();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function UpdateCalPla(){
		$this->objFunc=$this->create('MODCalendarioPlanificado');
		$this->res=$this->objFunc->UpdateCalPla();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

    function listarCalendarioPlanificadoRep(){
        $dataSource = new DataSource();
            
        $this->objParam->defecto('ordenacion','nombre_uni_cons');
        $this->objParam->defecto('dir_ordenacion','asc');

        $this->objFunc=$this->create('MODCalendarioPlanificado');   
        $this->res=$this->objFunc->listarMesesCalendarioDet();
        $primeraConsulta=$this->res->getDatos();
        
        $dataSource->putParameter('localizacion', $this->objParam->getParametro('localizacion'));
        
        $recText = 'id_sem_mes#integer@id_uni_cons#integer@id_uni_cons_mant_predef#integer@nombre_uni_cons#text@nombre_mant#varchar@codigo_man#varchar@codigo_equipo#text@frecuencia#varchar';
        
        $datos;
        for ($i=0;$i<count($primeraConsulta);$i++) { 
            $datos=$datos.'@'.$primeraConsulta[$i]['codigo'].'#varchar@cp_'.$primeraConsulta[$i]['codigo'].'#int4';            
        }
        $recText=$recText.$datos;
             
        $arrDatos['datos']=$recText;
                
        $this->objParam->addParametro('tipo_nodo',$this->objParam->getParametro('tipo_nodo'));
        $this->objParam->addParametro('start','0');
        $this->objParam->addParametro('limit','50');
        $this->objParam->addParametro('sort','nombre_uni_cons');
        $this->objParam->addParametro('dir','ASC');
        
        $this->objParam->addParametro('datos',$recText);
        $this->objParam->addParametroConsulta('cantidad','50');
        $this->objParam->addParametroConsulta('puntero','0');
        
        $this->objFunc=$this->create('MODCalendarioPlanificado');
        $this->res=$this->objFunc->listarCalendarioPlanificadoDet();
        
        $dataSource->setDataSet($this->res->getDatos());
                       
        //build the report
        $reporte = new RCalendarioPlanificado();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'ReporteCalendarioPlanificado.pdf';
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