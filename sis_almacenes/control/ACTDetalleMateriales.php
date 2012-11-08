<?php
/**
*@package pXP
*@file    ACTDetalleMateriales.php
*@author  Gonzalo Sarmiento
*@date    02-10-2012
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDetalleMateriales extends ACTbase{    
            
    function listarDetalleMateriales(){
        $this->objParam->defecto('ordenacion','id_movimiento_det');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam);
            $this->res = $this->objReporte->generarReporteListado('FuncionesAlmacenes','listarDetalleMateriales');
        } else{
            $this->objFunc=new FuncionesAlmacenes();    
            $this->res=$this->objFunc->listarDetalleMateriales($this->objParam);
            $this->res->imprimirRespuesta($this->res->generarJson());
        }
    }
                
    function insertarDetalleMateriales(){
        $this->objFunc=new FuncionesAlmacenes();    
        if($this->objParam->insertar('id_movimiento_det')){
            $this->res=$this->objFunc->insertarDetalleMateriales($this->objParam);          
        } else{         
            $this->res=$this->objFunc->modificarDetalleMateriales($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarDetalleMateriales(){
        $this->objFunc=new FuncionesAlmacenes();    
        $this->res=$this->objFunc->eliminarDetalleMateriales($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>