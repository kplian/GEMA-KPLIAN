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

Phx.vista.recurso=Ext.extend(Phx.gridInterfaz,{
	constructor: function(config) {
		modificarRecursos = false;
		if(config.nombreVista == "ejecutarOT") {
			modificarRecursos = true;
		}
		
		this.bnew = modificarRecursos;
		this.bdel = modificarRecursos;
		this.bedit = modificarRecursos;
		this.bsave = modificarRecursos;
		
		Phx.vista.recurso.superclass.constructor.call(this,config);
		this.init();
		this.grid.getTopToolbar().disable();
   		this.grid.getBottomToolbar().disable();
   		this.store.removeAll();
   		
   		//listener to combo box 
   		this.getComponente('recurso').on('select', this.onRecursoSelect,this);
	},
	Atributos: [
		{
			config:{
					labelSeparator: '',
					inputType: 'hidden',
					name: 'id_recurso'
			},
			type: 'Field',
			form: true 
		},
		{
			config: {
					labelSeparator: '',
					inputType: 'hidden',
					name: 'id_actividad'
			},
			type: 'Field',
			form: true 
		},
		{
			config: {
				name: 'recurso',
				fieldLabel: 'Recurso',
				allowBlank: false,
			    triggerAction: 'all',
			    lazyRender: true,
			    mode: 'local',
			    store: new Ext.data.ArrayStore({
			    	fields: ['codigo','nombre'],
					data: [
						['item','Item'], 
						['funcionario','Funcionario'],
						['especialidad','Especialidad'],
						['servicio','Servicio']
					]
				}),
			    anchor: '100%',
				valueField: 'codigo',
				displayField: 'nombre'
		    },
		    type: 'ComboBox',
		    id_grupo: 1,
		    form: true,
		    grid: false
		},
		{
			config: {
				name: 'id_item',
				fieldLabel: 'Item',
				allowBlank: true,
				emptyText: 'Elija un item...',
				store: new Ext.data.JsonStore({
					url: '../../sis_almacenes/control/Item/listarItem',
					id: 'id_item',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_item','nombre'],
					remoteSort: true,
					baseParams: {par_filtro:'item.nombre'}
				}),
				hidden: true,
				valueField: 'id_item',
				displayField: 'nombre',
				gdisplayField: 'nombre_item',
				forceSelection: false,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 500,
				anchor: '99%',
				gwidth: 150,
				minChars: 2,
				renderer: function (value, p, record) {
					return String.format('{0}', value?record.data['nombre_item']:'');
				}
			},
			type: 'ComboBox',
			filters: {
				pfiltro: 'itm.nombre',
				type: 'string'
			},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_funcionario',
				fieldLabel: 'Funcionario',
				allowBlank: true,
				emptyText: 'Designe a un funcionario...',
				store: new Ext.data.JsonStore({
					url: '../../sis_organigrama/control/Funcionario/listarFuncionario',
					id: 'id_funcionario',
					root: 'datos',
					sortInfo: {
						field: 'desc_person',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_funcionario','desc_person'],
					remoteSort: true,
					baseParams: {par_filtro:'desc_person'}
				}),
				hidden: true,
				valueField: 'id_funcionario',
				displayField: 'desc_person',
				gdisplayField: 'nombre_funcionario',
				forceSelection: false,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 500,
				anchor: '99%',
				gwidth: 150,
				minChars: 2,
				renderer: function (value, p, record) {
					return String.format('{0}', value?record.data['nombre_funcionario']:'');
				}
			},
			type: 'ComboBox',
			filters: {
				pfiltro: 'pers.nombre',
				type: 'string'
			},
			id_grupo: 0,
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
					baseParams: {par_filtro:'nombre'}
				}),
				hidden: true,
				valueField: 'id_especialidad',
				displayField: 'nombre',
				gdisplayField: 'nombre_especialidad',
				forceSelection: false,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 500,
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
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_servicio',
				fieldLabel: 'Servicio',
				allowBlank: true,
				emptyText: 'Seleccione un Servicio...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/Servicio/listarServicio',
					id: 'id_servicio',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_servicio','nombre'],
					remoteSort: true,
					baseParams: {par_filtro:'nombre'}
				}),
				hidden: true,
				valueField: 'id_servicio',
				displayField: 'nombre',
				gdisplayField: 'nombre_servicio',
				forceSelection: false,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 500,
				visible: false,
				anchor: '99%',
				gwidth: 150,
				minChars: 2,
				renderer: function (value, p, record) {
					return String.format('{0}', value?record.data['nombre_servicio']:'');
				}
			},
			type: 'ComboBox',
			filters: {
				pfiltro: 'serv.nombre',
				type: 'string'
			},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'hh_normal',
				fieldLabel: 'HH Normal',
				allowBlank: true,
				width: '100%',
				gwidth: 100,
				maxLength: 100,
				hidden: true
			},
			type: 'TextField',
			filters: {
				pfiltro: 'rec.hh_normal',
				type: 'numeric'},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'hh_extras',
				fieldLabel: 'HH Extras',
				allowBlank: true,
				width: '100%',
				gwidth: 100,
				maxLength: 100,
				hidden: true
			},
			type: 'TextField',
			filters: {
				pfiltro: 'rec.hh_extras',
				type: 'numeric'},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'hh_ext_mov',
				fieldLabel: 'HH Ext. Mov.',
				allowBlank: true,
				width: '100%',
				gwidth: 100,
				maxLength: 100,
				hidden: true
			},
			type: 'TextField',
			filters: {
				pfiltro: 'rec.hh_ext_mov',
				type: 'numeric'},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'codigo',
				fieldLabel: 'Codigo',
				allowBlank: true,
				width: '100%',
				gwidth: 100,
				maxLength: 100,
				hidden: true
			},
			type: 'TextField',
			filters: {
				pfiltro: 'rec.codigo',
				type: 'string'},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'existencias',
				fieldLabel: 'Existencias',
				allowBlank: true,
				width: '100%',
				gwidth: 150,
				maxLength: 2000
			},
			type: 'TextArea',
			filters: {
				pfiltro: 'rec.existencias',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_moneda',
				fieldLabel: 'Moneda',
				allowBlank: true,
				emptyText: 'Seleccione una Moneda...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/Moneda/listarMoneda',
					id: 'id_moneda',
					root: 'datos',
					sortInfo: {
						field: 'codigo',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_moneda','codigo'],
					remoteSort: true,
					baseParams: {par_filtro:'codigo'}
				}),
				hidden: true,
				valueField: 'id_moneda',
				displayField: 'codigo',
				gdisplayField: 'codigo_moneda',
				forceSelection: false,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 500,
				anchor: '99%',
				gwidth: 70,
				minChars: 2,
				renderer: function (value, p, record) {
					return String.format('{0}', value?record.data['codigo_moneda']:'');
				}
			},
			type: 'ComboBox',
			filters: {
				pfiltro: 'mon.codigo',
				type: 'string'
			},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'costo',
				fieldLabel: 'Costo',
				allowBlank: true,
				width: 150,
				gwidth: 70,
				maxLength: 100,
				hidden: true
			},
			type: 'TextField',
			filters: {
				pfiltro: 'rec.costo',
				type: 'numeric'},
			id_grupo: 1,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_unidad_medida',
				fieldLabel: 'Unidad',
				allowBlank: true,
				emptyText: 'Elija una unidad...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/UnidadMedida/listarUnidadMedida',
					id: 'id_unidad_medida',
					root: 'datos',
					sortInfo: {
						field: 'codigo',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_unidad_medida','codigo'],
					remoteSort: true,
					baseParams: {par_filtro:'ume.codigo'}
				}),
				hidden: true,
				valueField: 'id_unidad_medida',
				displayField: 'codigo',
				gdisplayField: 'codigo_unidad_medida',
				forceSelection: false,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 500,
				anchor: '99%',
				gwidth: 150,
				minChars: 2,
				renderer: function (value, p, record) {
					return String.format('{0}', value?record.data['codigo_unidad_medida']:'');
				}
			},
			type: 'ComboBox',
			filters: {
				pfiltro: 'unimed.codigo',
				type: 'string'
			},
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config: {
				name: 'cantidad',
				fieldLabel: 'Cantidad',
				allowBlank: true,
				width: 150,
				gwidth: 70,
				maxLength: 100,
				hidden: true
			},
			type: 'TextField',
			filters: {
				pfiltro: 'rec.cantidad',
				type: 'numeric'},
			id_grupo: 1,
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
				pfiltro: 'rec.observaciones',
				type: 'string'
			},
			id_grupo: 1,
			grid: true,
			form: true
		}
	],

	title: 'Recursos',
	ActSave: '../../sis_mantenimiento/control/Recurso/guardarRecursoActividad',
	ActDel: '../../sis_mantenimiento/control/Recurso/eliminarRecurso',
	ActList: '../../sis_mantenimiento/control/Recurso/listarRecursoActividad',
	id_store: 'id_recurso',
	fields: [
		{name: 'id_recurso', type: 'numeric'},
		{name: 'id_usuario_reg', type: 'numeric'},
		{name: 'usr_reg', type: 'string'},
		{name: 'id_usuario_mod', type: 'numeric'},
		{name: 'usr_mod', type: 'string'},
		{name: 'fecha_reg', type: 'timestamp'},
		{name: 'fecha_mod', type: 'timestamp'},
		{name: 'estado_reg', type: 'string'},
		{name: 'id_actividad', type: 'numeric'},
		{name: 'id_item', type: 'numeric'},
		{name: 'nombre_item', type: 'varchar'},
		{name: 'id_funcionario', type: 'numeric'},
		{name: 'nombre_funcionario', type: 'varchar'},
		{name: 'id_especialidad', type: 'numeric'},
		{name: 'nombre_especialidad', type: 'varchar'},
		{name: 'id_servicio', type: 'numeric'},
		{name: 'nombre_servicio', type: 'varchar'},
		{name: 'id_tarea', type: 'numeric'},
		{name: 'nombre_tarea', type: 'varchar'},
		{name: 'id_moneda', type: 'numeric'},
		{name: 'codigo_moneda', type: 'varchar'},
		{name: 'cantidad', type: 'numeric'},
		{name: 'costo', type: 'numeric'},
		{name: 'observaciones', type: 'varchar'},
		{name: 'id_unidad_medida', type: 'int4'},
		{name: 'codigo_unidad_medida', type: 'varchar'},
		{name: 'hh_normal', type: 'int4'},
		{name: 'hh_extras', type: 'int4'},
		{name: 'hh_ext_mov', type: 'int4'},
		{name: 'codigo', type: 'varchar'},
		{name: 'existencias', type: 'varchar'}
	],
	sortInfo:{
		field: 'id_recurso',
		direction: 'ASC'
	},
	fheight: 450,
	fwidth: 410,
	onReloadPage:function(m) {
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_actividad;
		if(m.id != 'id') {
			this.store.baseParams={id_actividad:this.maestro.id_actividad};
			this.load({params:{start:0, limit:50}})
	    }
	    else {
			this.grid.getTopToolbar().disable();
			this.grid.getBottomToolbar().disable(); 
			this.store.removeAll(); 
		}
	},
	onButtonEdit: function() {
        Phx.vista.recurso.superclass.onButtonEdit.call(this);
        var data = this.getSelectedData();
	  	if(data.id_item != undefined) {
	  		this.getComponente('recurso').setValue('item');
	  		this.onRecursoSelect(this.getComponente('recurso'));
	  	} else if(data.id_funcionario != undefined) {
	  		this.getComponente('recurso').setValue('funcionario');
	  		this.onRecursoSelect(this.getComponente('recurso'));
	  	} else if(data.id_especialidad != undefined) {
	  		this.getComponente('recurso').setValue('especialidad');
	  		this.onRecursoSelect(this.getComponente('recurso'));
	  	} else if(data.id_servicio != undefined) {
	  		this.getComponente('recurso').setValue('servicio');
	  		this.onRecursoSelect(this.getComponente('recurso'));
	  	}
    },
    loadValoresIniciales:function(){
		Phx.vista.recurso.superclass.loadValoresIniciales.call(this);
		this.onRecursoSelect(this.getComponente('recurso'));		
	},
    onRecursoSelect: function(e, data, index) {
         	if(e.value == 'item') {
         		this.getComponente('id_item').setVisible(true);
         		this.getComponente('id_funcionario').setVisible(false);
         		this.getComponente('id_especialidad').setVisible(false);
         		this.getComponente('id_servicio').setVisible(false);
         		this.getComponente('hh_normal').setVisible(false);
         		this.getComponente('hh_extras').setVisible(false);
         		this.getComponente('hh_ext_mov').setVisible(false);
         		this.getComponente('id_unidad_medida').setVisible(true);
         		this.getComponente('cantidad').setVisible(true);
         		this.getComponente('id_moneda').setVisible(true);
         		this.getComponente('costo').setVisible(true);
         		this.getComponente('codigo').setVisible(true);
         		this.getComponente('existencias').setVisible(true);
         	}
         	else if(e.value == 'funcionario') {
         		this.getComponente('id_item').setVisible(false);
         		this.getComponente('id_funcionario').setVisible(true);
         		this.getComponente('id_especialidad').setVisible(false);
         		this.getComponente('id_servicio').setVisible(false);
         		this.getComponente('hh_normal').setVisible(true);
         		this.getComponente('hh_extras').setVisible(true);
         		this.getComponente('hh_ext_mov').setVisible(true);
         		this.getComponente('id_unidad_medida').setVisible(false);
         		this.getComponente('cantidad').setVisible(false);
         		this.getComponente('id_moneda').setVisible(false);
         		this.getComponente('costo').setVisible(false);
         		this.getComponente('codigo').setVisible(false);
         		this.getComponente('existencias').setVisible(false);
         	}
         	else if(e.value == 'especialidad') {
         		this.getComponente('id_item').setVisible(false);
         		this.getComponente('id_funcionario').setVisible(false);
         		this.getComponente('id_especialidad').setVisible(true);
         		this.getComponente('id_servicio').setVisible(false);
         		this.getComponente('hh_normal').setVisible(false);
         		this.getComponente('hh_extras').setVisible(false);
         		this.getComponente('hh_ext_mov').setVisible(false);
         		this.getComponente('id_unidad_medida').setVisible(false);
         		this.getComponente('cantidad').setVisible(false);
         		this.getComponente('id_moneda').setVisible(false);
         		this.getComponente('costo').setVisible(false);
         		this.getComponente('codigo').setVisible(false);
         		this.getComponente('existencias').setVisible(false);
         	}
         	else if(e.value == 'servicio') {
         		this.getComponente('id_item').setVisible(false);
         		this.getComponente('id_funcionario').setVisible(false);
         		this.getComponente('id_especialidad').setVisible(false);
         		this.getComponente('id_servicio').setVisible(true);
         		this.getComponente('hh_normal').setVisible(false);
         		this.getComponente('hh_extras').setVisible(false);
         		this.getComponente('hh_ext_mov').setVisible(false);
         		this.getComponente('id_unidad_medida').setVisible(false);
         		this.getComponente('cantidad').setVisible(false);
         		this.getComponente('id_moneda').setVisible(false);
         		this.getComponente('costo').setVisible(false);
         		this.getComponente('codigo').setVisible(false);
         		this.getComponente('existencias').setVisible(false);
         	} else {
         		this.getComponente('id_item').setVisible(false);
         		this.getComponente('id_funcionario').setVisible(false);
         		this.getComponente('id_especialidad').setVisible(false);
         		this.getComponente('id_servicio').setVisible(false);
         		this.getComponente('hh_normal').setVisible(false);
         		this.getComponente('hh_extras').setVisible(false);
         		this.getComponente('hh_ext_mov').setVisible(false);
         		this.getComponente('id_unidad_medida').setVisible(false);
         		this.getComponente('cantidad').setVisible(false);
         		this.getComponente('id_moneda').setVisible(false);
         		this.getComponente('costo').setVisible(false);
         		this.getComponente('codigo').setVisible(false);
         		this.getComponente('existencias').setVisible(false);
         	}
        }
  }
)
</script>
		
		