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

			
}//marca_generador
?>