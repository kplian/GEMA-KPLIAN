<?php
/**
*@package pXP
*@file gen-OrdenTrabajoSol.php
*@author  (admin)
*@date 02-01-2013 15:59:36
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.OrdenTrabajoSol=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.OrdenTrabajoSol.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}});
		
		this.addButton('btn-fin',
			{
				text: 'Solicitar OT',
				iconCls: 'bok',
				disabled: true,
				handler: this.solOT,
				tooltip: '<b>Envía la petición de generación de una Orden de Trabajo</b>'
			}
		);
		
		this.addButton('btn-reporte',{
            text:'Reporte OT Solicitado',
            iconCls: 'bpdf32',
            disabled: true,
            handler:function() {
                var rec=this.sm.getSelected();
                console.debug(rec);
                Phx.CP.loadingShow();
                Ext.Ajax.request({
                    url:'../../sis_mantenimiento/control/OrdenTrabajoSol/reporteOTSolicitado',
                    params:{'id_orden_trabajo_sol': rec.data.id_orden_trabajo_sol},
                    success: this.successExport,
                    failure: this.conexionFailure,
                    timeout: this.timeout,
                    scope:this
                });
            },
            tooltip: '<b>Reporte OIT</b><br/>Generar el reporte de la Orden de Trabajo Solicitada.'
        });
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_orden_trabajo_sol'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'fecha',
				fieldLabel: 'Fecha',
				allowBlank: true,
				gwidth: 100,
				format: 'd/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'solord.fecha',type:'date'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'id_solicitante',
				fieldLabel: 'Solicitado por',
				anchor: '90%',
				tinit: true,
				allowBlank: false,
				origen: 'FUNCIONARIOCAR',
				gdisplayField: 'desc_solicitante',
				gwidth: 200,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_solicitante']);
				}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters: {
				pfiltro: 'nombre_completo1#nombre_completo2',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'fecha_requerida',
				fieldLabel: 'Fecha Requerida',
				allowBlank: true,
				gwidth: 100,
				format: 'd/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'solord.fecha_requerida',type:'date'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'id_localizacion',
				fieldLabel: 'Localización',
				typeAhead: false,
				forceSelection: false,
				allowBlank: false,
				emptyText: 'Localizaciones...',
				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/Localizacion/listarLocalizacion',
					id: 'id_localizacion',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_localizacion', 'codigo', 'nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {
						par_filtro: 'tuc.codigo#tuc.codigo'
					}
				}),
				valueField: 'id_localizacion',
				displayField: 'nombre',
				gdisplayField: 'desc_localizacion',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				anchor: '100%',
				minChars: 2,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_localizacion']);
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo}</p><p>{nombre}</p> </div></tpl>'
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'codigo#nombre',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_uni_cons',
				fieldLabel: 'Equipo',
				typeAhead: false,
				forceSelection: false,
				allowBlank: false,
				emptyText: 'Equipos...',
				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/UniCons/listarUniConsPlano',
					id: 'id_uni_cons',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_uni_cons', 'codigo', 'nombre', 'tipo','nombre_tipo_equipo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {
						par_filtro: 'tuc.codigo#tuc.codigo'
					}
				}),
				valueField: 'id_uni_cons',
				displayField: 'nombre',
				gdisplayField: 'desc_equipo',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				anchor: '100%',
				minChars: 2,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_equipo']);
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo}</p><p>{nombre}</p> </div></tpl>'
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'codigo#nombre',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'observacion',
				fieldLabel: 'Observación',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'solord.observacion',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'solord.descripcion',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},	
		{
			config: {
				name: 'id_responsable',
				fieldLabel: 'Responsable',
				anchor: '90%',
				tinit: true,
				allowBlank: false,
				origen: 'FUNCIONARIOCAR',
				gdisplayField: 'desc_responsable',
				gwidth: 200,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_responsable']);
				}
			},
			type: 'ComboRec',
			id_grupo: 2,
			filters: {
				pfiltro: 'nombre_completo1#nombre_completo2',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_unidad_medida_req',
				fieldLabel: 'Unidad Medida',
				allowBlank: false,
				origen: 'UNIDADMEDIDA',
				gdisplayField: 'desc_unidad_medida',
				gwidth: 200,
				renderer:function(value, p, record){return String.format('{0}', record.data['desc_unidad_medida']);},
				anchor: '100%'
			},
			type: 'ComboRec',
			id_grupo: 1,
			filters:{pfiltro:'gemapr.tipo',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_uo',
				fieldLabel: 'Unidad Org.',
				allowBlank: false,
				origen: 'UO',
				gdisplayField: 'desc_uo',
				gwidth: 200,
				renderer:function(value, p, record){return String.format('{0}', record.data['desc_uo']);},
				anchor: '100%'
			},
			type: 'ComboRec',
			id_grupo: 2,
			filters:{pfiltro:'gemapr.tipo',type:'string'},
			grid: true,
			form: true
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_orden_trabajo',
					fieldLabel: 'Orden de Trabajo',
			},
			type:'Field',
			filters:{pfiltro:'solord.id_orden_trabajo',type:'numeric'},
			form:true,
			id_grupo:1,
			grid:true 
		},
		{
			config:{
				name: 'rg_inspeccion_lugar',
				fieldLabel: 'Lugar Inspeccionado?',
				anchor: '80%',
				gwidth: 100,
				maxLength:10,
				items: [
	                {boxLabel: 'Si', name: 'rg-auto', inputValue: 'si', checked:true},
	                {boxLabel: 'No', name: 'rg-auto', inputValue: 'no'} //, checked: true}
            	]/*,
            	listeners:[{
            		change: function(newVal,oldVal){
            			alert('awesome');
            		}
            	}
            	]*/
			},
			type:'RadioGroup',
			filters:{pfiltro:'pritse.estado_reg',type:'string'},
			id_grupo:0,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'fecha_estimada',
				fieldLabel: 'Fecha Estimada',
				allowBlank: true,
				gwidth: 100,
				format: 'd/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'solord.fecha_estimada',type:'date'},
			id_grupo:3,
			grid:true,
			form:true
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					fieldLabel: 'Estado',
					name: 'estado'
			},
			type:'Field',
			filters:{pfiltro:'solord.estado',type:'string'},
			id_grupo:1,
			grid: true,
			form:true 
		},
		{
			config:{
				name: 'nota',
				fieldLabel: 'Nota',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'solord.nota',type:'string'},
			id_grupo:2,
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'descripcion_req',
				fieldLabel: 'Descripción Req.',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'solord.descripcion_req',type:'string'},
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
			filters:{pfiltro:'solord.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'rg_inspeccion_exacto',
				fieldLabel: 'Inspección Exacta?',
				anchor: '80%',
				gwidth: 100,
				maxLength:10,
				items: [
	                {boxLabel: 'Si', name: 'rg-auto1', inputValue: 'si', checked:true},
	                {boxLabel: 'No', name: 'rg-auto1', inputValue: 'no'} //, checked: true}
            	]/*,
            	listeners:[{
            		change: function(newVal,oldVal){
            			alert('awesome');
            		}
            	}
            	]*/
			},
			type:'RadioGroup',
			filters:{pfiltro:'pritse.estado_reg',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cantidad_req',
				fieldLabel: 'Cantidad Req.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'solord.cantidad_req',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'importancia',
				fieldLabel: 'Importancia',
				anchor: '90%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 200,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'torden_trabajo_sol__importancia'
					}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'solord.importancia',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'fecha_real',
				fieldLabel: 'Fecha Real',
				allowBlank: true,
				gwidth: 100,
				format: 'd/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'solord.fecha_real',type:'date'},
			id_grupo:3,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'observaciones_resp',
				fieldLabel: 'Observaciones Resp.',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'solord.observaciones_resp',type:'string'},
			id_grupo:3,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_recepcion',
				fieldLabel: 'Fecha Recepción',
				allowBlank: true,
				gwidth: 100,
				format: 'd/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'solord.fecha_recepcion',type:'date'},
			id_grupo:2,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'prioridad',
				fieldLabel: 'Prioridad',
				anchor: '90%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 200,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'torden_trabajo_sol__prioridad'
					}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'solord.prioridad',type:'string'},
			grid: true,
			form: true
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
			filters:{pfiltro:'solord.fecha_reg',type:'date'},
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
			filters:{pfiltro:'solord.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Solicitud de Orden de Trabajo',
	ActSave:'../../sis_mantenimiento/control/OrdenTrabajoSol/insertarOrdenTrabajoSol',
	ActDel:'../../sis_mantenimiento/control/OrdenTrabajoSol/eliminarOrdenTrabajoSol',
	ActList:'../../sis_mantenimiento/control/OrdenTrabajoSol/listarOrdenTrabajoSol',
	id_store:'id_orden_trabajo_sol',
	fields: [
		{name:'id_orden_trabajo_sol', type: 'numeric'},
		{name:'id_solicitante', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'id_responsable', type: 'numeric'},
		{name:'id_unidad_medida_req', type: 'numeric'},
		{name:'id_uo', type: 'numeric'},
		{name:'id_localizacion', type: 'numeric'},
		{name:'id_orden_trabajo', type: 'numeric'},
		{name:'inspeccion_lugar', type: 'string'},
		{name:'fecha_estimada', type: 'date', dateFormat:'Y-m-d'},
		{name:'estado', type: 'string'},
		{name:'nota', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'descripcion_req', type: 'string'},
		{name:'fecha_requerida', type: 'date', dateFormat:'Y-m-d'},
		{name:'estado_reg', type: 'string'},
		{name:'inspeccion_exacto', type: 'string'},
		{name:'cantidad_req', type: 'numeric'},
		{name:'importancia', type: 'string'},
		{name:'fecha_real', type: 'date', dateFormat:'Y-m-d'},
		{name:'observaciones_resp', type: 'string'},
		{name:'fecha_recepcion', type: 'date', dateFormat:'Y-m-d'},
		{name:'observacion', type: 'string'},
		{name:'prioridad', type: 'string'},
		{name:'fecha', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'desc_solicitante',
		'desc_localizacion',
		'desc_equipo',
		'desc_responsable',
		'desc_unidad_medida',
		'desc_uo'
		
	],
	onButtonEdit:function(){
		/*var datos=this.sm.getSelected().data;
		var rbtIl = this.getComponente('rg_inspeccion_lugar');
		var rbtIe = this.getComponente('rg_inspeccion_exacto');
		
		array = rbtIl.items;
		console.log(rbtIe.items[0]);
		console.log(rbtIe.items[1]);

		ss=rbtIe.items[0];
		ss.setValue(true);*/
		/*rbtIe.items[0].setValue(true);
		rbtIe.items[1].setValue(false);*/
		/*if(datos.inspeccion_lugar=='si'){
			rbtIl.items[0].checked=true;
		}
		if(datos.inspeccion_exacto=='si'){
			rbtIe.items[0].checked=true;
		}*/
		
		Phx.vista.OrdenTrabajoSol.superclass.onButtonEdit.call(this); //sobrecarga enable select
	},
	sortInfo:{
		field: 'id_orden_trabajo_sol',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	fheight: '95%',
    fwidth: '95%',
	Grupos:[{ 
		layout: 'column',
		items:[   
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Cabecera Solicitud',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 0.5,
                items:[],
		        id_grupo:0,
		        collapsible:true
			},
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Insumos requeridos',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 0.5,
                items:[],
		        id_grupo:1,
		        collapsible:true,
		        collapsed:false
			},
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Observaciones Jefe de Mantenimiento',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 0.5,
                items:[],
		        id_grupo:2,
		        collapsible:true,
		        collapsed:false
			},
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Observaciones Responsable',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 0.5,
                items:[],
		        id_grupo:3,
		        collapsible:true,
		        collapsed:false
			}
			]
		}],
	agregarArgsExtraSubmit: function(){
		//Inicializa el objeto de los argumentos extra
		this.argumentExtraSubmit={};

		//Obtiene los valores dinámicos
		var rbt = this.getComponente('rg_inspeccion_lugar');
		var array = [];
		var tmp;

		array = rbt.items;
		
		//Evaluate the radio checked and asign a valur for the variable
		if(array.items[0].checked){
			tmp='si';
		} else{
			tmp='no';
		}
		this.argumentExtraSubmit.inspeccion_lugar=tmp;
		
		rbt = this.getComponente('rg_inspeccion_exacto');
		array = rbt.items;
		
		//Evaluate the radio checked and asign a valur for the variable
		if(array.items[0].checked){
			tmp='si';
		} else{
			tmp='no';
		}

		//Añade los parámetros extra para mandar por submit
		this.argumentExtraSubmit.inspeccion_exacto=tmp;
	},
	solOT: function() {
		var rec = this.sm.getSelected();
		var data = rec.data;
		Ext.Ajax.request({
			url:'../../sis_mantenimiento/control/OrdenTrabajoSol/finalizarOrdenTrabajoSol',
			params: {
				'id_orden_trabajo_sol': data.id_orden_trabajo_sol
			},
			success:this.successSave,
			failure: this.conexionFailure,
			timeout:this.timeout,
			scope:this
		});
	},
	preparaMenu: function(n) {
		var tb = Phx.vista.OrdenTrabajoSol.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	this.getBoton('btn-fin').setDisabled(false);
	  	this.getBoton('btn-reporte').setDisabled(false);
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.OrdenTrabajoSol.superclass.liberaMenu.call(this);
		this.getBoton('btn-fin').setDisabled(true);
		this.getBoton('btn-reporte').setDisabled(true);
		return tb;
	},
	south:{
		  url:'../../../sis_mantenimiento/vista/orden_trabajo_sol_insumo/OrdenTrabajoSolInsumo.php',
		  title:'Insumos', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'OrdenTrabajoSolInsumo'
	}
})
</script>