<?php
/**
*@package pXP
*@file gen-ACTDocumento.php
*@author  (admin)
*@date 28-08-2012 22:24:50
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTDocumento extends ACTbase{    
            
    function listarDocumento(){
        $this->objParam->defecto('ordenacion','id_documento');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam);
            $this->res = $this->objReporte->generarReporteListado('FuncionesMantenimiento','listarDocumento');
        } else{
            $this->objFunc=new FuncionesMantenimiento();    
            $this->res=$this->objFunc->listarDocumento($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarDocumento(){
        $this->objFunc=new FuncionesMantenimiento();    
        if($this->objParam->insertar('id_documento')){
            $this->res=$this->objFunc->insertarDocumento($this->objParam);          
        } else{         
            $this->res=$this->objFunc->modificarDocumento($this->objParam);
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarDocumento(){
        $this->objFunc=new FuncionesMantenimiento();    
        $this->res=$this->objFunc->eliminarDocumento($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function subirDocumento(){
        $this->objFunc= new FuncionesMantenimiento();
        $this->res=$this->objFunc->subirDocumento($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }   
    
    function subirVersionDocumento(){
        $this->objFunc= new FuncionesMantenimiento();
        $this->res=$this->objFunc->subirVersionDocumento($this->objParam);
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
    
    function listarVersionDocumento(){
        $this->objParam->defecto('ordenacion','id_documento');
        $this->objParam->defecto('dir_ordenacion','asc');
        
        $this->objFunc= new FuncionesMantenimiento();    
        $this->res=$this->objFunc->listarVersionDocumento($this->objParam);
        
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
}      

?>