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
         	this.getComponente('especialidades').setValue(this.getComponente('especialidades').getValue() + e.getRawValue());
        },
        this);

       this.getComponente('id_uni_cons').on('select', function(e, data, index) {
        	this.getComponente('id_localizacion').setValue(data.data.id_localizacion);
        	this.getComponente('id_localizacion').setRawValue(data.data.desc_localizacion);
        },this);
       
        this.crearMensajeEstadoForm();
		
		this.addButton('btnActividad',
			{
				text: 'Actividades',
				iconCls: 'bchecklist',
				disabled: true,
				handler: loadActividadesOT,
				tooltip: '<b>Actividades</b><br/>Ver las actividades de la Orden de Trabajo Actual'
			}
		);
		
		this.addButton('reporteOT',{
			text:'Report OIT',
			iconCls: 'bpdf32',
			disabled: true,
			handler:function() {
				var rec=this.sm.getSelected();
				Phx.CP.loadingShow();
				Ext.Ajax.request({
					url:'../../sis_mantenimiento/control/OrdenTrabajo/reporteOT',
					params:{'id_orden_trabajo': rec.data.id_orden_trabajo},
					success: this.successExport,
					failure: this.conexionFailure,
					timeout: this.timeout,
					scope:this
				});
			},
			tooltip: '<b>Reporte OIT</b><br/>Generar el reporte de la Orden Interna de Trabajo seleccionada.'
		});
		
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
		
		function costoOIT() {
			var rec=this.sm.getSelected();
			Phx.CP.loadWindows('../../../sis_mantenimiento/vista/orden_trabajo/OrdenTrabajoCosto.php',
					'Costo OIT',
					{
						width:1000,
						height:600
				    },
				    rec.data,
				    this.idContenedor,
				    'OrdenTrabajoCosto'
			);
		}
		
		this.addButton('btnCostoOIT',
			{
				text: 'Costo OIT',
				iconCls: 'bchecklist',
				disabled: false,
				handler: costoOIT,
				tooltip: '<b>Costo OIT</b><br/>Detalle de los costos de la OIT'
			}
		);
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
					labelSeparator:'',
					inputType:'hidden',
					name: 'codigo_oit'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'num_oit',
				fieldLabel: 'Nº OIT',
				allowBlank: false,
				anchor: '100%',
				gwidth: 150,
				maxLength: 20,
				disabled:true
			},
			type:'TextField',
			filters:{pfiltro:'geoott.num_oit',type:'string'},
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
					fields: ['id_uni_cons','codigo','nombre','nombre_tipo_equipo','padres_loc', 'id_localizacion','desc_localizacion'],
					remoteSort: true,
					baseParams:{par_filtro:'tuc.nombre#tuc.codigo#eq.nombre'}
				}),
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Tipo Equipo: {nombre_tipo_equipo}</p><p>Localización: {padres_loc}</p></div></tpl>',
				valueField: 'id_uni_cons',
				hiddenValue: 'id_uni_cons',
				displayField: 'codigo',
				gdisplayField:'equipo',
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
				renderer:function (value, p, record){return String.format('{0}', record.data['equipo']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'unicons.nombre#unicons.codigo',type:'string'},
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
			filters:{pfiltro:'tipman.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cat_estado',
				fieldLabel: 'Estado',
				gwidth: 60,
				hidden: true,
				renderer: function (value,p,record,otro, otro2) {
					var result;
					if(value == "Borrador") {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/ball_red.png' align='center' width='18' height='18' title='Borrador'/></div>";
					} else if(value == 'generado') {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/ball_red_generated.png' align='center' width='18' height='18' title='Generado'/></div>";
					} else if(value == 'Pendiente') {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/ball_red_pending.png' align='center' width='18' height='18' title='Pendiente'/></div>";
					} else if(value == 'Abierto') {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/ball_yellow.png' align='center' width='18' height='18' title='Abierto'/></div>";
					} else if(value == 'EjecucionPendiente') {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/ball_yellow_pause.png' align='center' width='18' height='18' title='Ejecucion Pendiente'/></div>";
					} else if(value == 'Cerrado') {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/ball_yellow_pending.png' align='center' width='18' height='18' title='Cerrado'/></div>";
					} else if(value == 'Revisado') {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/ball_green.png' align='center' width='18' height='18' title='Revisado'/></div>";
					} else if(value == "Cancelado") {
						result = "<div style='text-align:center'><img src = '../../../lib/imagenes/ball_close.png' align='center' width='18' height='18' title='Cancelado'/></div>";
					}
					return result;
				}
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
				name: 'fecha_emision',
				fieldLabel: 'Fecha Emisión',
				allowBlank: true,
				gwidth: 85,
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
				name: 'fecha_eje_ini',
				fieldLabel: 'Inicio Ejecución',
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
				fieldLabel: 'Fin Ejecución',
				allowBlank: true,
				gwidth: 100,
   				format:'d/m/Y',
   				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
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
				name:'tiempo',
				fieldLabel:'Tiempo Transcurrido',
				renderer:function(value,p,record){
					var tiempo,totalMillis,dias;
					
					if(record.data['fecha_emision']==null){
						dias='';
					} else if(record.data['fecha_eje_fin']==null){
						//Compara con la hora del servidor
						totalMillis = record.data['fecha_server'].getTime() - record.data['fecha_emision'].getTime();
						dias = 1 + (totalMillis/(1000*60*60*24));
					} else{
						//Compara con la fecha de finalización de ejecución
						totalMillis = record.data['fecha_eje_fin'].getTime() - record.data['fecha_emision'].getTime();
						dias = 1 + (totalMillis/(1000*60*60*24));
					}
					
					if(dias>30&&dias<60){
						formato = '<b><font color="yellow">{0}</font></b>'
					} else if(dias>=60){
						formato = '<b><font color="red">{0}</font></b>'
					} else{
						formato = '<b><font color="green">{0}</font></b>'
					}

					return String.format(formato, dias);  
				}
			},
			type:'Field',
			grid:true,
			form:false
		},
		{			
			config:{
				name: 'id_localizacion',
				fieldLabel: 'Localización',
				allowBlank: true,
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
					baseParams:{par_filtro:'nombre#codigo'}
				}),
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p></div></tpl>',
				valueField: 'id_localizacion',
				hiddenValue: 'id_localizacion',
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
				autoSelect:true,
				disabled:true
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
				allowBlank: false,
				width: '100%',
				gwidth: 250,
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
				name: 'id_cuenta',
				fieldLabel: 'Cuenta Contable',
				allowBlank: true,
				emptyText:'Elija una Cuenta...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/Cuenta/listarCuenta',
					id: 'id_cuenta',
					root:'datos',
					sortInfo:{
						field:'nro_cuenta',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_cuenta','nro_cuenta','nombre_cuenta'],
					remoteSort: true,
					baseParams:{par_filtro:'cta.nombre_cuenta#cta.nro_cuenta'}
				}),
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Nro.Cuenta: {nro_cuenta}</p><p>Nombre Cuenta: {nombre_cuenta}</p></div></tpl>',
				valueField: 'id_cuenta',
				hiddenValue: 'id_cuenta',
				displayField: 'nombre_cuenta',
				gdisplayField:'desc_cuenta',
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
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_cuenta']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'cue.nro_cuenta#cue.nombre_cuenta',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_centro_costo',
				fieldLabel: 'Centro de Costo',
				allowBlank: false,
				emptyText:'Seleccione Centro de Costo...',
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
					fields: ['id_centro_costo','codigo', 'descripcion'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'codigo'}
				}),
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Cuenta: {codigo}</p><p>Desc.: {descripcion}</p></div></tpl>',
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
				gwidth: 100,
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
					labelSeparator:'',
					inputType:'hidden',
					name: 'codigo_oit'
			},
			type:'Field',
			form:true 
		},
		
		{
			config: {
				name: 'cat_tipo',
				inputType:'hidden',
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
			type: 'Field',
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
				valueField: 'id_especialidad',
				displayField: 'nombre',
				gdisplayField: 'nombre_especialidad',
				forceSelection: true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 100,
				anchor: '100%',
				gwidth: 120,
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
			filters:{pfiltro:'geoott.especialidades',type:'string'},
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
	       		    name:'id_funcionario_sol',
	   				origen:'FUNCIONARIO',
	   				tinit:true,
	   				fieldLabel: 'Solicitante',
	   				gdisplayField:'desc_person',
	   			    gwidth: 120,
	   			    anchor: '100%',
		   			renderer: function (value, p, record){return String.format('{0}', record.data['desc_person']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'fun.desc_funcionario1',
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
	   			    gwidth: 120,
		   			renderer:function (value, p, record){return String.format('{0}', record.data['desc_person1']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'fun1.desc_funcionario1',
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
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
				allowBlank: false,
				anchor: '100%',
				gwidth: 70,
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
	   				fieldLabel:'Unidad Medida',
	   				gdisplayField:'desc_unidad_medida',
	   				anchor: '100%',
	   			    gwidth: 70,
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
	   				fieldLabel:'Aprobado por',
	   				gdisplayField:'desc_funcionario_aprob',
	   			    gwidth: 120,
	   			    anchor: '100%',
	   			    renderer:function (value, p, record){return String.format('{0}', record.data['desc_person1']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:1,
	   			filters:{
			        pfiltro:'fun2.desc_funcionario1',
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
	   				fieldLabel:'Recibido por',
	   				gdisplayField:'desc_funcionario_recib',
	   				anchor: '100%',
	   			    gwidth: 120,
	   			    renderer:function (value, p, record){return String.format('{0}', record.data['desc_person1']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:1,
	   			filters:{
			        pfiltro:'fun3.desc_funcionario1',
					type:'string'
				},
	   			grid:true,
	   			form:true
	   	},
		{
			config:{
				name: 'hora_eje_inicio',
				fieldLabel: '(Hr)Eje. Inicio',
				format:'H:i:s',
				allowBlank: true
			},
			type:'TimeField',
			id_grupo: 1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'hora_eje_fin',
				fieldLabel: '(Hr)Eje. Fin',
				format:'H:i:s',
				allowBlank: true
			},
			type:'TimeField',
			id_grupo: 1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion_causa',
				fieldLabel: 'Descripción Causa',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength: 1000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.descripcion_causa',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
	   	{
			config:{
				name: 'comentarios',
				fieldLabel: 'Acción Realizada',
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
				name: 'prevension',
				fieldLabel: 'Prevensión Tomada',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength: 1000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.prevension',type:'string'},
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
			filters:{pfiltro:'geoott.reclamos',type:'string'},
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
				name: 'descripcion_progresiva',
				fieldLabel: 'Descripción Equipo/Progresiva',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'geoott.descripcion_progresiva',type:'string'},
			id_grupo:0,
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
				gwidth: 100
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
				gwidth: 100
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
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
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
		{name:'desc_funcionario_aprob', type: 'string'},
		{name:'id_funcionario_recib', type: 'numeric'},
		{name:'desc_funcionario_recib', type: 'string'},
		{name:'comentarios', type: 'string'},
		{name:'accidentes', type: 'string'},
		'reclamos',
		'otros',
		'hora_eje_inicio',
		'hora_eje_fin',
		'descripcion_causa',
		'prevension',
		'descripcion_progresiva',
		'id_cuenta',
		'desc_cuenta',
		{name:'fecha_server', type: 'date', dateFormat:'Y-m-d'}
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
		}],
	preparaMenu: function(n) {
		var tb = Phx.vista.OrdenTrabajo.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	this.getBoton('btnActividad').setDisabled(false);
	  	this.getBoton('reporteOT').setDisabled(false);
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.OrdenTrabajo.superclass.liberaMenu.call(this);
		this.getBoton('reporteOT').setDisabled(true);
		this.getBoton('btnActividad').setDisabled(true);
		return tb;
	},
	crearMensajeEstadoForm: function() {
		this.mensajeEstadoForm = new Ext.form.FormPanel({
			bodyStyle: 'padding:10 20px 10;',
			autoDestroy: true,
			border: false,
			layout: 'form',
			autoScroll: true,
			defaults: {
				xtype: 'textfield'
			},
			items: [
			{
				xtype: 'textarea',
				name: 'motivo',
				fieldLabel: '*Motivo',
				width: '100%',
				allowBlank: false
			},
			{
				xtype: 'textfield',
				name: 'estado',
				fieldLabel: 'estado',
				allowBlank: true,
				hidden: true
			}]
		});

		this.mensajeEstadoFormDialog = new Ext.Window({
			title: 'Motivo',
			collapsible: true,
			maximizable: true,
			autoDestroy: true,
			width: 400,
			height: 200,
			layout: 'fit',
			buttonAlign: 'center',
			items: this.mensajeEstadoForm,
			modal: true,
			closeAction: 'hide',
			buttons: [{
				text: 'Guardar',
				handler: this.procesarMensajeEstadoForm,
				scope: this
			}, {
				text: 'Cancelar',
				handler: function() {
					this.mensajeEstadoFormDialog.hide();
				},
				scope: this
			}]
		});
	},
	procesarMensajeEstadoForm: function() {
		if (this.mensajeEstadoForm.getForm().isValid()) {
			Phx.CP.loadingShow();

			var rec=this.sm.getSelected();
			var data = rec.data;
			var txtMensajeExtra = this.mensajeEstadoForm.getForm().findField('motivo');
			var txtEstado = this.mensajeEstadoForm.getForm().findField('estado');
			Ext.Ajax.request({
				url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
				params: {
					'id_orden_trabajo': data.id_orden_trabajo,
					'cat_estado_anterior': data.cat_estado,
					'cat_estado': txtEstado.getValue(),
					'mensaje_estado': txtMensajeExtra.getValue()
				},
				success: this.successProcesarOT,
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});
		}
	},
	successProcesarOT: function(resp) {
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if (reg.ROOT.error) {
				alert("ERROR no esperado")
			} else {
				this.mensajeEstadoFormDialog.hide();
			}
			this.reload();
		},
	onButtonNew: function() {
		Phx.vista.OrdenTrabajo.superclass.onButtonNew.call(this);
		//this.getComponente('id_uni_cons').disable();
	},
	onButtonEdit: function() {
		Phx.vista.OrdenTrabajo.superclass.onButtonEdit.call(this);
		//this.getComponente('id_uni_cons').enable();
	},
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		
		
