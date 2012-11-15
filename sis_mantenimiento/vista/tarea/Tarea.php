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
				fieldLabel: 'id_plan_mant',
				inputType:'hidden',
				disabled: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'tare.id_plan_mant',type:'numeric'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'id_uni_cons',
				fieldLabel: 'id_uni_cons',
				inputType:'hidden',
				disabled:true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'tare.id_uni_cons',type:'numeric'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
   				name:'id_uni_cons_hijo',
   				fieldLabel:'Unidad Constructiva',
   				allowBlank:true,
   				emptyText:'Unidades Constructivas..',
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
   				width:250,
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
   			grid:true,
   			form:true
	    },
		{
			config:{
				name: 'id_modo_falla',
				fieldLabel: 'Modo falla',
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
					fields: ['id_modo_falla','modo_falla','efecto_falla'],
					remoteSort: true,
					baseParams:{par_filtro:'modo_falla#efecto_falla'}
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
   				width:250,
   				minChars:2,
       			enableMultiSelect:true,   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['modo_falla']);}
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
			config:{
				name: 'id_unidad_medida',
				fieldLabel: 'Unidad de medida',
				allowBlank: false,
				emptyText:'Unidad de medida...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/UnidadMedida/listarUnidadMedida',
					id: 'id_unidad_medida',
					root: 'datos',
					sortInfo:{
						field: 'codigo',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_unidad_medida','codigo','descripcion'],
					remoteSort: true,
					baseParams:{par_filtro:'codigo#descripcion'}
	    		}),	    				
				valueField: 'id_unidad_medida',
   				displayField: 'codigo',
   				gdisplayField: 'descripcion',
   				hiddenName: 'id_unidad_medida',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				minChars:2,
       			enableMultiSelect:true,   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['codigo']);}
			},
			type:'ComboBox',
   			id_grupo:0,
   			filters:{   pfiltro:'codigo',
   						type:'string'
   					},
   			grid:true,
   			form:true
		},
		{
			config:{
				name: 'col_h',
				fieldLabel: 'Col h',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_h',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'col_s',
				fieldLabel: 'Col s',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_s',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'col_o',
				fieldLabel: 'Col o',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_o',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'col_n',
				fieldLabel: 'Col n',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_n',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'col_hson1',
				fieldLabel: 'Col hson1',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_hson1',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'col_hson2',
				fieldLabel: 'Col hson2',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_hson2',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'col_hson3',
				fieldLabel: 'Col hson3',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_hson3',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'col_h4',
				fieldLabel: 'Col h4',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_h4',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'col_h5',
				fieldLabel: 'Col h5',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_h5',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'col_s4',
				fieldLabel: 'Col s4',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2
			},
			type:'TextField',
			filters:{pfiltro:'tare.col_s4',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tareas',
				fieldLabel: 'Tareas',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextField',
			filters:{pfiltro:'tare.tareas',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'frecuencia',
				fieldLabel: 'Frecuencia',
				allowBlank: true,
				anchor: '80%',
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
	       		name:'id_especialidad',
   				fieldLabel:'Especialidad',
   				allowBlank:false,
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
   				width:250,
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
   				width:250,
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
				anchor: '80%',
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d'
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d'
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
				maxLength:4
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
		{name:'usr_mod', type: 'string'}
	],
	sortInfo:{
		field: 'id_tarea',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	onReloadPage:function(m){       
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_plan_mant;
		this.Atributos[2].valorInicial=this.maestro.id_uni_cons;
		this.getComponente('id_uni_cons_hijo').store.baseParams.id_uni_cons = this.maestro.id_uni_cons;
		if(m.id != 'id'){
		this.store.baseParams={id_plan_mant:this.maestro.id_plan_mant};
		this.load({params:{start:0, limit:50}})
       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll();    	   
       }
	}
}
)
</script>
		