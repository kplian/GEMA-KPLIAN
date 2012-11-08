<?php
/**
*@package       pXP
*@file          gen-MODUniConsArchivo.php
*@author        (rac)
*@date          26-10-2012 18:08:27
*@description   Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODUniConsArchivo extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarUniConsArchivo(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='gem.ft_uni_cons_archivo_sel';
		$this->transaccion='GEM_UNIDOC_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
		
		$_SESSION["ARCHIVO"]=array();
		//Definicion de la lista del resultado del query
		$this->captura('id_uni_cons_archivo','int4');
		$this->captura('id_uni_cons_archivo_padre','int4');
		$this->captura('extension','varchar');
		$this->captura('resumen','varchar');
		$this->captura('palabras_clave','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('codigo','varchar');
		$this->captura('nombre','varchar');
		$this->captura('archivo','bytea','id_uni_cons_archivo','extension','archivo','../../../sis_mantenimiento/control/archivos_uni_cons/');
		$this->captura('nombre_archivo','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarUniConsArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_uni_cons_archivo_ime';
		$this->transaccion='GEM_UNIDOC_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_archivo_padre','id_uni_cons_archivo_padre','int4');
		$this->setParametro('extension','extension','varchar');
		$this->setParametro('resumen','resumen','varchar');
		$this->setParametro('palabras_clave','palabras_clave','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('archivo','archivo','bytea');
		$this->setParametro('nombre_archivo','nombre_archivo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarUniConsArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_uni_cons_archivo_ime';
		$this->transaccion='GEM_UNIDOC_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_archivo','id_uni_cons_archivo','int4');
		$this->setParametro('id_uni_cons_archivo_padre','id_uni_cons_archivo_padre','int4');
		$this->setParametro('extension','extension','varchar');
		$this->setParametro('resumen','resumen','varchar');
		$this->setParametro('palabras_clave','palabras_clave','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('nombre','nombre','varchar');
		$this->setParametro('archivo','archivo','bytea');
		$this->setParametro('nombre_archivo','nombre_archivo','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarUniConsArchivo(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='gem.ft_uni_cons_archivo_ime';
		$this->transaccion='GEM_UNIDOC_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_uni_cons_archivo','id_uni_cons_archivo','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
	
    function subirUniConsArchivo(){
        $this->procedimiento='gem.ft_uni_cons_archivo_ime';
        $this->transaccion='GEM_UPARCH_MOD';
        $this->tipo_procedimiento='IME';
        
        $ext = pathinfo($this->arregloFiles['archivo']['name']);
        $this->arreglo['extension']= $ext['extension'];
        
        //Define los parametros para la funcion 
        $this->setParametro('id_uni_cons_archivo','id_uni_cons_archivo','integer');   
        $this->setParametro('extension','extension','varchar');
        $this->setParametro('archivo','archivo','bytea',false,'',false,array('doc','pdf','docx'));
                
        
        //Ejecuta la instruccion
        $this->armarConsulta();
                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
    
    function subirVersionUniConsArchivo(){
        $this->procedimiento='gem.ft_uni_cons_archivo_ime';
        $this->transaccion='GEM_UPARCHVER_MOD';
        $this->tipo_procedimiento='IME';
        
        $ext = pathinfo($this->arregloFiles['archivo']['name']);
        $this->arreglo['extension']= $ext['extension'];
        
        //Define los parametros para la funcion 
        $this->setParametro('id_uni_cons_archivo','id_uni_cons_archivo','integer');   
        $this->setParametro('extension','extension','varchar');
        $this->setParametro('archivo','archivo','bytea',false,'',false,array('doc','pdf','docx'));
                        
        //Ejecuta la instruccion
        $this->armarConsulta();
                
        $this->ejecutarConsulta();
        return $this->respuesta;
    }
    
    function listarVersionArchivo(){
        $this->procedimiento = 'gem.ft_uni_cons_archivo_sel';
        $this->transaccion = 'GEM_ARCHVER_SEL';
        $this->tipo_procedimiento = 'SEL';
        $this->setCount(false);
        
        $this->setParametro('id_uni_cons_archivo','id_uni_cons_archivo','int4');
        
        $_SESSION["ARCHIVO"]=array();
        //Definicion de la lista del resultado del query
        $this->captura('id_uni_cons_archivo','int4');
        $this->captura('id_uni_cons_archivo_padre','int4');
        $this->captura('extension','varchar');
        $this->captura('resumen','varchar');
        $this->captura('palabras_clave','varchar');
        $this->captura('estado_reg','varchar');
        $this->captura('codigo','varchar');
        $this->captura('nombre','varchar');
        $this->captura('archivo','bytea','id_uni_cons_archivo','extension','archivo','../../../sis_mantenimiento/control/archivos_uni_cons/');
        $this->captura('nombre_archivo','varchar');
        $this->captura('fecha_reg','timestamp');
        $this->captura('id_usuario_reg','int4');
        $this->captura('id_usuario_mod','int4');
        $this->captura('fecha_mod','timestamp');
        $this->captura('usr_reg','varchar');
        $this->captura('usr_mod','varchar');
        
        //Ejecuta la instruccion
        $this->armarConsulta();
        $this->ejecutarConsulta();
        
        //Devuelve la respuesta
        return $this->respuesta;      
    }
		
}
?>