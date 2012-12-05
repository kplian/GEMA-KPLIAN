<?php
/**
*@package pXP
*@file gen-MantPredef.php
*@author  (admin)
*@date 28-08-2012 20:25:32
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MantPredef=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.MantPredef.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_mant_predef'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'gemapr.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '100%',
				gwidth: 150,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'gemapr.nombre',type:'string'},
			id_grupo:1,
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
				maxLength:1000
			},
			type:'TextField',
			filters:{pfiltro:'gemapr.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'id_tipo_equipo',
				fieldLabel: 'Tipo Equipo',
				allowBlank: false,
				emptyText:'Elija un tipo de equipo...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/TipoEquipo/listarTipoEquipo',
					id: 'id_tipo_equipo',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_tipo_equipo','nombre','descripcion'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_tipo_equipo',
				displayField: 'nombre',
				gdisplayField:'desc_tipo_equipo',
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
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_tipo_equipo']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'getieq.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'id_unidad_medida_estimado',
				fieldLabel: 'Unidad Medida',
				allowBlank: false,
				origen: 'UNIDADMEDIDA',
				gdisplayField: 'desc_unidad_medida_estimado',
				gwidth: 200,
				renderer:function(value, p, record){return String.format('{0}', record.data['desc_unidad_medida_estimado']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'gemapr.tipo',type:'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'tiempo_estimado',
				fieldLabel: 'Tiempo estimado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'gemapr.tiempo_estimado',type:'numeric'},
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
			filters:{pfiltro:'gemapr.estado_reg',type:'string'},
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
			filters:{pfiltro:'gemapr.fecha_reg',type:'date'},
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
			filters:{pfiltro:'gemapr.fecha_mod',type:'date'},
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
	title:'Mantenimientos predefinidos',
	ActSave:'../../sis_mantenimiento/control/MantPredef/insertarMantPredef',
	ActDel:'../../sis_mantenimiento/control/MantPredef/eliminarMantPredef',
	ActList:'../../sis_mantenimiento/control/MantPredef/listarMantPredef',
	id_store:'id_mant_predef',
	fields: [
		{name:'id_mant_predef', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'id_tipo_equipo', type: 'numeric'},
		{name:'desc_tipo_equipo', type: 'string'},
		{name:'id_unidad_medida_estimado', type: 'numeric'},
		{name:'tiempo_estimado', type: 'numeric'},
		{name:'desc_unidad_medida_estimado', type: 'string'}
	],
	south:{
		  url:'../../../sis_mantenimiento/vista/mant_predef_det/MantPredefDet.php',
		  title:'Detalle actividades', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'MantPredefDet'
	},	
	sortInfo:{
		field: 'id_mant_predef',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		