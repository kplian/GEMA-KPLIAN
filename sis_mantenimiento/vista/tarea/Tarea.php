<?php
/**
*@package       pXP
*@file          gen-Tarea.php
*@author        (rac)
*@date          17-10-2012 18:28:03
*@description   Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Tarea=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
		Phx.vista.Tarea.superclass.constructor.call(this,config);
		this.init();		
        this.grid.getTopToolbar().disable();
        
        //Oculta el componente
        this.ocultarComponente(this.getComponente('id_falla_evento'));
        this.ocultarComponente(this.getComponente('id_uni_cons_hijo'));
        
        //Definición de eventos
        this.getComponente('id_funcion').on('blur',function(combo){
        	this.getComponente('id_funcion_falla').store.baseParams={id_funcion:combo.value};
        	this.getComponente('id_funcion_falla').setValue('');
        	this.getComponente('id_funcion_falla').modificado=true;
        },this);
        
        this.getComponente('id_funcion_falla').on('blur',function(combo){
        	this.getComponente('id_modo_falla').store.baseParams={id_funcion_falla:combo.value};
        	this.getComponente('id_modo_falla').setValue('');
        	this.getComponente('id_modo_falla').modificado=true;
        },this);
	},
			
	Atributos:[
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'id_tarea'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_plan_mant',
				inputType:'hidden'
			},
			type:'Field',
			grid:false,
			form:true
		},
		{
			config:{
				name: 'id_uni_cons',
				inputType:'hidden'
			},
			type:'Field',
			grid:false,
			form:true
		},
		{
			config:{
   				name:'id_uni_cons_hijo',
   				fieldLabel:'Subsistema',
   				allowBlank:true,
   				emptyText:'Subsistema...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/UniCons/listarUniConsHijo',
					id: 'id_uni_cons_hijo',
					root: 'datos',
					sortInfo:{
						field: 'prioridad',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_uni_cons_hijo','nombre','codigo'],
					remoteSort: true,	    					
					baseParams:{par_filtro:'nombre#codigo',id_uni_cons:this.id_uni_cons,tipo:'tuc'}
				}),
   				valueField: 'id_uni_cons_hijo',
   				displayField: 'nombre',
   				gdisplayField: 'codigo',
   				hiddenName: 'id_uni_cons_hijo',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				anchor: '100%',
   				minChars:2,
       			enableMultiSelect:true,   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['nombre_uni_cons_hijo']);}
	       	},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{
   		        pfiltro:'nombre',
                type:'string'
   			},
   			grid:false,
   			form:true
	    },
	    {
			config:{
   				name:'id_funcion',
   				fieldLabel:'Función',
   				allowBlank:false,
   				emptyText:'Seleccione una Función...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/Funcion/listarFuncionEquipo',
					id: 'id_funcion',
					root: 'datos',
					sortInfo:{
						field: 'orden',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_funcion','orden','descripcion'],
					remoteSort: true,	    					
					baseParams:{par_filtro:'orden#descripcion',id_uni_cons:this.id_uni_cons}
				}),
   				valueField: 'id_funcion',
   				displayField: 'descripcion',
   				gdisplayField: 'desc_funcion',
   				hiddenName: 'id_funcion',
   				forceSelection:false,
   				typeAhead: false,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				anchor: '100%',
   				minChars:2,
       			enableMultiSelect:true,   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcion']);},
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Orden: {orden}</p><p>Función: {descripcion}</p></div></tpl>'
	       	},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{
   		        pfiltro:'descripcion',
                type:'string'
   			},
   			grid:true,
   			form:true
	    },
	    {
			config:{
   				name:'id_funcion_falla',
   				fieldLabel:'Falla',
   				allowBlank:false,
   				emptyText:'Seleccione una Falla...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/FuncionFalla/listarFuncionFalla',
					id: 'id_funcion_falla',
					root: 'datos',
					sortInfo:{
						field: 'orden',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_funcion_falla','orden','falla'],
					remoteSort: true,	    					
					baseParams:{par_filtro:'orden#falla'}
				}),
   				valueField: 'id_funcion_falla',
   				displayField: 'falla',
   				gdisplayField: 'desc_funcion_falla',
   				hiddenName: 'id_funcion_falla',
   				forceSelection:false,
   				typeAhead: false,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				anchor: '100%',
   				minChars:2,
       			enableMultiSelect:true,   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcion_falla']);},
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Orden: {orden}</p><p>Falla: {falla}</p></div></tpl>'
	       	},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{
   		        pfiltro:'falla',
                type:'string'
   			},
   			grid:true,
   			form:true
	    },
	    {
   			config:{
   				name:'id_falla_evento',
   				fieldLabel:'Falla evento',
   				allowBlank:true,
   				emptyText:'Falla evento...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/FallaEvento/listarFallaEvento',
					id: 'id_falla_evento',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_falla_evento','codigo','nombre'],
					remoteSort: true,
					baseParams:{par_filtro:'codigo#nombre'}
				}),
   				valueField: 'id_falla_evento',
   				displayField: 'nombre',
   				gdisplayField: 'nombre_evento',
   				hiddenName: 'id_falla_evento',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				anchor: '100%',
   				minChars:2,
       			enableMultiSelect:true,   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['nombre_falla']);}
   			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{   
   				pfiltro:'nombre',
   				type:'string'
   			},
   			grid:false,
   			form:true
	    },
		{
			config:{
				name: 'id_modo_falla',
				fieldLabel: 'Modo/Efecto Falla',
				allowBlank: false,
				emptyText:'Modo de falla...',
				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/ModoFalla/listarModoFalla',
					id: 'id_modo_falla',
					root: 'datos',
					sortInfo:{
						field: 'modo_falla',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_modo_falla','modo_falla','efecto_falla','orden'],
					remoteSort: true,
					baseParams:{par_filtro:'orden#modo_falla#efecto_falla'}
	    		}),	    				
				valueField: 'id_modo_falla',
   				displayField: 'modo_falla',
   				gdisplayField: 'modo_falla',
   				hiddenName: 'id_modo_falla',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				anchor: '100%',
   				minChars:2,
       			enableMultiSelect:true,   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['modo_falla']);},
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Orden: {orden}</p><p>Modo Falla: {modo_falla}</p><p>Efecto Falla: {efecto_falla}</p></div></tpl>'
			},
			type:'ComboBox',
   			id_grupo:0,
   			filters:{   
   			    pfiltro:'nombre_falla',
   				type:'string'
   			},
   			grid:true,
   			form:true
		},
		{
			config: {
				name: 'col_h',
				fieldLabel: 'H',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_h']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_h',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'col_s',
				fieldLabel: 'S',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_s']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_s',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'col_o',
				fieldLabel: 'O',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_o']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_o',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'col_n',
				fieldLabel: 'N',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_n']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_n',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'col_hson1',
				fieldLabel: 'HSON1',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_hson1']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_hson1',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'col_hson2',
				fieldLabel: 'HSON2',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_hson2']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_hson2',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'col_hson3',
				fieldLabel: 'HSON3',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_hson3']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_hson3',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'col_h4',
				fieldLabel: 'H4',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_h4']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_h4',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'col_h5',
				fieldLabel: 'H5',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_h5']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_h5',type:'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'col_s4',
				fieldLabel: 'S4',
				anchor: '30%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'ttarea__sn'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['col_s4']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'tare.col_s4',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'tareas',
				fieldLabel: 'Tareas de Mantenimiento',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'tare.tareas',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'frecuencia',
				fieldLabel: 'Frecuencia Inicial',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'tare.frecuencia',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
	   		config:{
	       		    name:'id_unidad_medida',
	   				origen:'UNIDADMEDIDA',
	   				tinit:false,
	   				fieldLabel:'Unidad Medida',
	   				gdisplayField:'desc_unidad_medida',
	   				anchor: '100%',
	   			    gwidth: 70,
		   			renderer:function (value, p, record){return String.format('{0}', record.data['codigo']);},
		   			allowBlank:false
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'codigo',
					type:'string'
				},
	   			grid:true,
	   			form:true
	   	},
		{
	       	config:{
	       		name:'id_especialidad',
   				fieldLabel:'Realizado por',
   				allowBlank:true,
   				emptyText:'Especialidad...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/Especialidad/listarEspecialidad',
					id: 'id_especialidad',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_especialidad','codigo','nombre'],
					remoteSort: true,
					baseParams:{par_filtro:'codigo#nombre'}
				}),
   				valueField: 'id_especialidad',
   				displayField: 'nombre',
   				gdisplayField: 'nombre_especialidad',
   				hiddenName: 'id_especialidad',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				anchor: '100%',
   				minChars:2,
     			enableMultiSelect:true,	       			
				renderer:function(value, p, record){return String.format('{0}', record.data['nombre_especialidad']);}
       		},
       		type:'ComboBox',
   			id_grupo:0,
   			filters:{   
   				pfiltro:'nombre',
   				type:'string'
   			},
   			grid:true,
   			form:true
	    },
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'tare.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '100%',
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d',
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'tare.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '100%',
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d',
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'tare.fecha_mod',type:'date'},
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
		}
	],
	
	title:'Tareas de mantenimiento',
	ActSave:'../../sis_mantenimiento/control/Tarea/insertarTarea',
	ActDel:'../../sis_mantenimiento/control/Tarea/eliminarTarea',
	ActList:'../../sis_mantenimiento/control/Tarea/listarTarea',
	id_store:'id_tarea',
	
	fields: [
		{name:'id_tarea', type: 'numeric'},
		{name:'id_plan_mant', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'id_uni_cons_hijo', type: 'numeric'},
		{name:'nombre_uni_cons_hijo', type: 'string'},
		{name:'id_modo_falla', type: 'numeric'},
		{name:'modo_falla', type: 'string'},
		{name:'id_unidad_medida', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'tareas', type: 'string'},
		{name:'col_hson3', type: 'string'},
		{name:'col_h4', type: 'string'},
		{name:'col_h', type: 'string'},
		{name:'id_falla_evento', type: 'numeric'},
		{name:'nombre_falla',type:'string'},
		{name:'col_h5', type: 'string'},
		{name:'col_n', type: 'string'},
		{name:'col_hson2', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'frecuencia', type: 'numeric'},
		{name:'id_especialidad', type: 'numeric'},
		{name:'nombre_especialidad',type:'string'},
		{name:'col_o', type: 'string'},
		{name:'col_s', type: 'string'},
		{name:'col_s4', type: 'string'},
		{name:'col_hson1', type: 'string'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'id_funcion_falla', type: 'numeric'},
		{name:'desc_funcion_falla', type: 'string'},
		{name:'id_funcion', type: 'numeric'},
		{name:'desc_funcion', type: 'string'}
	],
	sortInfo:{
		field: 'id_tarea',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	
	onReloadPage:function(m){       
		this.maestro=m;
		console.log(this.maestro)
		this.Atributos[1].valorInicial=this.maestro.id_plan_mant;
		this.Atributos[2].valorInicial=this.maestro.id_uni_cons;
		this.getComponente('id_uni_cons_hijo').store.baseParams.id_uni_cons = this.maestro.id_uni_cons;
		this.getComponente('id_funcion').store.baseParams = {id_uni_cons:this.maestro.id_uni_cons, id_uni_cons_hijo: this.maestro.id_uni_cons_hijo};
		if(m.id != 'id'){
		this.store.baseParams={id_plan_mant:this.maestro.id_plan_mant};
		this.load({params:{start:0, limit:50}})
       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll();    	   
       }
	},
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		