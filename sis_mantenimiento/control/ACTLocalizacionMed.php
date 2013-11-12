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
require_once(dirname(__FILE__).'/../reportes/RAnualMedicion_Indicadores.php');
require_once(dirname(__FILE__).'/../reportes/RGraficoIndicadores.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');
require_once(dirname(__FILE__).'/../../lib/jpgraph/src/jpgraph.php');
require_once(dirname(__FILE__).'/../../lib/jpgraph/src/jpgraph_bar.php');
require_once(dirname(__FILE__).'/../../lib/jpgraph/src/jpgraph_pie.php');
require_once(dirname(__FILE__).'/../../lib/jpgraph/src/jpgraph_pie3d.php');


class ACTLocalizacionMed extends ACTbase{
	
	private $tituloRep;
	private $tituloDet;
			
	function listarLocalizacionMed(){ 
		$this->objParam->defecto('ordenacion','fecha_med');
		$this->objParam->defecto('dir_ordenacion','asc');
		
		/*echo 'dd:'. $this->objParam->getParametro('id_localizacion');
		exit;*/
		
		/*if($this->objParam->getParametro('id_localizacion')!=''){
			$this->objParam->addParametro('id_localizacion',$id_localizacion);
		}*/
		$this->objParam->addFiltro(" (locmed.fecha_med between ''".$this->objParam->getParametro('fecha_ini')."'' and ''".$this->objParam->getParametro('fecha_fin')."'') ");
		
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
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

	function listarIndicadores($pResp=1){
		$this->objParam->defecto('ordenacion','fecha_med');
		$this->objParam->defecto('dir_ordenacion','asc');

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('MODLocalizacionMed','listarIndicadores');
		} else{
			$this->objFunc=$this->create('MODLocalizacionMed');
			$this->res=$this->objFunc->listarIndicadores();
		}

		//Respuesta del listado
		if($pResp){
			$this->res->imprimirRespuesta($this->res->generarJson());
		}
	}
    
