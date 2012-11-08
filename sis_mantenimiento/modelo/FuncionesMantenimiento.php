<?php
/**
*@package       pXP
*@file          gen-FuncionesMantenimiento.php
*@author        (rac)
*@date          14-06-2012 03:46:45
*@description   Clase que centraliza todos los metodos de todas las clases del Sistema de SISTEMA DE GESTION DE MANTENIMIENTO
*/

class FuncionesMantenimiento{
		
	function __construct(){
		foreach (glob('../../../sis_mantenimiento/modelo/MOD*.php') as $archivo){
			include_once($archivo);
		}
	}

	/*Clase: MODLocalizacion
	* Fecha: 14-06-2012 03:46:45
	* Autor: rac*/
	function listarLocalizacion(CTParametro $parametro){
		$obj=new MODLocalizacion($parametro);
		$res=$obj->listarLocalizacion();
		return $res;
	}
		
	function listarLocalizacionArb(CTParametro $parametro){
		$obj=new MODLocalizacion($parametro);
		$res=$obj->listarLocalizacionArb();
		return $res;
	}

			
	function insertarLocalizacion(CTParametro $parametro){
		$obj=new MODLocalizacion($parametro);
		$res=$obj->insertarLocalizacion();
		return $res;
	}
			
	function modificarLocalizacion(CTParametro $parametro){
		$obj=new MODLocalizacion($parametro);
		$res=$obj->modificarLocalizacion();
		return $res;
	}
			
	function eliminarLocalizacion(CTParametro $parametro){
		$obj=new MODLocalizacion($parametro);
		$res=$obj->eliminarLocalizacion();
		return $res;
	}
	/*FinClase: MODLocalizacion*/

			
	/*Clase: MODTipoEquipo
	* Fecha: 08-08-2012 23:50:13
	* Autor: rac*/
	function listarTipoEquipo(CTParametro $parametro){
		$obj=new MODTipoEquipo($parametro);
		$res=$obj->listarTipoEquipo();
		return $res;
	}
			
	function insertarTipoEquipo(CTParametro $parametro){
		$obj=new MODTipoEquipo($parametro);
		$res=$obj->insertarTipoEquipo();
		return $res;
	}
			
	function modificarTipoEquipo(CTParametro $parametro){
		$obj=new MODTipoEquipo($parametro);
		$res=$obj->modificarTipoEquipo();
		return $res;
	}
			
	function eliminarTipoEquipo(CTParametro $parametro){
		$obj=new MODTipoEquipo($parametro);
		$res=$obj->eliminarTipoEquipo();
		return $res;
	}
	/*FinClase: MODTipoEquipo*/


	/*Clase: MODUniCons
	* Fecha: 09-08-2012 00:42:57
	* Autor: rac*/
	function listarUniCons(CTParametro $parametro){
		$obj=new MODUniCons($parametro);
		$res=$obj->listarUniCons();
		return $res;
	}
		
    function listarUniConsHijo(CTParametro $parametro){
        $obj=new MODUniCons($parametro);
        $res=$obj->listarUniConsHijo();
        return $res;
    }
    	
	function insertarUniCons(CTParametro $parametro){
		$obj=new MODUniCons($parametro);
		$res=$obj->insertarUniCons();
		return $res;
	}
			
	function modificarUniCons(CTParametro $parametro){
		$obj=new MODUniCons($parametro);
		$res=$obj->modificarUniCons();
		return $res;
	}
	
	function setBlockUnblockUniCons(CTParametro $parametro){
		$obj=new MODUniCons($parametro);
		$res=$obj->setBlockUnblockUniCons();
		return $res;
	}
					
	function eliminarUniCons(CTParametro $parametro){
		$obj=new MODUniCons($parametro);
		$res=$obj->eliminarUniCons();
		return $res;
	}
	
	function addUniCons(CTParametro $parametro){
		$obj=new MODUniCons($parametro);
		$res=$obj->addUniCons();
		return $res;
	}
	
