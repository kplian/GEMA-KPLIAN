<?php
/**
*@package pXP
*@file gen-AriableGlobal.php
*@author  (admin)
*@date 14-01-2013 17:19:57
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AriableGlobal=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.AriableGlobal.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_variable_global'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'variable',
				fieldLabel: 'variable',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'aaa.variable',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'valor',
				fieldLabel: 'valor',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'aaa.valor',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'aaa.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		}
	],
	
	title:'aaa',
	ActSave:'../../sis_FRAMEWORK/control/AriableGlobal/insertarAriableGlobal',
	ActDel:'../../sis_FRAMEWORK/control/AriableGlobal/eliminarAriableGlobal',
	ActList:'../../sis_FRAMEWORK/control/AriableGlobal/listarAriableGlobal',
	id_store:'id_variable_global',
	fields: [
		{name:'id_variable_global', type: 'numeric'},
		{name:'variable', type: 'string'},
		{name:'valor', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_variable_global',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		