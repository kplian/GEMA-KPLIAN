<?php
/**
*@package pXP
*@file gen-ACTItem.php
*@author  (admin)
*@date 17-08-2012 11:18:22
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTItem extends ACTbase{    
            
    function listarItem(){
        $this->objParam->defecto('ordenacion','id_item');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODItem','listarItem');
        } else{
            $this->objFunc=$this->create('MODItem');    
            $this->res=$this->objFunc->listarItem();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
        
    function listarItemNotBase(){
        $this->objParam->defecto('ordenacion','id_item');

        $this->objParam->defecto('dir_ordenacion','asc');
        
        $this->objFunc=$this->create('MODItem');    
        $this->res=$this->objFunc->listarItemNotBase();
    
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
        
    function insertarItem(){
        $this->objFunc=$this->create('MODItem');    
        if($this->objParam->insertar('id_item')){
            $this->res=$this->objFunc->insertarItem();           
        } else{         
            $this->res=$this->objFunc->modificarItem();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarItem(){
        $this->objFunc=$this->create('MODItem');    
        $this->res=$this->objFunc->eliminarItem();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>