	function listarUniConsPlano(CTParametro $parametro){
		$obj=new MODUniCons($parametro);
		$res=$obj->listarUniConsPlano();
		return $res;
	}
	
	function GenerarCalendario(CTParametro $parametro){
		$obj=new MODUniCons($parametro);
		$res=$obj->GenerarCalendario();
		return $res;
	}
	
	
	/*FinClase: MODUniCons*/


	/*Clase: MODTipoVariable
	* Fecha: 15-08-2012 15:28:09
	* Autor: rac*/
	function listarTipoVariable(CTParametro $parametro){
		$obj=new MODTipoVariable($parametro);
		$res=$obj->listarTipoVariable();
		return $res;
	}
			
	function insertarTipoVariable(CTParametro $parametro){
		$obj=new MODTipoVariable($parametro);
		$res=$obj->insertarTipoVariable();
		return $res;
	}
			
	function modificarTipoVariable(CTParametro $parametro){
		$obj=new MODTipoVariable($parametro);
		$res=$obj->modificarTipoVariable();
		return $res;
	}
			
	function eliminarTipoVariable(CTParametro $parametro){
		$obj=new MODTipoVariable($parametro);
		$res=$obj->eliminarTipoVariable();
		return $res;
	}
	/*FinClase: MODTipoVariable*/
	
	/*Clase: MODTipoMant
	* Fecha: 17-08-2012 12:04:43
	* Autor: admin*/
	function listarTipoMant(CTParametro $parametro){
		$obj=new MODTipoMant($parametro);
		$res=$obj->listarTipoMant();
		return $res;
	}
			
	function insertarTipoMant(CTParametro $parametro){
		$obj=new MODTipoMant($parametro);
		$res=$obj->insertarTipoMant();
		return $res;
	}
			
	function modificarTipoMant(CTParametro $parametro){
		$obj=new MODTipoMant($parametro);
		$res=$obj->modificarTipoMant();
		return $res;
	}
			
	function eliminarTipoMant(CTParametro $parametro){
		$obj=new MODTipoMant($parametro);
		$res=$obj->eliminarTipoMant();
		return $res;
	}
	/*FinClase: MODTipoMant*/
	
	/*Clase: MODMetodologia
	* Fecha: 17-08-2012 15:52:47
	* Autor: admin*/
	function listarMetodologia(CTParametro $parametro){
		$obj=new MODMetodologia($parametro);
		$res=$obj->listarMetodologia();
		return $res;
	}
			
	function insertarMetodologia(CTParametro $parametro){
		$obj=new MODMetodologia($parametro);
		$res=$obj->insertarMetodologia();
		return $res;
	}
			
	function modificarMetodologia(CTParametro $parametro){
		$obj=new MODMetodologia($parametro);
		$res=$obj->modificarMetodologia();
		return $res;
	}
			
	function eliminarMetodologia(CTParametro $parametro){
		$obj=new MODMetodologia($parametro);
		$res=$obj->eliminarMetodologia();
		return $res;
	}
	/*FinClase: MODMetodologia*/


	/*Clase: MODEquipoVariable
	* Fecha: 15-08-2012 17:09:17
	* Autor: rac*/
	function listarEquipoVariable(CTParametro $parametro){
		$obj=new MODEquipoVariable($parametro);
		$res=$obj->listarEquipoVariable();
		return $res;
	}
			
	function insertarEquipoVariable(CTParametro $parametro){
		$obj=new MODEquipoVariable($parametro);
		$res=$obj->insertarEquipoVariable();
		return $res;
	}
			
	function modificarEquipoVariable(CTParametro $parametro){
		$obj=new MODEquipoVariable($parametro);
		$res=$obj->modificarEquipoVariable();
		return $res;
	}
			
	function eliminarEquipoVariable(CTParametro $parametro){
		$obj=new MODEquipoVariable($parametro);
		$res=$obj->eliminarEquipoVariable();
		return $res;
	}
    
	function listarVariables(CTParametro $parametro){
		$obj=new MODEquipoVariable($parametro);
		$res=$obj->listarVariables();
		return $res;
	}
	/*FinClase: MODEquipoVariable*/


