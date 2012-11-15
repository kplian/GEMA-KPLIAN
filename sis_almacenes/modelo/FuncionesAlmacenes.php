<?php
/**
*@package pXP
*@file FuncionesAlmacenes.php
*@author  Gonzalo Sarmiento
*@date 01-10-2012
*@description Clase que centraliza todos los metodos de todas las clases del Sistema de Sistema de Almacenes
*/

class FuncionesAlmacenes{
        
    function __construct(){
        foreach (glob('../../../sis_almacenes/modelo/MOD*.php') as $archivo){
            include_once($archivo);
        }
    }

    /*Clase: MODItem
    * Fecha: 17-08-2012 11:18:22
    * Autor: admin*/
    function listarItem(CTParametro $parametro){
        $obj=new MODItem($parametro);
        $res=$obj->listarItem();
        return $res;
    }
     
    function listarItemNotBase(CTParametro $parametro){
        $obj=new MODItem($parametro);
        $res=$obj->listarItemNotBase();
        return $res;
    }
           
    function insertarItem(CTParametro $parametro){
        $obj=new MODItem($parametro);
        $res=$obj->insertarItem();
        return $res;
    }
            
    function modificarItem(CTParametro $parametro){
        $obj=new MODItem($parametro);
        $res=$obj->modificarItem();
        return $res;
    }
            
    function eliminarItem(CTParametro $parametro){
        $obj=new MODItem($parametro);
        $res=$obj->eliminarItem();
        return $res;
    }
    /*FinClase: MODItem*/

    /**
    * Clase: MODClasificacion
    * Fecha: 21-09-2012
    * Autor: Gonzalo Sarmiento
    */
    function listarClasificacion(CTParametro $parametro){
        $obj=new MODClasificacion($parametro);
        $res=$obj->listarClasificacion();
        return $res;
    }
    function listarClasificacionCodigo(CTParametro $parametro)  {
        $obj=new MODClasificacion($parametro);
        $res=$obj->listarClasificacionCodigo();
        return $res;
    }
    
    function listarClasificacionArb(CTParametro $parametro){
        $obj=new MODClasificacion($parametro);
        $res=$obj->listarClasificacionArb();
        return $res;
    }
            
    function insertarClasificacion(CTParametro $parametro){
        $obj=new MODClasificacion($parametro);
        $res=$obj->insertarClasificacion();
        return $res;
    }
            
    function modificarClasificacion(CTParametro $parametro){
        $obj=new MODClasificacion($parametro);
        $res=$obj->modificarClasificacion();
        return $res;
    }
            
    function eliminarClasificacion(CTParametro $parametro){
        $obj=new MODClasificacion($parametro);
        $res=$obj->eliminarClasificacion();
        return $res;
    }
    /*FinClase: MODClasificacion*/

    
    /**
    * Clase: MODAlmacenStock
    * Fecha: 21-09-2012
    * Autor: Gonzalo Sarmiento
    */
    function listarAlmacenItem(CTParametro $parametro){
        $obj=new MODAlmacenStock($parametro);
        $res=$obj->listarAlmacenItem();
        return $res;
    }
            
    function insertarAlmacenItem(CTParametro $parametro){
        $obj=new MODAlmacenStock($parametro);
        $res=$obj->insertarAlmacenItem();
        return $res;
    }
            
    function modificarAlmacenItem(CTParametro $parametro){
        $obj=new MODAlmacenStock($parametro);
        $res=$obj->modificarAlmacenItem();
        return $res;
    }
            
    function eliminarAlmacenItem(CTParametro $parametro){
        $obj=new MODAlmacenStock($parametro);
        $res=$obj->eliminarAlmacenItem();
        return $res;
    }
    /*FinClase: MODAlmacenStock*/
    
        
    /**
    * Clase: MODAlmacen
    * Fecha: 21-09-2012
    * Autor: Gonzalo Sarmiento
    */
    function listarAlmacen(CTParametro $parametro){
        $obj=new MODAlmacen($parametro);
        $res=$obj->listarAlmacen();
        return $res;
    }
            
