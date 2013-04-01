<?php
/**
*@package pXP
*@author  aao
*@date 21-12-2012 16:05:00
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>

<script>

Phx.vista.UniConsDocumentoTec=Ext.extend(Phx.gridInterfaz,{
	constructor: function(config) {
		Phx.vista.UniConsDocumentoTec.superclass.constructor.call(this,config);
		this.init();
		this.load({
			params: {
				start: 0,
				limit: 50,
				id_uni_cons: this.id_uni_cons
			}
		});
		this.Atributos[1].valorInicial = this.id_uni_cons;
	},
	Atributos: [
		{
			config:{
					labelSeparator: '',
					inputType: 'hidden',
					name: 'id_documento_tec'
			},
			type: 'Field',
			form: true 
		},
		{
			config: {
					labelSeparator: '',
					inputType: 'hidden',
					name: 'id_uni_cons'
			},
			type: 'Field',
			form: true 
		},
		{
			config: {
				name: 'nombre_documento',
				fieldLabel: 'Documento',
				allowBlank: false,
				width: '100%',
				gwidth: 150,
				maxLength: 150
			},
			type: 'TextField',
			filters: {
				pfiltro: 'doctec.nombre_documento',
				type: 'string'},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'adjunto',
				fieldLabel: 'Adjunto',
				allowBlank: false,
			    triggerAction: 'all',
			    lazyRender: true,
			    forceSelection:true,
			    mode: 'local',
			    store: new Ext.data.ArrayStore({
			    	fields: ['value','nombre'],
					data: [
						['true','Si'], 
						['false','No']
					]
				}),
			    anchor: '100%',
				valueField: 'value',
				displayField: 'nombre',
				renderer: function (value, p, record) {
					if (value == 'true') {
						return String.format('{0}', 'Si');
					} else {
						return String.format('{0}', 'No');
					}
				}
		    },
		    type: 'ComboBox',
		    filters:{	
	       		         type: 'list',
	       		         pfiltro: 'doctec.adjunto',
	       		         options: ['true', 'false']
	       		 	},
		    id_grupo: 0,
		    form: true,
		    grid: true
		},
		{
			config: {
				name: 'codigo',
				fieldLabel: 'Codigo',
				allowBlank: true,
				width: '100%',
				gwidth: 100,
				maxLength: 100,
			},
			type: 'TextField',
			filters: {
				pfiltro: 'doctec.codigo',
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
				pfiltro: 'doctec.observaciones',
				type: 'string'
			},
			id_grupo: 0,
			grid: true,
			form: true
		}
	],

	title: 'Documentacion Tecnica',
	ActSave: '../../sis_mantenimiento/control/UniConsDocumentoTec/guardarUniConsDocumentoTec',
	ActDel: '../../sis_mantenimiento/control/UniConsDocumentoTec/eliminarUniConsDocumentoTec',
	ActList: '../../sis_mantenimiento/control/UniConsDocumentoTec/listarUniConsDocumentoTec',
	id_store: 'id_documento_tec',
	fields: [
		'id_documento_tec',
		'id_usuario_reg',
		'usr_reg',
		'id_usuario_mod',
		'usr_mod',
		'fecha_reg',
		'fecha_mod',
		'estado_reg',
		'id_uni_cons',
		'nombre_documento',
		'adjunto',
		'codigo',
		'observaciones'
	],
	sortInfo:{
		field: 'id_documento_tec',
		direction: 'ASC'
	},
	fheight: 300,
	fwidth: 450,
	bnew: true,
	bdel: true,
	bedit: true,
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		
		