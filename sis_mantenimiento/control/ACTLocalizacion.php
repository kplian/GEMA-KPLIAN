<?php
/**
*@package pXP
*@file gen-ACTLocalizacion.php
*@author  (rac)
*@date 14-06-2012 03:46:45
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTLocalizacion extends ACTbase{    
			
	function listarLocalizacion(){
		$this->objParam->defecto('ordenacion','id_localizacion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);

			$this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarLocalizacion');
		} else{
			
			$this->objFunc=$this->create('MODLocalizacion');
			$this->res=$this->objFunc->listarLocalizacion($this->objParam);

		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
	
	function listarLocalizacionArb(){

		
		//obtiene el parametro nodo enviado por la vista
		$node=$this->objParam->getParametro('node');

		$id_localizacion=$this->objParam->getParametro('id_localizacion');
		$tipo_nodo=$this->objParam->getParametro('tipo_nodo');
		
		
		if($tipo_nodo != 'uni_cons' && $tipo_nodo != 'uni_cons_f'){
			
					if($node=='id'){
						$this->objParam->addParametro('id_padre','%');
					}
					else {
						$this->objParam->addParametro('id_padre',$id_localizacion);
					}

		            $this->objFunc=$this->create('MODLocalizacion');
					$this->res=$this->objFunc->listarLocalizacionArb($this->objParam);

					
					$this->res->setTipoRespuestaArbol();
					
					$arreglo=array();
					
					array_push($arreglo,array('nombre'=>'id','valor'=>'id_localizacion'));
					array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_localizacion_fk'));
					
					array_push($arreglo,array('nombre'=>'text','valor'=>'texto'));
					array_push($arreglo,array('nombre'=>'cls','valor'=>'nombre'));
					array_push($arreglo,array('nombre'=>'qtip','valores'=>'<b> #codigo#</b><br> #nombre#'));
					
					
					$this->res->addNivelArbol('tipo_nodo','raiz',array('leaf'=>false,
																	'allowDelete'=>true,
																	'allowEdit'=>true,
					 												'cls'=>'folder',
					 												'tipo_nodo'=>'raiz',
					 												'icon'=>'../../../lib/imagenes/a_form.png'),
					 												$arreglo);
					 
					/*se ande un nivel al arbol incluyendo con tido de nivel carpeta con su arreglo de equivalencias
					  es importante que entre los resultados devueltos por la base exista la variable\
					  tipo_dato que tenga el valor en texto = 'hoja' */
					 														
			
					 $this->res->addNivelArbol('tipo_nodo','hijo',array(
																	'leaf'=>false,
																	'allowDelete'=>true,
																	'allowEdit'=>true,
					 												'tipo_nodo'=>'hijo',
					 												'icon'=>'../../../lib/imagenes/a_form.png'),
					 												$arreglo);
																	
																	
						/*Agregar unidades constructivas a la loccalizacion*/
					$arreglo=array();
						
					array_push($arreglo,array('nombre'=>'id','valor'=>'id_localizacion'));
					array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_localizacion_fk'));
					
					array_push($arreglo,array('nombre'=>'text','valores'=>'<b> [#codigo#] </b>- #nombre#'));
					array_push($arreglo,array('nombre'=>'cls','valor'=>'nombre'));
					array_push($arreglo,array('nombre'=>'qtip','valores'=>'<b> #codigo#</b><br> #nombre#'));
					
					
					$this->res->addNivelArbol('tipo_nodo','uni_cons',array('leaf'=>false,
																	'allowDelete'=>false,
																	'allowEdit'=>false,
					 												'cls'=>'folder',
					 												
					 												'icon'=>'../../../lib/imagenes/otros/tuc.png'
					 												),
					 												$arreglo);
				
				   $this->res->addNivelArbol('tipo_nodo','uni_cons_f',array('leaf'=>false,
																	'allowDelete'=>false,
																	'allowEdit'=>false,
					 												'cls'=>'folder',
					 												
					 												'icon'=>'../../../lib/imagenes/otros/tucred.png'
					 												),
					 												$arreglo);
				
				
				//Se imprime el arbol en formato JSON
		       $this->res->imprimirRespuesta($this->res->generarJson());	 
																
		 	}
		else
			{
				//si el padre es una unidad contructiva busca las partes
				$id_uni_cons=$this->objParam->getParametro('id_uni_cons');
				$this->objParam->addParametro('id_padre',$id_uni_cons);
				$this->objParam->addParametro('tipo','uc');

				$this->objFunc=$this->create('MODUniCons');			
				$this->res=$this->objFunc->listarUniCons($this->objParam);

				$this->res->setTipoRespuestaArbol();
				
				$arreglo=array();
				
				array_push($arreglo,array('nombre'=>'id','valor'=>'id_uni_loc'));
				array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_unic_cons_padre'));
				//array_push($arreglo,array('nombre'=>'cls','valor'=>'descripcion'));
			
				
				
				
				$this->res->addNivelArbol('incluir_calgen','false',array(
															'leaf'=>true,
															'allowDelete'=>true,
															'allowEdit'=>true,
			 												'icon'=>'../../../lib/imagenes/otros/gear_red.png'),
			 												$arreglo);
				
				
				$this->res->addNivelArbol('incluir_calgen','true',array(
															'leaf'=>true,
															'allowDelete'=>true,
															'allowEdit'=>true,
			 												'icon'=>'../../../lib/imagenes/gear.png'),
			 												$arreglo);
				
				//Se imprime el arbol en formato JSON
			     $this->res->imprimirRespuesta($this->res->generarJson());	
				
			}														
			

		
	}
	
				
	function insertarLocalizacion(){

		 $this->objFunc=$this->create('MODLocalizacion');

		if($this->objParam->insertar('id_localizacion')){
			$this->res=$this->objFunc->insertarLocalizacion();			
		} else{			
			$this->res=$this->objFunc->modificarLocalizacion();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarLocalizacion(){
		//var_dump($this->objParam);exit;
		if($this->objParam->getParametro('tipo_meta')=='uni_cons'||$this->objParam->getParametro('tipo_meta')=='uni_cons_f'){
			$this->objParam->addParametro('id_uni_cons',$this->objParam->getParametro('id_localizacion'));
			$this->objFunc=$this->create('MODUniCons');
			$this->res=$this->objFunc->inactivarUniCons($this->objParam);
		} else {
			$this->objFunc=$this->create('MODLocalizacion');
			$this->res=$this->objFunc->eliminarLocalizacion($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>