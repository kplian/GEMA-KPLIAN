<?php
/**
*@package pXP
*@file gen-ACTPartida.php
*@author  (admin)
*@date 23-11-2012 20:06:53
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDiagramaDecisionAccion extends ACTbase{    
			
	function listarDiagramaDecisionAccion(){
		$this->objParam->defecto('ordenacion','id_diagrama_decision_accion');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODDiagramaDecisionAccion','listarDiagramaDecisionAccion');
		} else{
			$this->objFunc=$this->create('MODDiagramaDecisionAccion');	
			$this->res=$this->objFunc->listarPartida();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
    function listarDiagramaDecisionAccionArb(){
        //$this->objFunc=$this->create('MODPartida');    
        
        //obtiene el parametro nodo enviado por la vista
        $node=$this->objParam->getParametro('node');
            
        $id_diagrama_decision_accion=$this->objParam->getParametro('id_diagrama_decision_accion');
        $tipo_nodo=$this->objParam->getParametro('tipo_nodo');
        
                   
        if($node=='id'){
            $this->objParam->addParametro('id_padre','%');
        }
        else {
            $this->objParam->addParametro('id_padre',$id_diagrama_decision_accion);
        }
        
		$this->objFunc=$this->create('MODDiagramaDecisionAccion');
        $this->res=$this->objFunc->listarDiagramaDecisionAccionArb();
        
        $this->res->setTipoRespuestaArbol();
        
        $arreglo=array();
        
        array_push($arreglo,array('nombre'=>'id','valor'=>'id_diagrama_decision_accion'));
        array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_diagrama_decision_accion_fk'));
        
        
        array_push($arreglo,array('nombre'=>'text','valor'=>'codigo'));
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

        $this->res->imprimirRespuesta($this->res->generarJson());         

    }
				
	function insertarDiagramaDecisionAccion(){
		$this->objFunc=$this->create('MODDiagramaDecisionAccion');	
		if($this->objParam->insertar('id_diagrama_decision_accion')){
			$this->res=$this->objFunc->insertarPartida();			
		} else{			
			$this->res=$this->objFunc->modificarPartida();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarDiagramaDecisionAccion(){
		$this->objFunc=$this->create('MODDiagramaDecisionAccion');	
		$this->res=$this->objFunc->eliminarDiagramaDecisionAccion();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>