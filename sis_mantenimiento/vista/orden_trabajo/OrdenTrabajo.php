<?php
/**
*@package pXP
*@file gen-OrdenTrabajo.php
*@author  (admin)
*@date 30-08-2012 02:48:41
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.OrdenTrabajo=Ext.extend(Phx.gridInterfaz,{
	constructor:function(config) {
		this.maestro=config.maestro;
		Phx.vista.OrdenTrabajo.superclass.constructor.call(this,config);
		this.init();
		
		this.getComponente('id_especialidad').on('select', function(e, data, index) {
   			if(this.getComponente('especialidades').getValue() != '') {
   				this.getComponente('especialidades').setValue(this.getComponente('especialidades').getValue() + ' - ');
   			}
         	this.getComponente('especialidades').setValue(this.getComponente('especialidades').getValue() + e.getValue());
        },
        this);
		
		this.addButton('btnActividad', 
			{
				text: 'Actividades',
				iconCls: 'blist',
				disabled: true,
				handler: loadActividadesOT,
				tooltip: '<b>Ver las actividades de la Orden de Trabajo Actual</b>'
			}
		);
		
		function loadActividadesOT() {
			var rec=this.sm.getSelected();
			rec.data.nombreVista = this.nombreVista;
			Phx.CP.loadWindows('../../../sis_mantenimiento/vista/actividad_ot/ActividadOT.php',
					'Actividades',
					{
						width:1000,
						height:600
				    },
				    rec.data,
				    this.idContenedor,
				    'actividad'
			);
		}
	},
	fheight:'80%',
	fwidth:'80%',
			
	Atributos:[
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_orden_trabajo'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'fecha_emision',
				fieldLabel: 'Fecha Emisión',
				allowBlank: true,
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_emision',type:'date'},
			id_grupo:0,
			grid:true,
			form:false
		},
		{			
			config:{
				name: 'id_localizacion',
				fieldLabel: 'Solicitante Sector',
				allowBlank: false,
				emptyText:'Solicitante Sector...',
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
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_localizacion',
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
				renderer:function (value, p, record){return String.format('{0}', record.data['nombre_localizacion']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'local.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'cat_prior',
				fieldLabel: 'Prioridad',
				anchor: '100%',
				tinit: true,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'Prioridad',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'torden_trabajo_cat_prior'
				}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'geoott.cat_prior',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'descripcion_lugar',
				fieldLabel: 'Sector',
				allowBlank: true,
				width: '100%',
				gwidth: 300,
				maxLength: 1000
			},
			type: 'TextArea',
			filters:{pfiltro: 'geoott.descripcion_lugar',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_centro_costo',
				fieldLabel: 'Cuenta',
				allowBlank: false,
				emptyText:'Seleccione Cuenta...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/CentroCosto/listarCentroCosto',
					id: 'id_centro_costo',
					root:'datos',
					sortInfo:{
						field:'codigo',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_centro_costo','codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'codigo'}
				}),
				valueField: 'id_centro_costo',
				displayField: 'codigo',
				gdisplayField:'codigo_centro_costo',
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
				renderer:function (value, p, record){return String.format('{0}', record.data['codigo_centro_costo']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'cencost.codigo',type:'string'},
			id_grupo:0,
			grid:true,
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
					url: '../../sis_mantenimiento/control/UniCons/listarUniConsPlano',
					id: 'id_uni_cons',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_uni_cons','codigo','nombre'],
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_uni_cons',
				displayField: 'nombre',
				gdisplayField:'equipo',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth: 220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['equipo']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'ite.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'num_oit',
				fieldLabel: 'Número OIT',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'geoott.num_oit',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo_oit',
				fieldLabel: 'Código OIT',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'geoott.codigo_oit',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_tipo_mant',
				fieldLabel: 'Tipo de OIT',
				allowBlank: false,
				emptyText:'Tipo de mantenimiento...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/TipoMant/listarTipoMant',
					id: 'id_tipo_mant',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_tipo_mant','codigo','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_tipo_mant',
				displayField: 'nombre',
				gdisplayField:'tipo_mant',
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
				renderer:function (value, p, record){return String.format('{0}', record.data['tipo_mant']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'ite.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'cat_tipo',
				fieldLabel: 'Tipo',
				anchor: '100%',
				tinit: true,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'Tipo',
				gwidth: 100,
				baseParams: {
						cod_subsistema:'GEM',
						catalogo_tipo:'torden_trabajo_cat_tipo'
				}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'geoott.cat_tipo',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_especialidad',
				fieldLabel: 'Especialidad',
				allowBlank: true,
				emptyText: 'Elija una especialidad...',
				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/Especialidad/listarEspecialidad',
					id: 'id_especialidad',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_especialidad','nombre'],
					remoteSort: true,
					baseParams: {par_filtro:'espcia.nombre'}
				}),
				valueField: 'nombre',
				displayField: 'nombre',
				gdisplayField: 'nombre_especialidad',
				forceSelection: true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 100,
				anchor: '99%',
				gwidth: 150,
				minChars: 2,
				renderer: function (value, p, record) {
					return String.format('{0}', value?record.data['nombre_especialidad']:'');
				}
			},
			type: 'ComboBox',
			filters: {
				pfiltro: 'esp.nombre',
				type: 'string'
			},
			id_grupo: 0,
			grid: false,
			form: true
		},
		{
			config:{
				name: 'especialidades',
				fieldLabel: 'Especialidades',
				allowBlank: true,
				width: '100%',
				gwidth: 300,
				maxLength: 300
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.observacion',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'observacion',
				fieldLabel: 'Observación y/o Falla',
				allowBlank: true,
				width: '100%',
				gwidth: 300,
				maxLength:5000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.observacion',type:'string'},
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
				gwidth: 300,
				maxLength:5000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.descripcion',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
	   	{
	   		config:{
	       		    name:'id_funcionario_sol',
	   				origen:'FUNCIONARIO',
	   				tinit:true,
	   				fieldLabel:'Solicitante',
	   				gdisplayField:'desc_person',
	   			    gwidth:200,
	   			    anchor: '100%',
		   			renderer: function (value, p, record){return String.format('{0}', record.data['desc_person']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'PERSON.nombre_completo1',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
	   	},
	   	{
	   		config:{
	       		    name:'id_funcionario_asig',
	   				origen:'FUNCIONARIO',
	   				tinit:true,
	   				fieldLabel:'Asignado a',
	   				gdisplayField:'desc_person1',
	   				anchor: '100%',
	   			    gwidth:200,
		   			 renderer:function (value, p, record){return String.format('{0}', record.data['desc_person1']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'PERSON.nombre_completo1',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
	   	},
	   	{
			config:{
				name: 'fecha_plan_ini',
				fieldLabel: 'Plan. Inicio',
				allowBlank: false,
				gwidth: 100,
				format: 'd/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_plan_ini',type:'date'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo_estimado',
				fieldLabel: 'Tiempo Estimado',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:15
			},
			type:'NumberField',
			filters:{pfiltro:'geoott.tiempo_estimado',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
	   		config:{
	       		    name:'id_unidad_medida',
	   				origen:'UNIDADMEDIDA',
	   				tinit:true,
	   				fieldLabel:'Medidad Tiempo Estimado',
	   				gdisplayField:'desc_unidad_medida',
	   				anchor: '100%',
	   			    gwidth:200,
		   			renderer:function (value, p, record){return String.format('{0}', record.data['desc_unidad_medida']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'UNIMED.descripcion',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
	   	},
	   	{
	   		config:{
	       		    name:'id_funcionario_aprob',
	   				origen:'FUNCIONARIO',
	   				tinit:true,
	   				allowBlank: true,
	   				fieldLabel:'Aprobado por:',
	   				gdisplayField:'desc_funcionario_aprob',
	   			    gwidth:200,
	   			    anchor: '100%'
	       	     },
	   			type:'ComboRec',
	   			id_grupo:1,
	   			filters:{
			        pfiltro:'PERSON.nombre_completo1',
					type:'string'
				},
	   			grid:true,
	   			form:true
	   	},
	   	{
	   		config:{
	       		    name:'id_funcionario_recib',
	   				origen:'FUNCIONARIO',
	   				tinit:true,
	   				allowBlank: true,
	   				fieldLabel:'Recibido por:',
	   				gdisplayField:'desc_funcionario_recib',
	   				anchor: '100%',
	   			    gwidth:200
	       	     },
	   			type:'ComboRec',
	   			id_grupo:1,
	   			filters:{
			        pfiltro:'PERSON.nombre_completo1',
					type:'string'
				},
	   			grid:true,
	   			form:true
	   	},
	   	{
			config:{
				name: 'fecha_eje_ini',
				fieldLabel: 'Ejec.Inicio',
				allowBlank: true,
				gwidth: 100,
				format: 'd/m/Y',
   				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_eje_ini',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_eje_fin',
				fieldLabel: 'Ejec.Fin',
				allowBlank: true,
				gwidth: 100,
   				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_eje_fin',type:'date'},
			id_grupo:1,
			grid:true,
			form:true,
	       	dateFormat:'d-m-Y'
		},
	   	{
			config:{
				name: 'comentarios',
				fieldLabel: 'Comentarios',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength: 5000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.comentarios',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'accidentes',
				fieldLabel: 'Accidentes',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength: 1000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.accidentes',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'reclamos',
				fieldLabel: 'Reclamos',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength: 1000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.comentarios',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'otros',
				fieldLabel: 'Otros',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength: 1000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.otros',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cat_estado',
				fieldLabel: 'Estado',
				gwidth: 100,
				hidden: true
			},
			valorInicial: 'Borrador',
			type: 'TextField',
			filters:{pfiltro:'geoott.cat_estado',type:'string'},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config:{
				name: 'ubicacion_tecnica',
				fieldLabel: 'Ubicación Técnica',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength:1500
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.ubicacion_tecnica',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'acumulado',
				fieldLabel: 'Acumulado',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1179650,
				readOnly: true
			},
			type:'NumberField',
			filters:{pfiltro:'geoott.acumulado',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
	   	{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'geoott.estado_reg',type:'string'},
			grid:true,
			form:false
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons_mant_predef'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nota_tecnico_loc',
				fieldLabel: 'Nota Técnico Localización',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.nota_tecnico_loc',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nota_tecnico_equipo',
				fieldLabel: 'Nota Técnico Equipo',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.nota_tecnico_equipo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				gwidth: 100,
				format:'d/m/Y',
   				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_reg',type:'date'},
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				gwidth: 100,
				format:'d/m/Y',
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_mod',type:'date'},
			grid:true,
			form:false
		}
	],
	title:'Orden Interna de Trabajo',
	ActSave:'../../sis_mantenimiento/control/OrdenTrabajo/insertarOrdenTrabajo',
	ActDel:'../../sis_mantenimiento/control/OrdenTrabajo/eliminarOrdenTrabajo',
	ActList:'../../sis_mantenimiento/control/OrdenTrabajo/listarOrdenTrabajo',
	id_store:'id_orden_trabajo',
	fields: [
		{name:'id_orden_trabajo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'planta_estacion', type: 'string'},
		{name:'fecha_plan_ini', type: 'date', dateFormat:'Y-m-d'},
		{name:'fecha_eje_ini', type: 'date', dateFormat:'Y-m-d'},
		{name:'tiempo_estimado', type: 'numeric'},
		{name:'num_oit', type: 'string'},
		{name:'nota_tecnico_equipo', type: 'string'},
		{name:'observacion', type: 'string'},
		{name:'acumulado', type: 'numeric'},
		{name:'codigo_oit', type: 'string'},
		{name:'fecha_emision', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_funcionario_asig', type: 'numeric'},
		{name:'id_unidad_medida', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'id_funcionario_sol', type: 'numeric'},
		{name:'ubicacion_tecnica', type: 'string'},
		{name:'fecha_eje_fin', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_uni_cons_mant_predef', type: 'numeric'},
		{name:'id_tipo_mant', type: 'numeric'},
		{name:'fecha_plan_fin', type: 'date', dateFormat:'Y-m-d'},
		{name:'nota_tecnico_loc', type: 'string'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'cat_estado', type: 'string'},
		{name:'cat_prior', type: 'string'},
		{name:'cat_tipo', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_person', type: 'string'},
		{name:'desc_person1', type: 'string'},
		{name:'equipo', type: 'string'},
		{name:'tipo_mant', type: 'string'},
		{name:'desc_unidad_medida', type: 'string'},
		{name:'id_localizacion', type: 'numeric'},
		{name:'nombre_localizacion', type: 'string'},
		{name:'descripcion_lugar', type: 'string'},
		{name:'id_centro_costo', type: 'numeric'},
		{name:'codigo_centro_costo', type: 'string'},
		{name:'especialidades', type: 'string'},
		{name:'id_funcionario_aprob', type: 'numeric'},
		{name:'desc_funcionaro_aprob', type: 'string'},
		{name:'id_funcionario_recib', type: 'numeric'},
		{name:'desc_funcionario_recib', type: 'string'},
		{name:'comentarios', type: 'string'},
		{name:'accidentes', type: 'string'},
		{name:'reclamos', type: 'string'},
		{name:'otros', type: 'string'}
	],
	sortInfo:{
		field: 'id_orden_trabajo',
		direction: 'ASC'
	},
	bdel: false,
	bedit: false,
	bsave: false,
	bnew: false,
	Grupos:[{ 
		layout: 'column',
		items:[
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Datos Planificacion (1)',
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
                title: 'Datos Ejecución (2)',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 0.5,
                items:[],
		        id_grupo:1,
		        collapsible:true,
		        collapsed:false
			}
			]
		}]
	
})
</script>
		
		