    function insertarAlmacen(CTParametro $parametro){
        $obj=new MODAlmacen($parametro);
        $res=$obj->insertarAlmacen();
        return $res;
    }
            
    function modificarAlmacen(CTParametro $parametro){
        $obj=new MODAlmacen($parametro);
        $res=$obj->modificarAlmacen();
        return $res;
    }
            
    function eliminarAlmacen(CTParametro $parametro){
        $obj=new MODAlmacen($parametro);
        $res=$obj->eliminarAlmacen();
        return $res;
    }
    /*FinClase: MODAlmacen*/
    
    /**
    * Clase: MODMovimiento
    * Fecha: 03-10-2012
    * Autor: Gonzalo Sarmiento
    */
    function listarMovimiento(CTParametro $parametro){
        $obj=new MODMovimiento($parametro);
        $res=$obj->listarMovimiento();
        return $res;
    }
            
    function insertarMovimiento(CTParametro $parametro){
        $obj=new MODMovimiento($parametro);
        $res=$obj->insertarMovimiento();
        return $res;
    }
            
    function modificarMovimiento(CTParametro $parametro){
        $obj=new MODMovimiento($parametro);
        $res=$obj->modificarMovimiento();
        return $res;
    }
            
    function eliminarMovimiento(CTParametro $parametro){
        $obj=new MODMovimiento($parametro);
        $res=$obj->eliminarMovimiento();
        return $res;
    }
    
    function finalizarMovimiento(CTParametro $parametro){
        $obj = new MODMovimiento($parametro);
        $res = $obj->finalizarMovimiento();
        return $res;
    }
    /*FinClase: MODMovimiento*/ 

    /**
     * Clase: MODDetalleMateriales
     * Fecha: 02-10-2012
     * Autor: Gonzalo Sarmiento   
     */
     function listarDetalleMateriales(CTParametro $parametro){
        $obj = new MODDetalleMateriales($parametro);
        $res = $obj->listarDetalleMateriales();
        return $res;        
     }
     
     function insertarDetalleMateriales(CTParametro $parametro){
        $obj = new MODDetalleMateriales($parametro);
        $res = $obj->insertarDetalleMateriales();
        return $res;
     }
     
     function modificarDetalleMateriales(CTParametro $parametro){
        $obj = new MODDetalleMateriales($parametro);
        $res = $obj->modificarDetalleMateriales();
        return $res;
     }
     
     function eliminarDetalleMateriales(CTParametro $parametro){
        $obj = new MODDetalleMateriales($parametro);
        $res = $obj->eliminarDetalleMateriales();
        return $res;
     }
     /* Fin de clase MODDetalleMateriales*/
     
     /*Clase: MODAlmacenUsuario
    * Fecha: 13-11-2012 01:30:22
    * Autor: admin*/
    function listarAlmacenUsuario(CTParametro $parametro){
        $obj=new MODAlmacenUsuario($parametro);
        $res=$obj->listarAlmacenUsuario();
        return $res;
    }
            
    function insertarAlmacenUsuario(CTParametro $parametro){
        $obj=new MODAlmacenUsuario($parametro);
        $res=$obj->insertarAlmacenUsuario();
        return $res;
    }
            
    function modificarAlmacenUsuario(CTParametro $parametro){
        $obj=new MODAlmacenUsuario($parametro);
        $res=$obj->modificarAlmacenUsuario();
        return $res;
    }
            
    function eliminarAlmacenUsuario(CTParametro $parametro){
        $obj=new MODAlmacenUsuario($parametro);
        $res=$obj->eliminarAlmacenUsuario();
        return $res;
    }
    /*FinClase: MODAlmacenUsuario*/
                      
}//marca_generador
?>