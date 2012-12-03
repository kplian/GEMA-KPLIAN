<?php
/**
*@package pXP
*@file gen-ACTUniCons.php
*@author  (rac)
*@date 09-08-2012 00:42:57
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/
require_once(dirname(__FILE__).'/../reportes/pxpReport/ReportWriter.php');
require_once(dirname(__FILE__).'/../reportes/RUniCons_FichaTecnica.php');
require_once(dirname(__FILE__).'/../reportes/pxpReport/DataSource.php');

class ACTUniCons extends ACTbase{
	
	function listarUniCons(){
		

		//crea el objetoFunSeguridad que contiene todos los metodos del sistema de seguridad
		//$this->objFunSeguridad=$this->create('MODUniCons');
		
		//obtiene el parametro nodo enviado por la vista
		$node=$this->objParam->getParametro('node');
		$id_uni_cons=$this->objParam->getParametro('id_uni_cons');
		
		if($node=='id'){
				$this->objParam->addParametro('id_padre','%');
			}
			else {
				$this->objParam->addParametro('id_padre',$id_uni_cons);
			}
		
		if($this->objParam->getParametro('filtro')=='activo' && $node=='id')
		{
				////////////////////
				
				$count=0;
				$pri=1;
		        $json='';
		
				$count_temporal =0;
		        //$criterio_filtro = $this->objParam->getParametro('valor_filtro');
				
				if($node=='id'){
				   $this->objParam->addParametro('id_padre','%');
				}
				else {
					$this->objParam->addParametro('id_padre',$id_uni_cons);
				}
			$this->objFunSeguridad=$this->create('MODUniCons');
			$this->res=$this->objFunSeguridad->listarUniConsFiltro($this->objParam);
				 
			if($this->res)
				{
					foreach ($this->res->datos as $f)
					{
						//var_dump($f);
						if($pri==1){
		
							//guardo el nivel
							$niveles[$count]=$f["niveles"];
							//suponemos que el nivel inicial no tiene hijos
							$hijos[$count]=0;
							$pri=0;
							//prepara nodo
							$json= '[{';
							$json=$json.$this->asignar($json,$f);
						}
						else{
							//este nodo es hijo del anterior nodo??
							//$posicion = strpos($f["niveles"],$niveles[$count].'_');
							$posicion = strpos($f["niveles"],$niveles[$count]);
							//var_dump($posicion);
							//var_dump($f["niveles"]);
							if($posicion !== false ){
		
								//echo "ENTRA";
								//var_dump($posicion);
		
								//pregunta mos si este el primer hijo del nivel padre
								if($hijos[$count]==0){
		
		
									//si es el primero iniciamos las llaves
									$json =$json.',children:[{' ;
								}
								else {
									//si no es el primero cerramos el hijo anterior y preparamos sllavez para el siguiente
									$json =$json.'},{' ;
								}
								//llenamos el nodo
								$json=$json.$this->asignar($json,$f);
		
		
								//si el primer hijo incrementamos el nivel
								if($hijos[$count]==0){
									//se incrementa el nivel
									$count++;
									//suponemos que este nuevo nivel no tiene hijos
									$hijos[$count]=0;
								}
								//se incrementa un hijo en el anterior nivel
								$hijos[$count-1]++;
								//almacena el identificador del actual nivel
								$niveles[$count]=$f["niveles"];
							}
							else{
								//si el nodo no es hijo del anterio nivel
								//buscamos mas arriba hasta encontrar un padre o la raiz
								//en el camino vamos cerrando llavez
								$sw_tmp=0; // sw temporal
								$count_temporal =0;
								while ($sw_tmp==0){
		
									$hijos[$count]=0;
									$count--;
		
									$count_temporal++;
									if($count_temporal==1){
		
										//$json =$json.' * ('.$count.')';
		
									}
									else{
										$json =$json.'}]';
									}
		
									//$posicion = strpos($f["niveles"],$niveles[$count].'_');
									$posicion = strpos($f["niveles"],$niveles[$count]);
									if ($posicion !== false){
		
										$sw_tmp =1;
									}
									else {
		
										//si revisamos el ultimo nivel
										if($count<=-1){
											$sw_tmp =1;
										}
									}
								}
								$json = $json.'},{';
								$json =$json.$this->asignar($json,$f);
		
								//se incrementa un hijo en el anterior nivel
								$hijos[$count]++;
								//almacena el identificador del actual nivel
								$count ++;
								$niveles[$count]=$f["niveles"];
		
							}
						}
					}
		
					while ($count>0){
		
						$count--;
						$json =$json.'}]';
		
		
					}
					if($pri==0){
						$json =$json.'}]';
					}
					else{
						$json =$json.'[]';
		
					}
		           header("Content-Type:text/json; charset=".$_SESSION["CODIFICACION_HEADER"]);
					//echo utf8_encode
					echo($json);
					exit;
		
				}
						
				
				
				/////////////////////////
			}
            else {
			
			
			$this->objFunSeguridad=$this->create('MODUniCons');
			$this->res=$this->objFunSeguridad->listarUniCons($this->objParam);
			
			$this->res->setTipoRespuestaArbol();
			
			$arreglo=array();
			//array_push($arreglo,array('nombre'=>'id','valor'=>'id_gui'));
			
			array_push($arreglo,array('nombre'=>'id','valor'=>'id_uni_cons'));
			array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_unic_cons_padre'));
		   // array_push($arreglo,array('nombre'=>'text','valor'=>'text'));
			
					
			
		/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
			  es importante que entre los resultados devueltos por la base exista la variable\
			  tipo_dato que tenga el valor en texto = 'carpeta' */
			
			$this->res->addNivelArbol('tipo_nodo','base',array('leaf'=>false,
															'allowDelete'=>true,
															'allowEdit'=>true,
			 												'cls'=>'folder'),
			 												$arreglo);
															
	   													
	      
	      
	      $this->res->addNivelArbol('tipo_nodo','raiz_borrador',array('leaf'=>false,
															'allowDelete'=>true,
															'allowEdit'=>true,
															'icon'=>'../../../lib/imagenes/otros/tuc_edit.png'),
			 												$arreglo);
															
		  $this->res->addNivelArbol('tipo_nodo','raiz_aprobado',array('leaf'=>false,
															'allowDelete'=>true,
															'allowEdit'=>true,
			 												'icon'=>'../../../lib/imagenes/otros/tuc.png'),
			 												$arreglo);													
			 
			 
		$this->res->addNivelArbol('tipo_nodo','raiz_registrado',array('leaf'=>false,
															'allowDelete'=>true,
															'allowEdit'=>true,
			 												'icon'=>'../../../lib/imagenes/otros/tuc.png'),
			 												$arreglo);
			
			array_push($arreglo,array('nombre'=>'cls','valor'=>'descripcion'));
			/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
			  es importante que entre los resultados devueltos por la base exista la variable\
			  tipo_dato que tenga el valor en texto = 'hoja' */
			 														
	
			 $this->res->addNivelArbol('tipo_nodo','rama',array(
															'leaf'=>false,
															'allowDelete'=>true,
															'allowEdit'=>true,
			 												'icon'=>'../../../lib/imagenes/a_form.png'),
			 												$arreglo);
			 												
					//Se imprime el arbol en formato JSON
			$this->res->imprimirRespuesta($this->res->generarJson());
			
			}
	


	}
	    
	/*
	 * Author: RCM
	 * Date: 30/08/2012
	 * Description: Query that returns only the Equipments roots
	 */		
	function listarUniConsPlano(){
		$this->objParam->defecto('ordenacion','id_uni_cons');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODUniCons','listarUniConsPlano');
		} else{
			$this->objFunc=$this->create('MODUniCons');	
			$this->res=$this->objFunc->listarUniConsPlano();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	/*Fin RCM*/
	
	function listarUniConsHijo(){
        $this->objParam->defecto('ordenacion','id_uni_cons');

        $this->objParam->defecto('dir_ordenacion','asc');

        $this->objFunc=$this->create('MODUniCons');    
        $this->res=$this->objFunc->listarUniConsHijo();

        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function listarUniConsLocalizacion(){
        $this->objParam->defecto('ordenacion','id_uni_cons');
        
        $this->objParam->defecto('dir_ordenacion','asc');
        
        $this->objFunc= $this->create('MODUniCons');
        $this->res=$this->objFunc->listarUniConsLocalizacion();
        
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
				
	function insertarUniCons(){
		$this->objFunc=$this->create('MODUniCons');	
		if($this->objParam->insertar('id_uni_cons')){
			$this->res=$this->objFunc->insertarUniCons();			
		} else{			
			$this->res=$this->objFunc->modificarUniCons();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

/*
	 * Author: RAC
	 * Date: 30/08/2012
	 * Description: Generate "Unididad Contructiva" from template  */
	 	
	function addUniCons(){
		$this->objFunc=$this->create('MODUniCons');	
		
		$this->res=$this->objFunc->addUniCons();			
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	/*
	 * Author: RAC
	 * Date: 19/11/2012
	 * Description: modifica inclusion en el calendario da la unidad constructiva  */
	function modificarInclucionGeneracionCalendarioUniCons(){
		$this->objFunc=$this->create('MODUniCons');
		$this->res=$this->objFunc->modificarInclucionGeneracionCalendarioUniCons();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function GenerarCalendarioConfirmado(){
		$this->objFunc=$this->create('MODUniCons');	
		$this->res=$this->objFunc->GenerarCalendarioConfirmado();			
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
		

    function GenerarCalendario(){
		$this->objFunc=$this->create('MODUniCons');	
		$this->res=$this->objFunc->GenerarCalendario();			
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
		  
	function eliminarUniCons(){
		$this->objFunc=$this->create('MODUniCons');
		$this->res=$this->objFunc->eliminarUniCons();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function setBlockUnblockUniCons(){
		$this->objFunc=$this->create('MODUniCons');
		$this->res=$this->objFunc->setBlockUnblockUniCons();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function reporteUniConsFichaTecnica() {
		
		$dataSource = new DataSource();
		$idUniCons = $this->objParam->getParametro('id_uni_cons');
		$this->objFunc = $this->create('MODUniCons');
		$resultUniCons = $this->objFunc->obtenerUniCons($this->objParam);
		$datosUniCons = $resultUniCons->getDatos();
		//armamos el array parametros y metemos ahi los data sets de las otras tablas
		$dataSource->putParameter('nombre', $datosUniCons[0]['nombre']);
		$dataSource->putParameter('codigo', $datosUniCons[0]['codigo']);
		$dataSource->putParameter('localizacion', $datosUniCons[0]['nombre_localizacion']);
		if($datosUniCons[0]['fecha_mod'] != null) {
			$dataSource->putParameter('fechaEmision', $datosUniCons[0]['fecha_mod']);
		} else {
			$dataSource->putParameter('fechaEmision', $datosUniCons[0]['fecha_reg']);
		}
		
		//get detalle
		$resultDetalle = $this->objFunc->listarUniConsDetalle($this->objParam);
		$dataSource->setDataset($resultDetalle->getDatos());
		
		//get Raiz
		$datosRaiz = array();
		if($datosUniCons[0]['id_uni_cons_padre'] != null) {
			$this->objParam->addParametro('id_uni_cons', $datosUniCons[0]['id_uni_cons_padre']);
			$resultRaiz = $this->objFunc->obtenerUniCons($this->objParam);
			$datosRaiz = $resultRaiz->getDatos();
		}
		$dataSource->putParameter('punto', $datosRaiz[0]['nombre']);
		
		//get repuestos
		//Reset all extra params:
		$this->objParam->defecto('ordenacion', 'id_uni_cons_item');
		$this->objParam->defecto('cantidad', 1000);
		$this->objParam->defecto('puntero', 0);
		$this->objParam->addParametro('id_uni_cons', $idUniCons);
		
		$modUniConsItem = $this->create('MODUniConsItem');
		$resultRepuestos = $modUniConsItem->listarUniConsItem($this->objParam);
		
		$repuestoDataSource = new DataSource();
		$repuestoDataSource->setDataSet($resultRepuestos->getDatos());
		$dataSource->putParameter('repuestoDataSource', $repuestoDataSource);
		
		//get Provedores
		$this->objParam->addParametroConsulta('ordenacion', 'id_uni_cons_proveedor');
		$modUniConsProveedor = $this->create('MODUniConsProveedor');
		$resultProveedor = $modUniConsProveedor->listarUniConsProveedor($this->objParam);
		$proveedorDataSource = new DataSource();
		$proveedorDataSource->setDataSet($resultProveedor->getDatos());
		$dataSource->putParameter('proveedorDataSource', $proveedorDataSource);
		
		
		//get hijos
		$this->objParam->addParametro('id_uni_cons_padre', $idUniCons);
		$resultHijos = $this->objFunc->listarUniConsHijos($this->objParam);
		$arrayHijos = array();
		
		foreach($resultHijos->getDatos() as $rowHijo) {
			$dataSourceHijo = new DataSource();
			$this->objParam->addParametro('id_uni_cons', $rowHijo['id_uni_cons']);
			
			$resultDetalleHijo = $this->objFunc->listarUniConsDetalle($this->objParam);
			$dataSourceHijo->putParameter('nombreUniConsHijo', $rowHijo['nombre']);
			$dataSourceHijo->setDataset($resultDetalleHijo->getDatos());
			$arrayHijos[] = $dataSourceHijo;
		}
		$dataSource->putParameter('arrayHijos', $arrayHijos);
		
		//build the report
		$reporte = new RUniCons_FichaTecnica();
		$reporte->setDataSource($dataSource);
		$nombreArchivo = 'UniCons_FichaTecnica.pdf';
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