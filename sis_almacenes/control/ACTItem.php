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
            $this->objReporte = new Reporte($this->objParam);
            $this->res = $this->objReporte->generarReporteListado('FuncionesAlmacenes','listarItem');
        } else{
            $this->objFunc=new FuncionesAlmacenes();    
            $this->res=$this->objFunc->listarItem($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
        
    function listarItemNotBase(){
        $this->objParam->defecto('ordenacion','id_item');

        $this->objParam->defecto('dir_ordenacion','asc');
        
        $this->objFunc=new FuncionesAlmacenes();    
        $this->res=$this->objFunc->listarItemNotBase($this->objParam);
    
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
        
    function insertarItem(){
        $this->objFunc=new FuncionesAlmacenes();    
        if($this->objParam->insertar('id_item')){
            $this->res=$this->objFunc->insertarItem($this->objParam);           
        } else{         
            $this->res=$this->objFunc->modificarItem($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarItem(){
        $this->objFunc=new FuncionesAlmacenes();    
        $this->res=$this->objFunc->eliminarItem($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}

?>