    function reporteLocalizacionMed(){

        $mesLiteral = $this->objParam->getParametro('mes');
        $anio = $this->objParam->getParametro('anio');
        $mesNumeral = $this->getMesNumeral($mesLiteral); 
        $diasMes = $this->diasMes($mesNumeral, $anio);
		$mesLiteralAbrev = $this->getMesNumeralAbrev($mesLiteral);
		
		//echo $mesLiteral;exit;
        
        $dataSource = new DataSource();
        $this->objParam->defecto('ordenacion','fecha_med');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objParam->defecto('cantidad',1000);
        $this->objParam->defecto('puntero',0);
        $this->objParam->addParametro('fecha_ini',"01/"."$mesNumeral"."/"."$anio");
        $this->objParam->addParametro('fecha_fin',"$diasMes"."/"."$mesNumeral"."/"."$anio");
        $this->objFunc = $this->create('MODLocalizacionMed');
        $resultLocalizacionMed = $this->objFunc->reporteLocalizacionMed();
        $datosLocalizacionMed = $resultLocalizacionMed->getDatos();
        
        //armamos el array parametros y metemos ahi los data sets de las otras tablas
        $dataSource->putParameter('numDias',$diasMes);
        $dataSource->putParameter('mesLiteral',$mesLiteral);
        $dataSource->putParameter('mes',$mesNumeral);
        $dataSource->putParameter('anio',$anio);
		$dataSource->putParameter('mesLiteralAbrev',$mesLiteralAbrev);
        if($datosLocalizacionMed[0]['nombre_sistema']!=null){
            $dataSource->putParameter('sistema', $datosLocalizacionMed[0]['nombre_sistema']);      
        }else{
            $dataSource->putParameter('sistema', $this->objParam->getParametro('localizacion'));
        }
        $dataSource->putParameter('codigo', $datosLocalizacionMed[0]['codigo']);
        $dataSource->putParameter('localizacion', $datosLocalizacionMed[0]['nombre_localizacion']);
        $dataSource->putParameter('mes_literal', $datosLocalizacionMed[0]['mes_literal']);
        if($datosLocalizacionMed[0]['fecha_mod'] != null) {
            $dataSource->putParameter('fechaEmision', $datosLocalizacionMed[0]['fecha_mod']);
        } else {
            $dataSource->putParameter('fechaEmision', $datosLocalizacionMed[0]['fecha_reg']);
        }
                
        $dataSource->setDataSet($resultLocalizacionMed->getDatos());
                
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

    function reporteAnualLocalizacionMed(){
        $anio = $this->objParam->getParametro('anio');
        
        $dataSource = new DataSource();
        $this->objParam->defecto('ordenacion','mes');
        $this->objParam->defecto('dir_ordenacion','asc');
        $this->objParam->defecto('cantidad',1000);
        $this->objParam->defecto('puntero',0);
        $this->objParam->addParametro('fecha_ini',"01/01/"."$anio");
        $this->objParam->addParametro('fecha_fin',"31/12/"."$anio");
        $this->objFunc = $this->create('MODLocalizacionMed');
        $resultReporteAnual = $this->objFunc->reporteAnualLocalizacionMed();
        $datosLocalizacionMed = $resultReporteAnual->getDatos();
		/*echo '<pre>';
		var_dump($resultReporteAnual->getDatos());
		echo '</pre>';exit;*/
        
        //armamos el array parametros y metemos ahi los data sets de las otras tablas
        $dataSource->putParameter('numMeses',12);
        $dataSource->putParameter('anio',$anio);
        if($datosLocalizacionMed[0]['nombre_sistema']!=null){
            $dataSource->putParameter('sistema', $datosLocalizacionMed[0]['nombre_sistema']);      
        }else{
            $dataSource->putParameter('sistema', $this->objParam->getParametro('localizacion'));
        }
        $dataSource->putParameter('codigo', $datosLocalizacionMed[0]['codigo']);
        $dataSource->putParameter('localizacion', $datosLocalizacionMed[0]['nombre_localizacion']);
        $dataSource->setDataSet($resultReporteAnual->getDatos());
                
        //build the report
        $reporte = new RAnualMedicionIndicadores();
        $reporte->setDataSource($dataSource);
        $nombreArchivo = 'ReporteAnualMedicionIndicadores.pdf';
        $reportWriter = new ReportWriter($reporte, dirname(__FILE__).'/../../reportes_generados/'.$nombreArchivo);
        $reportWriter->writeReport(ReportWriter::PDF);
        
        $mensajeExito = new Mensaje();
        $mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado',
                                        'Se generó con éxito el reporte: '.$nombreArchivo,'control');
        $mensajeExito->setArchivoGenerado($nombreArchivo);
        $this->res = $mensajeExito;
        $this->res->imprimirRespuesta($this->res->generarJson());                
    }
    
    function diasMes($month, $year) {
        return date("d",mktime(0,0,0,$month+1,0,$year));
    }
    
    function getMesNumeral($mes){
		$meses = array('January'=>1,'February'=>2,'March'=>3,'April'=>4,'May'=>5,'June'=>6,'July'=>7,'August'=>8,'September'=>9,'October'=>10,'November'=>11,'December'=>12);
        return $meses["$mes"];
    }
	
	function getMesNumeralAbrev($mes){
		$meses = array('January'=>'Jan','February'=>'Feb','March'=>'Mar','April'=>'Apr','May'=>'May','June'=>'Jun','July'=>'Jul','August'=>'Aug','September'=>'Sep','October'=>'Oct','November'=>'Nov','December'=>'Dec');
        return $meses["$mes"];
    }

	//RCM
	//Fecha: 18/04/2013
	//Descripción: Genera gráfico de Barras de los indicadores generados en jpgraph
	private function grafIndicadores(){
		$time=getdate();
		$graphName='localizacion_med_indicadores'.$_SESSION["ss_id_usuario"].$time[0].'.jpeg';
		$rutaComp=dirname(__FILE__).'/../../reportes_generados/'.$graphName;
		$rutaCorta='/GEMA-KPLIAN/reportes_generados/'.$graphName;
		//Generación de gráfica
		$data1y=array();
		$data1yLab=array();

		$data1y[0]=$this->res->datos[0]['indicador'];
		$data1y[1]=32;
		$data1y[2]=$this->res->datos[2]['indicador'];
		$data1y[3]=69;
		
		$data1yLab[0]=$this->res->datos[0]['nombre'];
		$data1yLab[1]=$this->res->datos[1]['nombre'];
		$data1yLab[2]=$this->res->datos[2]['nombre'];
		$data1yLab[3]=$this->res->datos[3]['nombre'];
		
		$graph = new Graph(400,200,'auto');
		$graph->SetScale("textlin");
		
		$graph->yaxis->SetTickPositions(array(0,20,40,60,80,100), array(10,30,50,70,90));
		$graph->SetBox(false);
		
		$graph->ygrid->SetFill(false);
		$graph->xaxis->SetTickLabels($data1yLab);
		$graph->yaxis->HideLine(false);
		$graph->yaxis->HideTicks(false,false);
		
		$b1plot = new BarPlot($data1y);
		
		// ...and add it to the graPH
		$graph->Add($b1plot);
		
		$b1plot->SetColor("white");
		//$b1plot->SetFillGradient("#FF0000","white",GRAD_LEFT_REFLECTION);
		$b1plot->SetFillColor("#cc1111");
		$b1plot->SetWidth(35);
		
		$graph->title->Set("Indicadores");
		
		// Display the graph
		$graph->Stroke($rutaComp);
		
		//Devuelve respuesta
		return $rutaCorta;	
	}