	/*Clase: MODFalla
	* Fecha: 21-08-2012 20:44:06
	* Autor: rac*/
	function listarFalla(CTParametro $parametro){
		$obj=new MODFalla($parametro);
		$res=$obj->listarFalla();
		return $res;
	}
			
	function insertarFalla(CTParametro $parametro){
		$obj=new MODFalla($parametro);
		$res=$obj->insertarFalla();
		return $res;
	}
			
	function modificarFalla(CTParametro $parametro){
		$obj=new MODFalla($parametro);
		$res=$obj->modificarFalla();
		return $res;
	}
			
	function eliminarFalla(CTParametro $parametro){
		$obj=new MODFalla($parametro);
		$res=$obj->eliminarFalla();
		return $res;
	}
	/*FinClase: MODFalla*/
	
	/*Clase: MODMantPredef
	* Fecha: 28-08-2012 20:25:32
	* Autor: admin*/
	function listarMantPredef(CTParametro $parametro){
		$obj=new MODMantPredef($parametro);
		$res=$obj->listarMantPredef();
		return $res;
	}
			
	function insertarMantPredef(CTParametro $parametro){
		$obj=new MODMantPredef($parametro);
		$res=$obj->insertarMantPredef();
		return $res;
	}
			
	function modificarMantPredef(CTParametro $parametro){
		$obj=new MODMantPredef($parametro);
		$res=$obj->modificarMantPredef();
		return $res;
	}
			
	function eliminarMantPredef(CTParametro $parametro){
		$obj=new MODMantPredef($parametro);
		$res=$obj->eliminarMantPredef();
		return $res;
	}
	/*FinClase: MODMantPredef*/
	
	/*Clase: MODMantPredefDet
	* Fecha: 28-08-2012 21:15:37
	* Autor: admin*/
	function listarMantPredefDet(CTParametro $parametro){
		$obj=new MODMantPredefDet($parametro);
		$res=$obj->listarMantPredefDet();
		return $res;
	}
			
	function insertarMantPredefDet(CTParametro $parametro){
		$obj=new MODMantPredefDet($parametro);
		$res=$obj->insertarMantPredefDet();
		return $res;
	}
			
	function modificarMantPredefDet(CTParametro $parametro){
		$obj=new MODMantPredefDet($parametro);
		$res=$obj->modificarMantPredefDet();
		return $res;
	}
			
	function eliminarMantPredefDet(CTParametro $parametro){
		$obj=new MODMantPredefDet($parametro);
		$res=$obj->eliminarMantPredefDet();
		return $res;
	}
	/*FinClase: MODMantPredefDet*/
	
	/*Clase: MODDocumento
	* Fecha: 28-08-2012 21:50:02
	* Autor: admin*/
	function listarDocumento(CTParametro $parametro){
        $obj=new MODDocumento($parametro);
        $res=$obj->listarDocumento();
        return $res;
    }
            
    function insertarDocumento(CTParametro $parametro){
        $obj=new MODDocumento($parametro);
        $res=$obj->insertarDocumento();
        return $res;
    }
            
    function modificarDocumento(CTParametro $parametro){
        $obj=new MODDocumento($parametro);
        $res=$obj->modificarDocumento();
        return $res;
    }
            
    function eliminarDocumento(CTParametro $parametro){
        $obj=new MODDocumento($parametro);
        $res=$obj->eliminarDocumento();
        return $res;
    }
    
    function subirDocumento(CTParametro $parametro){
        $obj=new MODDocumento($parametro);
        $res=$obj->subirDocumento();
        return $res;
    }
    
    function subirVersionDocumento(CTParametro $parametro){
        $obj=new MODDocumento($parametro);
        $res=$obj->subirVersionDocumento();
        return $res;
    }
    
    function listarVersionDocumento(CTParametro $parametro){
        $obj = new MODDocumento($parametro);
        $res = $obj->listarVersionDocumento();
        return $res;
    }
	/*FinClase: MODDocumento*/
	
