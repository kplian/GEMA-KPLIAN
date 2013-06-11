<?php
/**
*@author  aao
*@date 21-12-2012 03:39:00
*@description: métodos de acceso a datos para la tabla Actividad.
*/

class MODUniConsDocTec extends MODbase {
	
	function __construct(CTParametro $pParam) {
		parent::__construct($pParam);
	}
	
	function listarUniConsDocumentoTec() {
		$this->procedimiento='gem.ft_uni_cons_doc_tec_sel';
		$this->transaccion='GEM_UCDOCTEC_SEL';
		$this->tipo_procedimiento='SEL';
		
		$this->setParametro('id_uni_cons','id_uni_cons','varchar');

		$this->captura('id_documento_tec','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_mod','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('fecha_mod','timestamp');
		$this->captura('estado_reg','varchar');
		$this->captura('id_uni_cons','int4');
		$this->captura('nombre_documento','varchar');
		$this->captura('adjunto','boolean');
		$this->captura('codigo','varchar');
		$this->captura('observaciones','varchar');
		
		$this->armarConsulta();
		//echo $this->consulta;exit;
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function insertarUniConsDocumentoTec() {
		$this->procedimiento='gem.ft_uni_cons_doc_tec_ime';
		$this->transaccion='GEM_UCDOCTEC_INS';
		$this->tipo_procedimiento='IME';
		
		$this->setParametro('nombre_documento','nombre_documento','varchar');
		$this->setParametro('adjunto','adjunto','boolean');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function modificarUniConsDocumentoTec() {
		$this->procedimiento='gem.ft_uni_cons_doc_tec_ime';
		$this->transaccion='GEM_UCDOCTEC_MOD';
		$this->tipo_procedimiento='IME';
		
		$this->setParametro('id_documento_tec','id_documento_tec','int4');
		$this->setParametro('nombre_documento','nombre_documento','varchar');
		$this->setParametro('adjunto','adjunto','boolean');
		$this->setParametro('codigo','codigo','varchar');
		$this->setParametro('observaciones','observaciones','varchar');
		$this->setParametro('id_uni_cons','id_uni_cons','int4');
		
		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
	
	function eliminarUniConsDocumentoTec() {
		$this->procedimiento = 'gem.ft_uni_cons_doc_tec_ime';
		$this->transaccion = 'GEM_UCDOCTEC_ELI';
		$this->tipo_procedimiento = 'IME';
		
		$this->setParametro('id_documento_tec','id_documento_tec','int4');

		$this->armarConsulta();
		$this->ejecutarConsulta();
		return $this->respuesta;
	}
}
?>