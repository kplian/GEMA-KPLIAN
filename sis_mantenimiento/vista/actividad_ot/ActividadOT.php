<?php
/**
*@package pXP
*@author  aao
*@date 20-11-2012 00:22:00
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>

<?php
/**
*@package pXP
*@file ActividadOT.php
*@author KPLIAN (aao)
*@date 14-02-2011
*@description  Vista para registrar  procediemintos
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
			config: {
				name: 'id_usuario_resp',
				fieldLabel: 'Usuario Responsable',
				allowBlank: false,
				emptyText: 'Designe a un responsable...',
				store: new Ext.data.JsonStore({
					url: '../../sis_seguridad/control/Usuario/listarUsuario',
					id: 'id_usuario',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_usuario','desc_person'],
					remoteSort: true,
					baseParams: {par_filtro:'desc_person'}
				}),
				valueField: 'id_usuario',
				displayField: 'desc_person',
				gdisplayField: 'usuario_resp',
				forceSelection: true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 500,
				width: '80%',
				gwidth: 220,
				minChars: 2,
				renderer: function (value, p, record) {
					return String.format('{0}', record.data['usuario_resp']);
					}
			},
			type: 'ComboBox',
			filters: {
				pfiltro: 'acti.id_usuario_resp',
				type: 'string'
			},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config:{
					fieldLabel: 'Estado',
					inputType: 'hidden',
					name: 'estado'
			},
			type: 'Field',
			grid: true,
			form: true
		},
		{
			config: {
				name: 'descripcion',
				fieldLabel: 'Descripcion',
				allowBlank: false,
				anchor: '80%',
				gwidth: 200,
				maxLength: 5000
			},
			type: 'TextArea',
			filters: {
				pfiltro: 'acti.descripcion',
				type: 'string'},
			id_grupo: 1,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 150,
				maxLength: 2000
			},
			type: 'TextArea',
			filters: {
				pfiltro: 'acti.observaciones',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		},
		{
			config:{
				name: 'fecha_plan_ini',
				fieldLabel: 'Fecha Inicio Plan',
				allowBlank: false,
				gwidth: 150,
				format: 'd/m/Y'
			},
			type: 'DateField',
			filters: {
				pfiltro:'acti.fecha_plan_ini',
				type:'date'
			},
			id_grupo: 1,
			grid: true,
			form: true
		},
		{
			config:{
				name: 'fecha_plan_fin',
				fieldLabel: 'Fecha Fin Plan',
				allowBlank: false,
				gwidth: 150,
				format: 'd/m/Y'
			},
			type: 'DateField',
			filters: {
				pfiltro: 'acti.fecha_plan_fin',
				type: 'date'
			},
			id_grupo: 1,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'fecha_eje_ini',
				fieldLabel: 'Fecha Inicio Ejec.',
				allowBlank: true,
				gwidth: 150,
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
				fieldLabel: 'Fecha Fin Ejec.',
				allowBlank: true,
				gwidth: 150,
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
		{name: 'fecha_plan_ini', type: 'timestamp'},
		{name: 'fecha_plan_fin', type: 'timestamp'},
		{name: 'fecha_eje_ini', type: 'timestamp'},
		{name: 'fecha_eje_fin', type: 'timestamp'}
	],
	sortInfo:{
		field: 'id_actividad',
		direction: 'ASC'
	},
	onButtonNew:function() {
		Phx.vista.actividad.superclass.onButtonNew.call(this);
		this.getComponente('id_orden_trabajo').setValue(this.id_orden_trabajo);
	},
	constructor: function(config) {
		Phx.vista.actividad.superclass.constructor.call(this,config);
		this.init();
		this.load({
			params: {
				start: 0,
				limit: 50,
				id_orden_trabajo: this.id_orden_trabajo
			}
		})
	},
	bdel: true,
	bsave: false,

	preparaMenu:function(tb) {
		//llamada procedimiento clace padre
		Phx.vista.actividad.superclass.preparaMenu.call(this,tb)
	}
  }
)
</script>
		
		