	/*Clase: MODOrdenTrabajo
	* Fecha: 30-08-2012 02:48:41
	* Autor: admin*/
	function listarOrdenTrabajo(CTParametro $parametro){
		$obj=new MODOrdenTrabajo($parametro);
		$res=$obj->listarOrdenTrabajo();
		return $res;
	}
			
	function insertarOrdenTrabajo(CTParametro $parametro){
		$obj=new MODOrdenTrabajo($parametro);
		$res=$obj->insertarOrdenTrabajo();
		return $res;
	}
			
	function modificarOrdenTrabajo(CTParametro $parametro){
		$obj=new MODOrdenTrabajo($parametro);
		$res=$obj->modificarOrdenTrabajo();
		return $res;
	}
			
	function eliminarOrdenTrabajo(CTParametro $parametro){
		$obj=new MODOrdenTrabajo($parametro);
		$res=$obj->eliminarOrdenTrabajo();
		return $res;
	}
	/*FinClase: MODOrdenTrabajo*/
	
	/*Clase: MODFuncionarioHonorario
	* Fecha: 22-09-2012 01:44:56
	* Autor: admin*/
	function listarFuncionarioHonorario(CTParametro $parametro){
		$obj=new MODFuncionarioHonorario($parametro);
		$res=$obj->listarFuncionarioHonorario();
		return $res;
	}
			
	function insertarFuncionarioHonorario(CTParametro $parametro){
		$obj=new MODFuncionarioHonorario($parametro);
		$res=$obj->insertarFuncionarioHonorario();
		return $res;
	}
			
	function modificarFuncionarioHonorario(CTParametro $parametro){
		$obj=new MODFuncionarioHonorario($parametro);
		$res=$obj->modificarFuncionarioHonorario();
		return $res;
	}
			
	function eliminarFuncionarioHonorario(CTParametro $parametro){
		$obj=new MODFuncionarioHonorario($parametro);
		$res=$obj->eliminarFuncionarioHonorario();
		return $res;
	}
	/*FinClase: MODFuncionarioHonorario*/
	
	/*Clase: MODEquipoMedicion
	* Fecha: 27-09-2012 03:02:35
	* Autor: admin*/
	function listarEquipoMedicion(CTParametro $parametro){
		$obj=new MODEquipoMedicion($parametro);
		$res=$obj->listarEquipoMedicion();
		return $res;
	}
			
	function insertarEquipoMedicion(CTParametro $parametro){
		$obj=new MODEquipoMedicion($parametro);
		$res=$obj->insertarEquipoMedicion();
		return $res;
	}
			
	function modificarEquipoMedicion(CTParametro $parametro){
		$obj=new MODEquipoMedicion($parametro);
		$res=$obj->modificarEquipoMedicion();
		return $res;
	}
			
	function eliminarEquipoMedicion(CTParametro $parametro){
		$obj=new MODEquipoMedicion($parametro);
		$res=$obj->eliminarEquipoMedicion();
		return $res;
	}
	/*FinClase: MODEquipoMedicion*/
	
	/*Clase: MODAnalisisMant
	* Fecha: 30-09-2012 21:44:06
	* Autor: admin*/
	function listarAnalisisMant(CTParametro $parametro){
		$obj=new MODAnalisisMant($parametro);
		$res=$obj->listarAnalisisMant();
		return $res;
	}
			
	function insertarAnalisisMant(CTParametro $parametro){
		$obj=new MODAnalisisMant($parametro);
		$res=$obj->insertarAnalisisMant();
		return $res;
	}
			
	function modificarAnalisisMant(CTParametro $parametro){
		$obj=new MODAnalisisMant($parametro);
		$res=$obj->modificarAnalisisMant();
		return $res;
	}
			
	function eliminarAnalisisMant(CTParametro $parametro){
		$obj=new MODAnalisisMant($parametro);
		$res=$obj->eliminarAnalisisMant();
		return $res;
	}
	/*FinClase: MODAnalisisMant*/
	
