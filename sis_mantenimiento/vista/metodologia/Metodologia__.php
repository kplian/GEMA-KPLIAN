<?php
/**
*@package pXP
*@file gen-Metodologia.php
*@author  (admin)
*@date 17-08-2012 15:52:47
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Metodologia=Ext.extend(Phx.grafInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Metodologia.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
		
	],
	title:'Metodologías de Mantenimiento',
	ActSave:'../../sis_mantenimiento/control/Metodologia/insertarMetodologia',
	ActDel:'../../sis_mantenimiento/control/Metodologia/eliminarMetodologia',
	ActList:'../../sis_mantenimiento/control/Metodologia/listarMetodologia',
	id_store:'id_metodologia',
	fields: [
		{name:'id_metodologia', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_metodologia',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		