	function graficarIndicadores(){
		/*$this->listarIndicadores(0);
		//var_dump($this->res);exit;
		//GEnera el gráfico de barras
		$arch=$this->grafIndicadores();	
		//Aumenta el nombre del archivo a la respuesta
		$datos='[{"url":"'.$arch.'","nombre":"Indicadores de Gestión","nombre_corto":"Indicadores"},{"url":"'.$arch.'","nombre":"Indicadores de Gestión","nombre_corto":"Indicadores33333"}]';
		$this->res->setClaveValorResp('total','1');
		$this->res->setClaveValorResp('images',$datos);
		//Devuelve la respuesta		
		//var_dump($this->res->toJsonClaveValor());exit;
		$this->res->imprimirRespuesta($this->res->toJsonClaveValor());*/	
	}
	
	//RCM 22-04-2013
	function datosIndicadoresGraf(){ 
		$this->objParam->defecto('ordenacion','fecha_med');
		$this->objParam->defecto('dir_ordenacion','asc');

		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam);
			$this->res = $this->objReporte->generarReporteListado('MODLocalizacionMed','datosIndicadoresGraf');
		} else{
			$this->objFunc=$this->create('MODLocalizacionMed');
			$this->res=$this->objFunc->datosIndicadoresGraf();
			//var_dump($this->res->datos);
			
			
			//try{
				//Verificacion de datos para la graficacion
				$this->verificaDatosGrafico($this->objParam->getParametro('tipo_indicador'));
				//Creación del gráfico
				$grafName=$this->graficarDatosIndicadoresGraf();
	
				//Creación del Reporte en formato PDF
				$mensajeExito=$this->generarReporteDatosIndicadoresGraf($grafName,$this->tituloRep,$this->tituloDet);
									
				//Respuesta
				$this->res = $mensajeExito;
				
			/*} catch(Exception $e){
				$mensajeExito = new Mensaje();
				$mensajeExito->setMensaje('ERROR','Reporte.php','Reporte no generado, no existen datos en el periodo seleccionado','No existen datos para el calculo y graficacion de los datos, no existen datos en el periodo seleccionado','control');
				
				//Respuesta
				$this->res = $mensajeExito;
			}*/

		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	
	
	/*
	 * Autor: RCM
	 * Fecha: 17/04/2013
	 * Descripción: Crea archivo físico del gráfico del indicador solicitado por la vista
	 */
	private function graficarDatosIndicadoresGraf(){
		$time=getdate();
		$rutaComp=dirname(__FILE__).'/../../reportes_generados/';
		$rutaCorta='/GEMA-KPLIAN/reportes_generados/';
		
		if($this->objParam->getParametro('tipo_indicador')=='costos'){
			$graphName='localizacion_med_graficos_costos'.$_SESSION["ss_id_usuario"].'_'.$time[0].'.jpeg';
			$rutaComp.=$graphName;
			$rutaCorta.=$graphName;
			
			//Generación del gráfico
			$data=array();
			$legend=array();
			foreach($this->res->datos as $item){
				$data[]=$item['total'];
				$legend[]=$item['tipo'];
			}
			
			// Create the Pie Graph. 
			$graph = new PieGraph(500,300);
			
		
			$theme_class= new VividTheme;
			$graph->SetTheme($theme_class);
		
			// Set A title for the plot
			$graph->title->Set("Costos de Mantenimiento");
			
			// Create
			$p1 = new PiePlot3D($data);
			$p1->SetLegends($legend);
			
			$graph->Add($p1);
			
			//Borde y ubicación de la leyenda
			$graph->legend->SetFrameWeight(1);
			$graph->legend->Pos(0.05,0.92);
			
			$p1->ShowBorder();
			$p1->SetColor('black');
			$p1->ExplodeSlice(1);
			$graph->Stroke($rutaComp);
			
			//Define el titulo del reporte
			$this->tituloRep='REPORTE: COSTOS DE MANTENIMIENTO';
			$this->tituloDet='Costos de Mantenimiento';
		} else if($this->objParam->getParametro('tipo_indicador')=='ejecucion'){
			
			$graphName='localizacion_med_graficos_ejecucion'.$_SESSION["ss_id_usuario"].'_'.$time[0].'.jpeg';
			$rutaComp.=$graphName;
			$rutaCorta.=$graphName; 
			
			//Gráfico
			$mayorTotalPla=0;
			$mayorTotalEje=0;
			$fil=0;
			$aTotalPla=array();
			$aTotalEje=array();
			
			
			foreach($this->res->datos as $item){
				$aTotalPla[]=intval($item['total_pla']);
				$aTotalEje[]=intval($item['total_eje']);
				$aTit[]=$item['tipo'];

				if($item['total_pla']>$mayorTotalPla){
					$mayorTotalPla=$item['total_pla'];
				}
				if($item['total_eje']>$mayorTotalEje){
					$mayorTotalEje=$item['total_eje'];
				}
				$fil++;
			}

			$graph = new Graph(500,300,'auto');
			$graph->SetScale("textlin");
			
			$theme_class=new UniversalTheme;
			$graph->SetTheme($theme_class);
			
			//Encuenta la numeración del eje y
			$limiteY=$mayorTotalPla>$mayorTotalEje?$mayorTotalPla:$mayorTotalEje;
			//echo 'lim:'.$limiteY;exit;
			$i = 2;
			while ($i < $limiteY):
			    $labelY[]=intval($i);
				$i=$i+2;
			endwhile;
			$labelY[]=intval($limiteY);
			//var_dump($labelY);

			//$graph->yaxis->SetTickPositions(array(0,2,4,6), array(1,3,5));
			$graph->yaxis->SetTickPositions($labelY);
			$graph->SetBox(false);
			
			$graph->ygrid->SetFill(false);
			$graph->xaxis->SetTickLabels($aTit);
			$graph->yaxis->HideLine(false);
			$graph->yaxis->HideTicks(false,false);
			
			// Create the bar plots
			$b1plot = new BarPlot($aTotalPla);
			$b2plot = new BarPlot($aTotalEje);
			
			// Create the grouped bar plot
			$gbplot = new GroupBarPlot(array($b1plot,$b2plot));
			$graph->Add($gbplot);
			
			$b1plot->SetColor("white");
			$b1plot->SetFillColor("#cc1111");
			
			$b2plot->SetColor("white");
			$b2plot->SetFillColor("#11cccc");
			
			$b1plot->SetLegend("Planificado");
			$b2plot->SetLegend("Ejecutado");
			
			$graph->title->Set("% Ejecución de Mantenimiento");
			
			// Display the graph
			$graph->Stroke($rutaComp);
			
			//Define el titulo del reporte
			$this->tituloRep='REPORTE: % EJECUCIÓN DE MANTENIMIENTO';
			$this->tituloDet='Ejecución de Mantenimiento';
			
		} else{
			//Por defecto es el de Tipos de Mantenimiento
			$graphName='localizacion_med_graficos_tipo_mant'.$_SESSION["ss_id_usuario"].'_'.$time[0].'.jpeg';
			$rutaComp.=$graphName;
			$rutaCorta.=$graphName; 
			
			//Generación del gráfico
			$data=array();
			$legend=array();
			
			//var_dump($this->res->datos);exit;
			foreach($this->res->datos as $item){
				$data[]=$item['total'];
				$legend[]=$item['tipo'];
			}
			
			// Create the Pie Graph. 
			$graph = new PieGraph(500,300);
			
			//Obtiene las leyendas
			//$graph->SetLegends($legend);
			
			$theme_class= new VividTheme;
			$graph->SetTheme($theme_class);
		
			// Set A title for the plot
			$graph->title->Set("Tipo de Mantenimiento");
			
			// Create
			$p1 = new PiePlot3D($data);
			$p1->SetLegends($legend);
			
			$graph->Add($p1);
			
			//Borde y ubicación de la leyenda
			$graph->legend->SetFrameWeight(1);
			$graph->legend->Pos(0.05,0.94);
			
			$p1->ShowBorder();
			$p1->SetColor('black');
			$p1->ExplodeSlice(1);
			$graph->Stroke($rutaComp);
			
			//Define el titulo del reporte
			$this->tituloRep='REPORTE: TIPO DE MANTENIMIENTO';
			$this->tituloDet='Tipo de Mantenimiento';
		}
		//Devuelve la ruta corta del gráfico generado
		return $rutaComp;
	}

	/*
	 * Autor: RCM
	 * Fecha: 24/04/2013
	 * Descripción: Genera el reporte en PDF incluyendo la gráfica del Indicador
	 */
	private function generarReporteDatosIndicadoresGraf($pNombreArchivo,$pTituloRep,$pTituloDet){
		
		$dataSource = new DataSource();
		//Datos de la cabecera		
		/*$dataSource->putParameter('localizacion', $this->objParam->getParametro('localizacion'));
		$dataSource->putParameter('equipo', $this->objParam->getParametro('equipo'));
		$dataSource->putParameter('tag', $this->objParam->getParametro('codigo_equipo'));
		$dataSource->putParameter('fecha_ini', $this->objParam->getParametro('mes_ini')||'/'||$this->objParam->getParametro('gestion_ini'));
		$dataSource->putParameter('fecha_fin', $this->objParam->getParametro('mes_fin')||'/'||$this->objParam->getParametro('gestion_fin'));*/
		//echo $this->objParam->getParametro('mes_ini');exit;
		$dataSource->putParameter('localizacion',  $this->objParam->getParametro('padre'));
		$dataSource->putParameter('equipo',  $this->objParam->getParametro('nombre'));
		$dataSource->putParameter('tag',  $this->objParam->getParametro('codigo'));
		$dataSource->putParameter('fecha_ini', $this->objParam->getParametro('mes_ini').'/'.$this->objParam->getParametro('gestion_ini'));
		$dataSource->putParameter('fecha_fin', $this->objParam->getParametro('mes_fin').'/'.$this->objParam->getParametro('gestion_fin'));
		
		//Datos del detalle
		$dataSource->putParameter('detalle', $this->res->datos);
		$dataSource->putParameter('nombre_archivo_grafico', $pNombreArchivo);
		$dataSource->putParameter('tipo_indicador', $this->objParam->getParametro('tipo_indicador'));
		$dataSource->putParameter('titulo_det', $this->tituloDet);
		$dataSource->putParameter('observaciones', $this->objParam->getParametro('observaciones'));
		
		$reporte = new RGraficoIndicadores();
		$reporte->setTitulo($pTituloRep);
		$reporte->setDataSource($dataSource);
		$nombreArchivo = 'GraficoIndicadores.pdf';
		$reportWriter = new ReportWriter($reporte, dirname(__FILE__).'/../../reportes_generados/'.$nombreArchivo);
		$reportWriter->writeReport(ReportWriter::PDF);
		
		$mensajeExito = new Mensaje();
		$mensajeExito->setMensaje('EXITO','Reporte.php','Reporte generado','Se generó con éxito el reporte: '.$nombreArchivo,'control');
		$mensajeExito->setArchivoGenerado($nombreArchivo);
		
		//Devuelve el mensaje de éxito
		return $mensajeExito;
	}

	private function verificaDatosGrafico($pTipoInd){
		if($pTipoInd=='costos'){
			//Verifica si los datos son mayores a cero
			if(count($this->res->datos)<=0){
				throw new Exception("No existen datos para graficar", 1);
			} else{
				$tot=0;
				foreach ($this->res->datos as $value) {
					$tot+=$value['total'];
				}
				if($tot<=0){
					throw new Exception("No existen datos para graficar", 1);
				}
			}	
		} else{
			//Verifica si los datos son mayores a cero
			if(count($this->res->datos)<=0){
				throw new Exception("No existen datos para graficar", 1);
			}
		}
		
		return;	
	}
}
?>

