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
		foreach (glob('../../sis_almacenes/modelo/MOD*.php') as $archivo){
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
	function listarClasificacionCodigo(CTParametro $parametro)	{
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
	* Clase: MODIngreso
	* Fecha: 24-09-2012
	* Autor: Gonzalo Sarmiento
	*/
	/*
	function listarIngreso(CTParametro $parametro){
		$obj=new MODIngreso($parametro);
		$res=$obj->listarIngreso();
		return $res;
	}
			
	function insertarIngreso(CTParametro $parametro){
		$obj=new MODIngreso($parametro);
		$res=$obj->insertarIngreso();
		return $res;
	}
			
	function modificarIngreso(CTParametro $parametro){
		$obj=new MODIngreso($parametro);
		$res=$obj->modificarIngreso();
		return $res;
	}
			
	function eliminarIngreso(CTParametro $parametro){
		$obj=new MODIngreso($parametro);
		$res=$obj->eliminarIngreso();
		return $res;
	}
	/*FinClase: MODIngreso*/	
	
	/**
	* Clase: MODSalida
	* Fecha: 25-09-2012
	* Autor: Gonzalo Sarmiento
	*/
	/*
	function listarSalida(CTParametro $parametro){
		$obj=new MODSalida($parametro);
		$res=$obj->listarSalida();
		return $res;
	}
			
	function insertarSalida(CTParametro $parametro){
		$obj=new MODSalida($parametro);
		$res=$obj->insertarSalida();
		return $res;
	}
			
	function modificarSalida(CTParametro $parametro){
		$obj=new MODSalida($parametro);
		$res=$obj->modificarSalida();
		return $res;
	}
			
	function eliminarSalida(CTParametro $parametro){
		$obj=new MODSalida($parametro);
		$res=$obj->eliminarSalida();
		return $res;
	}
	/*FinClase: MODSalida*/
	
	/**
	* Clase: MODTransferencia
	* Fecha: 27-09-2012
	* Autor: Gonzalo Sarmiento
	*/
	/*
	function listarTransferencia(CTParametro $parametro){
		$obj=new MODTransferencia($parametro);
		$res=$obj->listarTransferencia();
		return $res;
	}
			
	function insertarTransferencia(CTParametro $parametro){
		$obj=new MODTransferencia($parametro);
		$res=$obj->insertarTransferencia();
		return $res;
	}
			
	function modificarTransferencia(CTParametro $parametro){
		$obj=new MODTransferencia($parametro);
		$res=$obj->modificarTransferencia();
		return $res;
	}
			
	function eliminarTransferencia(CTParametro $parametro){
		$obj=new MODTransferencia($parametro);
		$res=$obj->eliminarTransferencia();
		return $res;
	}
	*/
	/*FinClase: MODTransferencia*/
	
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
		$res = $obj->modificarDetallesMateriales();
		return $res;
	 }
	 
	 function eliminarDetalleMateriales(CTParametro $parametro){
	 	$obj = new MODDetalleMateriales($parametro);
		$res = $obj->eliminarDetalleMateriales();
		return $res;
	 }
	 /* Fin de clase MODDetalleMateriales*/					
}//marca_generador
?>