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
		
		if($this->objParam->getParametro('estado')!=''){
			if($this->objParam->getParametro('estado')=='solicitud'){
				$this->objParam->addFiltro("solord.estado in (''borrador'',''pendiente'',''finalizado'',''no_aprobado'')");
			} else if($this->objParam->getParametro('estado')=='finalizacion'){
				$this->objParam->addFiltro("solord.estado in (''pendiente'',''finalizado'',''no_aprobado'')");
			} else if($this->objParam->getParametro('estado')=='finalizado'){
				$this->objParam->addFiltro("solord.estado = ''finalizado''  ");
			} 
				
		}
		
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
		//var_dump($this->res->getDatos());exit;
		
		//Insumos
		$this->objParam->addParametroConsulta('filtro', 'otsoin.id_orden_trabajo_sol = '.$this->objParam->getParametro('id_orden_trabajo_sol'));
		$this->objParam->addParametroConsulta('ordenacion', 'otsoin.id_orden_trabajo_sol_insumo');
		$modInsum = $this->create('MODOrdenTrabajoSolInsumo');
		$resultInsum = $modInsum->listarOrdenTrabajoSolInsumo();
		$insumDataSource = new DataSource();
		$insumDataSource->setDataset($resultInsum->getDatos());
		$dataSource->putParameter('insumDataSource', $insumDataSource);
		
		//Imagen de la Solicitud de OIT
		$this->objParam->addParametroConsulta('cantidad', 1);
		$this->objParam->addParametroConsulta('puntero', 0);
		$this->objParam->addParametroConsulta('ordenacion', 'id_orden_trabajo_sol');
		$this->objParam->addParametroConsulta('dir_ordenacion', 'asc');
		$this->objParam->addParametroConsulta('filtro', " solord.extension in (''bmp'',''jpg'',''gif'',''png'',''jpeg'')");
		$this->objParam->addParametro('id_orden_trabajo_sol', $this->objParam->getParametro('id_orden_trabajo_sol'));
		$this->objFunc = $this->create('MODOrdenTrabajoSol');
		$resultArchivo = $this->objFunc->listarOrdenTrabajoSolArchivo();
		
		$imagenData = $resultArchivo->getDatos();
		if(count($imagenData) > 0) {
			$dataSource->putParameter('imagePath', '../../../archivos_uni_cons/'.$imagenData[0]['id_orden_trabajo_sol'].'.'.$imagenData[0]['extension']);
		}
		
		//var_dump($imagenData);exit;
		        
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

	function subirArchivo(){
        $this->objFunc=$this->create('MODOrdenTrabajoSol');
        $this->res=$this->objFunc->subirArchivo();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
			
}

?>