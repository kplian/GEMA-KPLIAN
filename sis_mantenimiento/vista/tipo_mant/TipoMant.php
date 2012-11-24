<?php
/**
*@package pXP
*@file gen-TipoMant.php
*@author  (admin)
*@date 17-08-2012 12:04:43
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoMant=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoMant.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_mant'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'tipo',
				fieldLabel: 'Tipo',
				allowBlank: false,
			    triggerAction: 'all',
			    lazyRender:true,
			    mode: 'local',
			    gwidth:120,
			    store: new Ext.data.ArrayStore({
			    	fields: ['codigo','nombre'],
					data: [['planificado','Planificado'], ['no_planificado','No Planificado']]
				}),
				valueField:'codigo',
				displayField: 'nombre',
				renderer: function(value,p,record){
					if(value=='planificado'){
						return 'Planificado';
					} else{
						return 'No Planificado';
					}
				}
		    },
		    type:'ComboBox',
		    filters:{pfiltro:'getima.tipo',type:'string'},
		    id_grupo:1,
		    form:true,
		    grid:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'getima.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: false,
				anchor: '80%',
				gwidth: 200,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'getima.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'getima.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'getima.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'getima.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Tipo de Mantenimiento',
	ActSave:'../../sis_mantenimiento/control/TipoMant/insertarTipoMant',
	ActDel:'../../sis_mantenimiento/control/TipoMant/eliminarTipoMant',
	ActList:'../../sis_mantenimiento/control/TipoMant/listarTipoMant',
	id_store:'id_tipo_mant',
	fields: [
		{name:'id_tipo_mant', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'tipo', type: 'string'}
	],
	sortInfo:{
		field: 'id_tipo_mant',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		