	/*Clase: MODFuncion
	* Fecha: 30-09-2012 21:50:33
	* Autor: admin*/
	function listarFuncion(CTParametro $parametro){
		$obj=new MODFFuncion($parametro);
		$res=$obj->listarFuncion();
		return $res;
	}
			
	function insertarFuncion(CTParametro $parametro){
		$obj=new MODFFuncion($parametro);
		$res=$obj->insertarFuncion();
		return $res;
	}
			
	function modificarFuncion(CTParametro $parametro){
		$obj=new MODFFuncion($parametro);
		$res=$obj->modificarFuncion();
		return $res;
	}
			
	function eliminarFuncion(CTParametro $parametro){
		$obj=new MODFFuncion($parametro);
		$res=$obj->eliminarFuncion();
		return $res;
	}
	/*FinClase: MODFuncion*/
	
	/*Clase: MODFuncionFalla
	* Fecha: 30-09-2012 21:52:08
	* Autor: admin*/
	function listarFuncionFalla(CTParametro $parametro){
		$obj=new MODFuncionFalla($parametro);
		$res=$obj->listarFuncionFalla();
		return $res;
	}
			
	function insertarFuncionFalla(CTParametro $parametro){
		$obj=new MODFuncionFalla($parametro);
		$res=$obj->insertarFuncionFalla();
		return $res;
	}
			
	function modificarFuncionFalla(CTParametro $parametro){
		$obj=new MODFuncionFalla($parametro);
		$res=$obj->modificarFuncionFalla();
		return $res;
	}
			
	function eliminarFuncionFalla(CTParametro $parametro){
		$obj=new MODFuncionFalla($parametro);
		$res=$obj->eliminarFuncionFalla();
		return $res;
	}
	/*FinClase: MODFuncionFalla*/
	
	/*Clase: MODFallaEvento
	* Fecha: 30-09-2012 21:53:04
	* Autor: admin*/
	function listarFallaEvento(CTParametro $parametro){
		$obj=new MODFallaEvento($parametro);
		$res=$obj->listarFallaEvento();
		return $res;
	}
			
	function insertarFallaEvento(CTParametro $parametro){
		$obj=new MODFallaEvento($parametro);
		$res=$obj->insertarFallaEvento();
		return $res;
	}
			
	function modificarFallaEvento(CTParametro $parametro){
		$obj=new MODFallaEvento($parametro);
		$res=$obj->modificarFallaEvento();
		return $res;
	}
			
	function eliminarFallaEvento(CTParametro $parametro){
		$obj=new MODFallaEvento($parametro);
		$res=$obj->eliminarFallaEvento();
		return $res;
	}
	/*FinClase: MODFallaEvento*/
	
	/*Clase: MODDiagramaDecision
	* Fecha: 02-10-2012 01:25:12
	* Autor: admin*/
	function listarDiagramaDecision(CTParametro $parametro){
		$obj=new MODDiagramaDecision($parametro);
		$res=$obj->listarDiagramaDecision();
		return $res;
	}
			
	function insertarDiagramaDecision(CTParametro $parametro){
		$obj=new MODDiagramaDecision($parametro);
		$res=$obj->insertarDiagramaDecision();
		return $res;
	}
			
	function modificarDiagramaDecision(CTParametro $parametro){
		$obj=new MODDiagramaDecision($parametro);
		$res=$obj->modificarDiagramaDecision();
		return $res;
	}
			
	function eliminarDiagramaDecision(CTParametro $parametro){
		$obj=new MODDiagramaDecision($parametro);
		$res=$obj->eliminarDiagramaDecision();
		return $res;
	}
	/*FinClase: MODDiagramaDecision*/
	
	/*Clase: MODUniConsMantPredef
	* Fecha: 02-11-2012 15:07:12
	* Autor: admin*/
	function listarUniConsMantPredef(CTParametro $parametro){
		$obj=new MODUniConsMantPredef($parametro);
		$res=$obj->listarUniConsMantPredef();
		return $res;
	}
			
