<?php
/**
*@package pXP
*@file gen-ACTPartida.php
*@author  (admin)
*@date 23-11-2012 20:06:53
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTPartida extends ACTbase{    
			
	function listarPartida(){
		$this->objParam->defecto('ordenacion','id_partida');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam, $this);
			$this->res = $this->objReporte->generarReporteListado('MODPartida','listarPartida');
		} else{
			$this->objFunc=$this->create('MODPartida');	
			$this->res=$this->objFunc->listarPartida();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
    
    function listarPartidaArb(){
        //$this->objFunc=$this->create('MODPartida');    
        
        //obtiene el parametro nodo enviado por la vista
        $node=$this->objParam->getParametro('node');

        $id_partida=$this->objParam->getParametro('id_partida');
        $tipo_nodo=$this->objParam->getParametro('tipo_nodo');
        
                   
        if($node=='id'){
            $this->objParam->addParametro('id_padre','%');
        }
        else {
            $this->objParam->addParametro('id_padre',$id_partida);
        }
        
		$this->objFunc=$this->create('MODPartida');
        $this->res=$this->objFunc->listarPartidaArb();
        
        $this->res->setTipoRespuestaArbol();
        
        $arreglo=array();
        
        array_push($arreglo,array('nombre'=>'id','valor'=>'id_partida'));
        array_push($arreglo,array('nombre'=>'id_p','valor'=>'id_partida_fk'));
        
        
        array_push($arreglo,array('nombre'=>'text','valor'=>'codigo'));
        array_push($arreglo,array('nombre'=>'cls','valor'=>'codigo'));
        array_push($arreglo,array('nombre'=>'qtip','valores'=>'<b> #codigo#</b><br> #descripcion#'));
        
        
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
				
	function insertarPartida(){
		$this->objFunc=$this->create('MODPartida');	
		if($this->objParam->insertar('id_partida')){
			$this->res=$this->objFunc->insertarPartida();			
		} else{			
			$this->res=$this->objFunc->modificarPartida();
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarPartida(){
		$this->objFunc=$this->create('MODPartida');	
		$this->res=$this->objFunc->eliminarPartida();
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>