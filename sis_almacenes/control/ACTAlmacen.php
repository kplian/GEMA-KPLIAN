<?php
/**
 * @Package pxP
 * @file    ACTAlmacen.php
 * @author  Gonzalo Sarmiento
 * @date    21-09-2012
 * @descripcion Clase que recibe los parametros enviados por la vista para luego ser mandadas a la capa Modelo
 */
 
 class ACTAlmacen extends ACTbase{    
            
    function listarAlmacen(){
        $this->objParam->defecto('ordenacion','codigo');

        $this->objParam->defecto('dir_ordenacion','asc');
        if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
            $this->objReporte = new Reporte($this->objParam, $this);
            $this->res = $this->objReporte->generarReporteListado('MODAlmacen','listarAlmacen');
        } else{
            $this->objFunc=$this->create('MODAlmacen');    
            $this->res=$this->objFunc->listarAlmacen();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                
    function insertarAlmacen(){
        $this->objFunc=$this->create('MODAlmacen');    
        if($this->objParam->insertar('id_almacen')){
            $this->res=$this->objFunc->insertarAlmacen();            
        } else{         
            $this->res=$this->objFunc->modificarAlmacen();
        }
        $this->res->imprimirRespuesta($this->res->generarJson());
    }
                        
    function eliminarAlmacen(){
        $this->objFunc=$this->create('MODAlmacen');    
        $this->res=$this->objFunc->eliminarAlmacen();
        $this->res->imprimirRespuesta($this->res->generarJson());
    }           
} 
?>