	function insertarUniConsMantPredef(CTParametro $parametro){
		$obj=new MODUniConsMantPredef($parametro);
		$res=$obj->insertarUniConsMantPredef();
		return $res;
	}
			
	function modificarUniConsMantPredef(CTParametro $parametro){
		$obj=new MODUniConsMantPredef($parametro);
		$res=$obj->modificarUniConsMantPredef();
		return $res;
	}
			
	function eliminarUniConsMantPredef(CTParametro $parametro){
		$obj=new MODUniConsMantPredef($parametro);
		$res=$obj->eliminarUniConsMantPredef();
		return $res;
	}
	/*FinClase: MODUniConsMantPredef*/
	
	/*Clase: MODCalendarioPlanificado
	* Fecha: 02-11-2012 15:11:40
	* Autor: admin*/
	function listarCalendarioPlanificado(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->listarCalendarioPlanificado();
		return $res;
	}
			
	function insertarCalendarioPlanificado(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->insertarCalendarioPlanificado();
		return $res;
	}
			
	function modificarCalendarioPlanificado(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->modificarCalendarioPlanificado();
		return $res;
	}
			
	function eliminarCalendarioPlanificado(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->eliminarCalendarioPlanificado();
		return $res;
	}
	
	
	function listarMesesCalendario(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->listarMesesCalendario();
		return $res;
	}
	
	function listarMesesCalendarioDet(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->listarMesesCalendarioDet();
		return $res;
	}
	
	function listarCalendarioPlanificadoDet(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->listarCalendarioPlanificadoDet();
		return $res;
	}		
	
	function OtenerCalPla(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->OtenerCalPla();
		return $res;
	}
	
	function UpdateCalPla(CTParametro $parametro){
		$obj=new MODCalendarioPlanificado($parametro);
		$res=$obj->UpdateCalPla();
		return $res;
	}		
	/*FinClase: MODCalendarioPlanificado*/
		
	/*Clase: MODPlanMant
    * Fecha: 12-10-2012 16:15:31
    * Autor: rac*/
    function listarPlanMant(CTParametro $parametro){
        $obj=new MODPlanMant($parametro);
        $res=$obj->listarPlanMant();
        return $res;
    }
            
    function insertarPlanMant(CTParametro $parametro){
        $obj=new MODPlanMant($parametro);
        $res=$obj->insertarPlanMant();
        return $res;
    }
            
    function modificarPlanMant(CTParametro $parametro){
        $obj=new MODPlanMant($parametro);
        $res=$obj->modificarPlanMant();
        return $res;
    }
            
    function eliminarPlanMant(CTParametro $parametro){
        $obj=new MODPlanMant($parametro);
        $res=$obj->eliminarPlanMant();
        return $res;
    }
    /*FinClase: MODPlanMant*/
    
    /*Clase: MODTarea
    * Fecha: 17-10-2012 18:22:11
    * Autor: rac*/
    function listarTarea(CTParametro $parametro){
        $obj=new MODTarea($parametro);
        $res=$obj->listarTarea();
        return $res;
    }
            
    function insertarTarea(CTParametro $parametro){
        $obj=new MODTarea($parametro);
        $res=$obj->insertarTarea();
        return $res;
    }
            
    function modificarTarea(CTParametro $parametro){
        $obj=new MODTarea($parametro);
        $res=$obj->modificarTarea();
        return $res;
    }
            
    function eliminarTarea(CTParametro $parametro){
        $obj=new MODTarea($parametro);
        $res=$obj->eliminarTarea();
        return $res;
    }
    /*FinClase: MODTarea*/
    
    /*Clase: MODUniConsArchivo
    * Fecha: 26-10-2012 18:08:27
    * Autor: rac*/
    function listarUniConsArchivo(CTParametro $parametro){
        $obj=new MODUniConsArchivo($parametro);
        $res=$obj->listarUniConsArchivo();
        return $res;
    }
            
