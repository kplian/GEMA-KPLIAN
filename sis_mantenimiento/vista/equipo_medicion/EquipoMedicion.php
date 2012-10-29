<?php
/**
*@package pXP
*@file gen-EquipoMedicion.php
*@author  (admin)
*@date 27-09-2012 03:02:35
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.EquipoMedicion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.EquipoMedicion.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_equipo_medicion'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_uni_cons',
				fieldLabel: 'Equipo',
				allowBlank: false,
				emptyText:'Elija un Equipo...',
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
				gdisplayField:'desc_equipo',
				//hiddenName: 'id_administrador',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_equipo']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'getieq.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_equipo_variable',
				fieldLabel: 'Variable',
				allowBlank: false,
				emptyText:'Elija una Variable...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/EquipoVariable/listarVariables',
					id: 'id_equipo_variable',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_equipo_variable','id_tipo_variable','valor_max','valor_min','codigo','descripcion','id_unidad_medida','desc_un_med'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_equipo_variable',
				displayField: 'descripcion',
				gdisplayField:'desc_tipo_variable',
				//hiddenName: 'id_administrador',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_tipo_variable']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'getieq.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_medicion',
				fieldLabel: 'Fecha Medición',
				allowBlank: true,
				anchor: '80%',
				gwidth: 180,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				format:'m/d/Y'
			},
			type:'DateField',
			filters:{pfiltro:'gemedi.fecha_medicion',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'medicion',
				fieldLabel: 'Medición',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'NumberField',
			filters:{pfiltro:'gemedi.medicion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '100%',
				gwidth: 300,
				maxLength:2000
			},
			type:'TextArea',
			filters:{pfiltro:'gemedi.observaciones',type:'string'},
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
			filters:{pfiltro:'gemedi.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'gemedi.fecha_reg',type:'date'},
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
			filters:{pfiltro:'gemedi.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Mediciones',
	ActSave:'../../sis_mantenimiento/control/EquipoMedicion/insertarEquipoMedicion',
	ActDel:'../../sis_mantenimiento/control/EquipoMedicion/eliminarEquipoMedicion',
	ActList:'../../sis_mantenimiento/control/EquipoMedicion/listarEquipoMedicion',
	id_store:'id_equipo_medicion',
	fields: [
		{name:'id_equipo_medicion', type: 'numeric'},
		{name:'id_equipo_variable', type: 'numeric'},
		{name:'observaciones', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_medicion', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'medicion', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'valor_max', type: 'numeric'},
		{name:'valor_min', type: 'numeric'},
		{name:'nombre_tipo_variable', type: 'string'},
		{name:'desc_tipo_variable', type: 'string'},
		{name:'desc_unidad_medida', type: 'string'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'cod_equipo', type: 'string'},
		{name:'desc_equipo', type: 'string'},
		{name:'desc_tipo_variable', type: 'string'}
	],
	east:{
		  url:'../../../sis_mantenimiento/vista/equipo_medicion/Indicadores.php',
		  title:'Indicadores', 
		  //height:'50%',	//altura de la ventana hijo
		  width:'50%',		//ancho de la ventana hjo
		  cls:'Indicadores'
	},
	sortInfo:{
		field: 'id_equipo_medicion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		