<?php
/**
*@package pXP
*@file gen-ACTIssue.php
*@author  (admin)
*@date 10-12-2012 19:16:36
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTIssue extends ACTbase{    
			
	function listarIssue(){
		$this->objParam->defecto('ordenacion','id_issue');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODIssue','listarIssue');
		} else{
			$this->objFunc=$this->create('MODIssue');	
			$this->res=$this->objFunc->listarIssue($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarIssue(){
		$this->objFunc=$this->create('MODIssue');
		if($this->objParam->insertar('id_issue')){
			$this->res=$this->objFunc->insertarIssue($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarIssue($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarIssue(){
		$this->objFunc=$this->create('MODIssue');	
		$this->res=$this->objFunc->eliminarIssue($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}

	function updateIssues(){
		/*ob_start();
		$fb=FirePHP::getInstance(true);*/
		
		//var_dump($this->objParam);
		$issue=$this->objParam->getParametro('issue');
		$json='';
		$line='';
		$param=clone $this->objParam;
		//Define ruta y nombre de archivo
		$ruta=dirname(__FILE__).'/issues.json';
		//Abre el archivo
		$file=fopen($ruta,'r');
		//Recorre el archivo
		while(!feof($file)){
			$line=fgets($file);
			$json=$json.$line;
		}
		//Decodifica el json
		$json=json_decode($json);
		//Elimina los datos de la tabla
		$this->objFunc1=$this->create('MODIssue');
		$res1=$this->objFunc1->delIssues($this->objParam);
		//Recorre el json
		$tt=0;
		foreach ($json as $indice => $valor) {
			$tt++;
			//Reinicio de variables
			$labels='';
			$milestone='';
			unset($var);
			$this->objParam=clone $param;
			//Procesando Labels
			foreach ($valor->labels as $subind => $subval) {
				$labels=$labels.$subval->name.',';
			}
			if($labels==''){
				$labels='sin etiquetas';
			}
			//Almacena los valores en un array temporal
			$this->objParam->addParametro('nro_issue',$valor->number);
			$this->objParam->addParametro('titulo',$valor->title);
			$this->objParam->addParametro('descripcion',$valor->body);
			if($valor->assignee->login!=''){
				$this->objParam->addParametro('developer',$valor->assignee->login);	
			}else{
				$this->objParam->addParametro('developer',"");
			}
			
			$this->objParam->addParametro('labels',$labels);
			if($valor->closed_at!=''){
				$this->objParam->addParametro('fecha_cierre',$valor->closed_at);
			} else{
				$this->objParam->addParametro('fecha_cierre',"");
			}
			if($valor->closed_at!=''){
				$this->objParam->addParametro('fecha_cierre',$valor->closed_at);
			} else{
				$this->objParam->addParametro('fecha_cierre',"");
			}
			$this->objParam->addParametro('fecha_act',$valor->updated_at);
			if($valor->milestone->title!=''){
				$this->objParam->addParametro('milestone',$valor->milestone->title);	
			} else{
				$this->objParam->addParametro('milestone',"");
			}
			$this->objParam->addParametro('estado',$valor->state);
			$aux=$valor->user->login;
			$this->objParam->addParametro('creador',$aux);
			$this->objParam->addParametro('tiempo_hrs',1);
			$this->objParam->addParametro('semana',49);
			$this->objParam->addParametro('prioridad',1);
			
			$aux='';
			$pos=strpos($valor->body, '* Time (Hours):');
			if($pos){
				$aux=substr($valor->body,$pos,3);
					
			}
			
			
			$this->objFunc=$this->create('MODIssue');
			$this->res=$this->objFunc->insertarIssue($this->objParam);
			/*$fb->log($valor->number,"nro_issue");			
			$fb->log($this->res,"resp_issue");
			$fb->log($aux,"time_issue");*/
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
		
		
	}
			
}

?>