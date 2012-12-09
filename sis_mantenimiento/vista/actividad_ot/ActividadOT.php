<?php
/**
*@package pXP
*@author  aao
*@date 20-11-2012 00:22:00
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>

<script>

Phx.vista.actividad=Ext.extend(Phx.gridInterfaz,{

	Atributos: [
		{
			config:{
					labelSeparator: '',
					inputType: 'hidden',
					name: 'id_actividad'
			},
			type: 'Field',
			form: true 
		},
		{
			config: {
					labelSeparator: '',
					inputType: 'hidden',
					name: 'id_orden_trabajo'
			},
			type: 'Field',
			form: true 
		},
		{
	   		config:{
	       		    name: 'id_usuario_resp',
	   				origen: 'USUARIO',
	   				tinit: true,
	   				fieldLabel: 'Usuario Responsable',
	   				gdisplayField: 'desc_person',//mapea al store del grid
	   			    gwidth: 220,
	   			    anchor: '100%',
		   			renderer: function (value, p, record){return String.format('{0}', record.data['usuario_resp']);}
	       	     },
	   			type: 'ComboRec',
	   			id_grupo: 0,
	   			filters:{	
			        pfiltro: 'PERSON.nombre_completo1',
					type: 'string'
				},
	   			grid: true,
	   			form: true
	   	},
		{
			config:{
					labelSeparator: '',
					inputType: 'hidden',
					name: 'estado',
					value: 'pendiente'
			},
			type: 'Field',
			form: true
		},
		{
			config: {
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
			    triggerAction: 'all',
			    lazyRender: true,
			    mode: 'local',
			    gwidth: 120,
			    store: new Ext.data.ArrayStore({
			    	fields: ['codigo','nombre'],
					data: [
						['pendiente','Pendiente'], 
						['finalizado','Finalizado']
					]
				}),
				valueField: 'codigo',
				displayField: 'nombre',
				renderer: function(value, p, record) {
					if(value == 'finalizado') {
						return 'Finalizado';
					} else {
						return 'Pendiente';
					}
				}
		    },
		    type: 'ComboBox',
		    egrid: true,
		    filters: {
		    	pfiltro: 'acti.estado', 
		    	type:'string'
		   	},
		    form: false,
		    grid: true
		},
		{
			config: {
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: false,
				width: '100%',
				gwidth: 200,
				maxLength: 5000
			},
			type: 'TextArea',
			filters: {
				pfiltro: 'acti.descripcion',
				type: 'string'},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				width: '100%',
				gwidth: 150,
				maxLength: 2000
			},
			type: 'TextArea',
			filters: {
				pfiltro: 'acti.observaciones',
				type: 'string'
			},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config:{
				name: 'fecha_plan_ini',
				fieldLabel: 'Fecha Inicio Planificación',
				allowBlank: false,
				gwidth: 150,
				renderer:function (value, p, record) {
					return value?value.dateFormat('d/m/Y'):''
				},
				format: 'd/m/Y'
			},
			type: 'DateField',
			filters: {
				pfiltro:'acti.fecha_plan_ini',
				type:'date'
			},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config:{
				name: 'fecha_plan_fin',
				fieldLabel: 'Fecha Fin Planificación',
				allowBlank: false,
				gwidth: 150,
				renderer:function (value, p, record) {
					return value?value.dateFormat('d/m/Y'):''
				},
				format: 'd/m/Y'
			},
			type: 'DateField',
			filters: {
				pfiltro: 'acti.fecha_plan_fin',
				type: 'date'
			},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'fecha_eje_ini',
				fieldLabel: 'Fecha Inicio Ejecución',
				allowBlank: true,
				gwidth: 150,
				renderer:function (value, p, record) {
					return value?value.dateFormat('d/m/Y'):''
				},
				format: 'd/m/Y'
			},
			type: 'DateField',
			filters: {
				pfiltro: 'acti.fecha_eje_ini',
				type: 'date'
				},
			id_grupo: 1,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'fecha_eje_fin',
				fieldLabel: 'Fecha Fin Ejecución',
				allowBlank: true,
				gwidth: 150,
				renderer:function (value, p, record) {
					return value?value.dateFormat('d/m/Y'):''
				},
				format: 'd/m/Y'
			},
			type: 'DateField',
			filters: {
				pfiltro: 'acti.fecha_eje_fin',
				type: 'date'
			},
			id_grupo: 1,
			grid: true,
			form: true
		}
	],
	title: 'Actividad',
	ActSave: '../../sis_mantenimiento/control/ActividadOT/guardarActividadOT',
	ActDel: '../../sis_mantenimiento/control/ActividadOT/eliminarActividadOT',
	ActList: '../../sis_mantenimiento/control/ActividadOT/listarActividadOT',
	id_store: 'id_actividad',
	fields: [
		{name: 'id_actividad', type: 'numeric'},
		{name: 'id_usuario_reg', type: 'numeric'},
		{name: 'usr_reg', type: 'string'},
		{name: 'id_usuario_mod', type: 'numeric'},
		{name: 'usr_mod', type: 'string'},
		{name: 'fecha_reg', type: 'timestamp'},
		{name: 'fecha_mod', type: 'timestamp'},
		{name: 'estado_reg', type: 'string'},
		{name: 'id_orden_trabajo', type: 'numeric'},
		{name: 'orden_trabajo', type: 'varchar'},
		{name: 'id_usuario_resp', type: 'numeric'},
		{name: 'usuario_resp', type: 'varchar'},
		{name: 'estado', type: 'varchar'},
		{name: 'descripcion', type: 'varchar'},
		{name: 'observaciones', type: 'varchar'},
		{name: 'fecha_plan_ini', type: 'date', dateFormat:'Y-m-d'},
		{name: 'fecha_plan_fin', type: 'date', dateFormat:'Y-m-d'},
		{name: 'fecha_eje_ini', type: 'date', dateFormat:'Y-m-d'},
		{name: 'fecha_eje_fin', type: 'date', dateFormat:'Y-m-d'},
	],
	sortInfo:{
		field: 'id_actividad',
		direction: 'ASC'
	},
	constructor: function(config) {
		showSouth = true;
		modificarActividades = false;
		if(config.nombreVista == "registrarOT") {
			showSouth = false;
			if(config.cat_estado == "Borrador") {
				modificarActividades = true;
			}
		} else if(config.nombreVista == "ejecutarOT") {
			if(config.cat_estado == "Pendiente") {
				showSouth = false;
			}
		}
		
		if(showSouth) {
			this.south = {
				url:'../../../sis_mantenimiento/vista/recurso/Recurso.php',
				title:'Recurso',
				height: 300,
				cls:'recurso',
				params: {
					nombreVista: config.nombreVista
				}
			};
		}
		this.bnew = modificarActividades;
		this.bdel = modificarActividades;
		this.bedit = modificarActividades;
		this.bsave = modificarActividades;
		Phx.vista.actividad.superclass.constructor.call(this,config);
		this.init();
		this.load({
			params: {
				start: 0,
				limit: 50,
				id_orden_trabajo: this.id_orden_trabajo
			}
		});
		this.Atributos[1].valorInicial = this.id_orden_trabajo;
	},
	Grupos: [{ 
		layout: 'column',
		items:[
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Planificación',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 1,
                items:[],
		        id_grupo:0,
		        collapsible:true
			},
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Ejecución',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 1,
                items:[],
		        id_grupo:1,
		        collapsible:true,
		        collapsed:false
			},
		]
	}],
	fheight: 500,
	fwidth:500,
	preparaMenu:function(tb) {
		//llamada procedimiento clace padre
		Phx.vista.actividad.superclass.preparaMenu.call(this,tb)
	}
  }
)
</script>
		
		