    function insertarUniConsArchivo(CTParametro $parametro){
        $obj=new MODUniConsArchivo($parametro);
        $res=$obj->insertarUniConsArchivo();
        return $res;
    }
            
    function modificarUniConsArchivo(CTParametro $parametro){
        $obj=new MODUniConsArchivo($parametro);
        $res=$obj->modificarUniConsArchivo();
        return $res;
    }
            
    function eliminarUniConsArchivo(CTParametro $parametro){
        $obj=new MODUniConsArchivo($parametro);
        $res=$obj->eliminarUniConsArchivo();
        return $res;
    }
    
    function subirUniConsArchivo(CTParametro $parametro){
        $obj=new MODUniConsArchivo($parametro);
        $res=$obj->subirUniConsArchivo();
        return $res;
    }
    
    function subirVersionUniConsArchivo(CTParametro $parametro){
        $obj=new MODUniConsArchivo($parametro);
        $res=$obj->subirVersionUniConsArchivo();
        return $res;
    }
    
    function listarVersionArchivo(CTParametro $parametro){
        $obj = new MODUniConsArchivo($parametro);
        $res = $obj->listarVersionArchivo();
        return $res;
    }
    /*FinClase: MODUniConsArchivo*/
    
    /*Clase: MODUniConsItem
    * Fecha: 01-11-2012 11:53:15
    * Autor: rac*/
    function listarUniConsItem(CTParametro $parametro){
        $obj=new MODUniConsItem($parametro);
        $res=$obj->listarUniConsItem();
        return $res;
    }
            
    function insertarUniConsItem(CTParametro $parametro){
        $obj=new MODUniConsItem($parametro);
        $res=$obj->insertarUniConsItem();
        return $res;
    }
            
    function modificarUniConsItem(CTParametro $parametro){
        $obj=new MODUniConsItem($parametro);
        $res=$obj->modificarUniConsItem();
        return $res;
    }
            
    function eliminarUniConsItem(CTParametro $parametro){
        $obj=new MODUniConsItem($parametro);
        $res=$obj->eliminarUniConsItem();
        return $res;
    }
    /*FinClase: MODUniConsItem*/
    
    /*Clase: MODUniConsProveedor
    * Fecha: 01-11-2012 14:45:49
    * Autor: rac*/
    function listarUniConsProveedor(CTParametro $parametro){
        $obj=new MODUniConsProveedor($parametro);
        $res=$obj->listarUniConsProveedor();
        return $res;
    }
            
    function insertarUniConsProveedor(CTParametro $parametro){
        $obj=new MODUniConsProveedor($parametro);
        $res=$obj->insertarUniConsProveedor();
        return $res;
    }
            
    function modificarUniConsProveedor(CTParametro $parametro){
        $obj=new MODUniConsProveedor($parametro);
        $res=$obj->modificarUniConsProveedor();
        return $res;
    }
            
    function eliminarUniConsProveedor(CTParametro $parametro){
        $obj=new MODUniConsProveedor($parametro);
        $res=$obj->eliminarUniConsProveedor();
        return $res;
    }
    /*FinClase: MODUniConsProveedor*/
    
    /*Clase: MODModoFalla
    * Fecha: 18-10-2012 04:54:08
    * Autor: Gonzalo Sarmiento Sejas*/
    function listarModoFalla(CTParametro $parametro){
        $obj=new MODModoFalla($parametro);
        $res=$obj->listarModoFalla();
        return $res;
    }
            
    function insertarModoFalla(CTParametro $parametro){
        $obj=new MODModoFalla($parametro);
        $res=$obj->insertarModoFalla();
        return $res;
    }
            
    function modificarModoFalla(CTParametro $parametro){
        $obj=new MODModoFalla($parametro);
        $res=$obj->modificarModoFalla();
        return $res;
    }
            
    function eliminarModoFalla(CTParametro $parametro){
        $obj=new MODModoFalla($parametro);
        $res=$obj->eliminarModoFalla();
        return $res;
    }
    /*FinClase: MODModoFalla*/		

}//marca_generador
?>