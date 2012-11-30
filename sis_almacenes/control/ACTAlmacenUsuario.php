<?php
/**
*@package pXP
*@file gen-ACTAlmacenUsuario.php
*@author  (admin)
*@date 13-11-2012 01:30:22
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAlmacenUsuario extends ACTbase{    
            
    function listarAlmacenUsuario(){
        $this->objParam->defecto('ordenacion','id_almacen_usuario');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODAlmacenUsuario','listarAlmacenUsuario');
        } else{
            $this->objFunc=$this->create('MODAlmacenUsuario');    
            $this->res=$this->objFunc->listarAlmacenUsuario();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarAlmacenUsuario(){
        $this->objFunc=$this->create('MODAlmacenUsuario');    
        if($this->objParam->insertar('id_almacen_usuario')){
            $this->res=$this->objFunc->insertarAlmacenUsuario();         
        } else{         
            $this->res=$this->objFunc->modificarAlmacenUsuario();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarAlmacenUsuario(){
        $this->objFunc=$this->create('MODAlmacenUsuario');    
        $this->res=$this->objFunc->eliminarAlmacenUsuario();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
            
}


?>