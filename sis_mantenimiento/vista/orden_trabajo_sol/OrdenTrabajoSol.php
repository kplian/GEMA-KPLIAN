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
		this.load({params:{start:0, limit:50, estado:this.estado}});
		
		//Oculta el grupo de los insumos que ya es obsoleto
		this.ocultarGrupo(1);
		
		this.readOnlyGroup(1, true);
		this.readOnlyGroup(2, true);
		this.readOnlyGroup(3, true);
		this.blockGroup(1);
		this.blockGroup(2);
		this.blockGroup(3);
		
		//Evento para cargar la localizacion a partir del equipo
		this.getComponente('id_localizacion_buscar').on('select', function(e, data, index) {
	        	this.getComponente('id_uni_cons').setValue('');
	        	this.getComponente('id_uni_cons').store.baseParams.id_localizacion=this.getComponente('id_localizacion_buscar').value;
	        	this.getComponente('id_uni_cons').modificado=true;
        },this);
        
        this.getComponente('id_uni_cons').on('select', function(e, data, index) {
			this.getComponente('id_localizacion').setValue(data.data.id_localizacion);
			this.getComponente('id_localizacion').setRawValue(data.data.desc_localizacion);
		},this);
		
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
        
        this.addButton('btn-subirFoto',{
        	text:'Subir Foto',
        	iconCls: 'baddphoto',
        	disabled:true,
        	handler: function(){
        		var rec=this.sm.getSelected();
        		Phx.CP.loadWindows('../../../sis_mantenimiento/vista/orden_trabajo_sol/SubirArchivoOTSol.php',
				'Subir foto',
				{
					modal:true,
					width:400,
					height:150
			    },rec.data,this.idContenedor,'SubirArchivoOTSol')
        	},
        	tooltip: '<b>Subir Foto</b><br/>Permite subir foto con detalles de la falla',
        	scope:this
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
				name: 'fecha',
				fieldLabel: 'Fecha',
				allowBlank: false,
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
			config:{
				name: 'nro_sol',
				fieldLabel: 'Nro.Sol.',
				allowBlank: true,
				gwidth: 100
			},
			type:'Field',
			filters:{pfiltro:'solord.nro_sol',type:'string'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{
			config: {
				name: 'id_solicitante',
				fieldLabel: 'Solicitado por',
				anchor: '90%',
				tinit: true,
				allowBlank: false,
				origen: 'FUNCIONARIO',
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
				allowBlank: false,
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
			config:{	
				name:'id_localizacion_buscar',
    			tinit:true,
    			tasignacion:true,
    			tname:'id_localizacion',
    			tdisplayField:'nombre',
    			turl:'../../../sis_mantenimiento/vista/localizacion/LocalizacionLista.php',
	   			ttitle:'Localizaciones',
	   			tdata:{},
	   			tcls:'LocalizacionLista',
	   			pid:this.idContenedor,
	   			fieldLabel:'Buscar Equipo x Localización}',
	   			allowBlank:true,
	   			emptyText:'Buscar Equipo po Localización ...',
	   			store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/Localizacion/listarLocalizacion',
					id: 'id_localizacion',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_localizacion','codigo','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre#codigo'}
				}),
	   			tpl:'<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p></div></tpl>',
				valueField: 'id_localizacion',
				hiddenValue: 'id_localizacion',
				hiddenName:'id_localizacion_buscar',
				displayField: 'nombre',
				gdisplayField: 'nombre_localizacion',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_localizacion']);},
				autoSelect:true
    		},
			type:'TrigguerCombo',
			filters:{pfiltro:'local.nombre',type:'string'},
			id_grupo:0,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'id_uni_cons',
				fieldLabel: 'Equipo',
				allowBlank: false,
				emptyText:'Elija un equipo...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/UniCons/listarUniConsPlanoDos',
					id: 'id_uni_cons',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_uni_cons','codigo','nombre','nombre_tipo_equipo','padres_loc', 'id_localizacion','desc_localizacion'],
					remoteSort: true,
					baseParams:{par_filtro:'tuc.nombre#tuc.codigo#eq.nombre'}
				}),
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Tipo Equipo: {nombre_tipo_equipo}</p><p>Localización: {padres_loc}</p></div></tpl>',
				valueField: 'id_uni_cons',
				hiddenValue: 'id_uni_cons',
				displayField: 'codigo',
				gdisplayField:'desc_equipo',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth: 350,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_equipo']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'unicons.nombre#unicons.codigo',type:'string'},
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
						par_filtro: 'nombre#codigo'
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
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo}</p><p>{nombre}</p> </div></tpl>',
				disabled:true
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
				fieldLabel: 'Observación/Falla',
				allowBlank: false,
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
				fieldLabel: 'Acción a realizar',
				allowBlank: false,
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
				fieldLabel: 'Responsable Elaboración OIT-OTT',
				anchor: '90%',
				tinit: true,
				allowBlank: true,
				origen: 'FUNCIONARIO',
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
				allowBlank: true,
				origen: 'UNIDADMEDIDA',
				gdisplayField: 'desc_unidad_medida',
				gwidth: 200,
				renderer:function(value, p, record){return String.format('{0}', record.data['desc_unidad_medida']);},
				anchor: '100%'
			},
			type: 'ComboRec',
			id_grupo: 1,
			filters:{pfiltro:'gemapr.tipo',type:'string'},
			grid: false,
			form: true
		},
		{
			config: {
				name: 'id_uo',
				fieldLabel: 'Atendido Por',
				allowBlank: true,
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
			grid:false,
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
			grid:false,
			form:true
		},
		{
			config: {
				name: 'importancia',
				fieldLabel: 'Criticidad',
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
				hidden:true
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
				maxLength:4,
				hidden:true
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
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
				maxLength:4,
				hidden:true
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
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
		'desc_uo',
		'nro_sol'
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
				'id_orden_trabajo_sol': data.id_orden_trabajo_sol,
				estado: 'pendiente'
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
	  	if(data){
		  	this.getBoton('btn-reporte').enable();
		  	if(data.estado=='borrador'){
			  	this.getBoton('btn-fin').enable();
			  	this.getBoton('btn-subirFoto').enable();
		  	} else{
		  		this.getBoton('btn-fin').disable();
			  	this.getBoton('btn-subirFoto').disable();
		  	}
	  	}
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.OrdenTrabajoSol.superclass.liberaMenu.call(this);
		this.getBoton('btn-fin').setDisabled(true);
		this.getBoton('btn-reporte').setDisabled(true);
		this.getBoton('btn-subirFoto').disable();
		return tb;
	},
	south:{
		  url:'../../../sis_mantenimiento/vista/orden_trabajo_sol_insumo/OrdenTrabajoSolInsumo.php',
		  title:'Insumos', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'OrdenTrabajoSolInsumo'
	},
    codReporte:'GMAN-RG-SM-017',
	codSistema:'GEM',
	pdfOrientacion:'L',
	estado: 'solicitud',
	title1:'REGISTRO',
	title2:'Solicitud de Mantenimiento'
})
</script>