<?php
/**
*@package pXP
*@file 
*@author RCM 
*@date 11/05/2013
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Instructivo = {
	require:'../../../sis_mantenimiento/vista/documento/Documento.php',
	requireclase:'Phx.vista.Documento',
	title:'Instructivos',
	tipo_doc: 'instructivo',
	constructor: function(config) {
		Phx.vista.Instructivo.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0,limit:50,tipo_doc:this.tipo_doc}});
	},
	agregarArgsExtraSubmit: function(){
		//Inicializa el objeto de los argumentos extra
		this.argumentExtraSubmit={};
		//Añade los parámetros extra para mandar por submit
		this.argumentExtraSubmit.tipo_doc=this.tipo_doc;
	}
};
</script>
