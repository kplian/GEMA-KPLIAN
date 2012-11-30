<?php
/**
*@package pXP
*@file    ACTAlmacenStock.php
*@author  Gonzalo Sarmiento
*@date    01-10-2012
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAlmacenStock extends ACTbase{    
            
    function listarAlmacenItem(){
        $this->objParam->defecto('ordenacion','id_almacen_item');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODAlmacenStock','listarAlmacenItem');
        } else{
            $this->objFunc=$this->create('MODAlmacenStock');    
            $this->res=$this->objFunc->listarAlmacenItem();
            $this->res->imprimirRespuesta($this->res->generarJson());
        }
    }
                
    function insertarAlmacenItem(){
        $this->objFunc=$this->create('MODAlmacenStock');    
        if($this->objParam->insertar('id_almacen_stock')){
            $this->res=$this->objFunc->insertarAlmacenItem();            
        } else{         
            $this->res=$this->objFunc->modificarAlmacenItem();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarAlmacenItem(){
        $this->objFunc=$this->create('MODAlmacenStock');    
        $this->res=$this->objFunc->eliminarAlmacenItem();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>