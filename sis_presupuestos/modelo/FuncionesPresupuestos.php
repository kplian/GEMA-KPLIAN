<?php
/**
*@package pXP
*@file gen-FuncionesPresupuestos.php
*@author  (admin)
*@date 23-11-2012 20:06:53
*@description Clase que centraliza todos los metodos de todas las clases del Sistema de Sistema de presupuesto
*/

class FuncionesPresupuestos{
		
	function __construct(){
		foreach (glob('../../../sis_presupuestos/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}
	}

	/*Clase: MODPartida
	* Fecha: 23-11-2012 20:06:53
	* Autor: admin*/
	function listarPartida(CTParametro $parametro){
		$obj=new MODPartida($parametro);
		$res=$obj->listarPartida();
		return $res;
	}
    
    function listarPartidaArb(CTParametro $parametro){
        $obj=new MODPartida($parametro);
        $res=$obj->listarPartidaArb();
        return $res;
    }
			
	function insertarPartida(CTParametro $parametro){
		$obj=new MODPartida($parametro);
		$res=$obj->insertarPartida();
		return $res;
	}
			
	function modificarPartida(CTParametro $parametro){
		$obj=new MODPartida($parametro);
		$res=$obj->modificarPartida();
		return $res;
	}
			
	function eliminarPartida(CTParametro $parametro){
		$obj=new MODPartida($parametro);
		$res=$obj->eliminarPartida();
		return $res;
	}
	/*FinClase: MODPartida*/
    
    /*Clase: MODPresupuesto
    * Fecha: 26-11-2012 21:35:35
    * Autor: Gonzalo Sarmiento*/
    function listarPresupuesto(CTParametro $parametro){
        $obj=new MODPresupuesto($parametro);
        $res=$obj->listarPresupuesto();
        return $res;
    }
            
    function insertarPresupuesto(CTParametro $parametro){
        $obj=new MODPresupuesto($parametro);
        $res=$obj->insertarPresupuesto();
        return $res;
    }
            
    function modificarPresupuesto(CTParametro $parametro){
        $obj=new MODPresupuesto($parametro);
        $res=$obj->modificarPresupuesto();
        return $res;
    }
            
    function eliminarPresupuesto(CTParametro $parametro){
        $obj=new MODPresupuesto($parametro);
        $res=$obj->eliminarPresupuesto();
        return $res;
    }
    /*FinClase: MODPresupuesto*/
    
    /*Clase: MODPresupPartida
    * Fecha: 26-11-2012 22:02:47
    * Autor: Gonzalo Sarmiento Sejas*/
    function listarPresupPartida(CTParametro $parametro){
        $obj=new MODPresupPartida($parametro);
        $res=$obj->listarPresupPartida();
        return $res;
    }
            
    function insertarPresupPartida(CTParametro $parametro){
        $obj=new MODPresupPartida($parametro);
        $res=$obj->insertarPresupPartida();
        return $res;
    }
            
    function modificarPresupPartida(CTParametro $parametro){
        $obj=new MODPresupPartida($parametro);
        $res=$obj->modificarPresupPartida();
        return $res;
    }
            
    function eliminarPresupPartida(CTParametro $parametro){
        $obj=new MODPresupPartida($parametro);
        $res=$obj->eliminarPresupPartida();
        return $res;
    }
    /*FinClase: MODPresupPartida*/
    
			
}//marca_generador
?>