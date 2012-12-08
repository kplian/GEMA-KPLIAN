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
    	//llama al constructor de la clase padre
		Phx.vista.OrdenTrabajo.superclass.constructor.call(this,config);
		this.init();
		
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
   				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_emision',type:'date'},
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
	   				gdisplayField:'desc_person',//mapea al store del grid
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
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_uni_cons',
				displayField: 'nombre',
				gdisplayField:'equipo',
				//hiddenName: 'id_administrador',
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
				name: 'planta_estacion',
				fieldLabel: 'Planta/ Estación',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				items:[
				{boxLabel:'Planta',name: 'rg-tipo', inputValue: 'planta',checked: true},
				{boxLabel:'Estación',name: 'rg-tipo', inputValue: 'estacion'}
				]
			},
			type:'RadioGroup',
			filters:{pfiltro:'geoott.planta_estacion',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
	   		config:{
	       		    name:'id_funcionario_asig',
	   				origen:'FUNCIONARIO',
	   				tinit:true,
	   				fieldLabel:'Asignado a',
	   				gdisplayField:'desc_person1',//mapea al store del grid
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
				name: 'periodicidad',
				fieldLabel: 'Periodicidad',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:15
			},
			type:'NumberField',
			filters:{pfiltro:'geoott.periodicidad',type:'numeric'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
	   		config:{
	       		    name:'id_unidad_medida',
	   				origen:'UNIDADMEDIDA',
	   				tinit:true,
	   				fieldLabel:'Unidad Medida Periodicidad',
	   				gdisplayField:'desc_unidad_medida',//mapea al store del grid
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
				name: 'observacion',
				fieldLabel: 'Observaciones',
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
			id_grupo:1,
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
			id_grupo:1,
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
			id_grupo:1,
			grid:true,
			form:true
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
			id_grupo:1,
			grid:true,
			form:false
		},
		
		{
			config:{
				name: 'fecha_plan_ini',
				fieldLabel: 'Plan.Inicio',
				allowBlank: false,
				gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
   				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_plan_ini',type:'date'},
			id_grupo:2,
			grid:true,
			form:true,
	       	dateFormat:'d-m-Y'
		},
		{
			config:{
				name: 'fecha_eje_ini',
				fieldLabel: 'Ejec.Inicio',
				allowBlank: true,
				gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
   				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_eje_ini',type:'date'},
			id_grupo:3,
			grid:true,
			form:true,
	       	dateFormat:'d-m-Y'
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
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
   				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_eje_fin',type:'date'},
			id_grupo:3,
			grid:true,
			form:true,
	       	dateFormat:'d-m-Y'
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
				name: 'fecha_plan_fin',
				fieldLabel: 'Plan.Fin',
				allowBlank: false,
				gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
   				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_plan_fin',type:'date'},
			id_grupo:2,
			grid:true,
			form:true,
	       	dateFormat:'d-m-Y'
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
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
   				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_reg',type:'date'},
			id_grupo:1,
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
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				gwidth: 100//,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'geoott.fecha_mod',type:'date'},
			id_grupo:1,
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
		{name:'fecha_plan_ini'}, //, type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'fecha_eje_ini'},//, type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'periodicidad', type: 'numeric'},
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
		{name:'fecha_eje_fin'}, //, type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_uni_cons_mant_predef', type: 'numeric'},
		{name:'id_tipo_mant', type: 'numeric'},
		{name:'fecha_plan_fin'},//, type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'nota_tecnico_loc', type: 'string'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'cat_estado', type: 'string'},
		{name:'cat_prior', type: 'string'},
		{name:'cat_tipo', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s.ffffff'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod'},//, type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_person', type: 'string'},
		{name:'desc_person1', type: 'string'},
		{name:'equipo', type: 'string'},
		{name:'tipo_mant', type: 'string'},
		{name:'desc_unidad_medida', type: 'string'}
	],
	sortInfo:{
		field: 'id_orden_trabajo',
		direction: 'ASC'
	},
	bdel: false,
	bedit: false,
	bsave: false,
	bnew: false,
	agregarArgsExtraSubmit: function(){
		//Inicializa el objeto de los argumentos extra
		this.argumentExtraSubmit={};

		//Obtiene los valores dinámicos
		var rbtPlaEst = this.getComponente('planta_estacion');
		var array = [];
		var tmp;
		array = rbtPlaEst.items;
		
		//Evaluate the radio checked and asign a valur for the variable
		if(array.items[0].checked){
			tmp='planta';
		} else{
			tmp='estacion';
		}

		//Añade los parámetros extra para mandar por submit
		this.argumentExtraSubmit.planta_estacion=tmp;
	},
	Grupos:[{ 
		layout: 'column',
		items:[
			{
				xtype:'fieldset',
				layout: 'form',
                border: true,
                title: 'Datos OIT (1)',
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
                title: 'Datos OIT (2)',
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
                title: 'Fechas Planificadas',
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
                title: 'Fechas Ejecutadas',
                bodyStyle: 'padding:0 10px 0;',
                columnWidth: 0.5,
                items:[],
		        id_grupo:3,
		        collapsible:true,
		        collapsed:false
			}
			]
		}]
	
})
</script>
		
		