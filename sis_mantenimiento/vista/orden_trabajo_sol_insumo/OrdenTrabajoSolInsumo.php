<?php
/**
*@package pXP
*@file gen-OrdenTrabajoSolInsumo.php
*@author  (admin)
*@date 17-02-2013 07:39:55
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.OrdenTrabajoSolInsumo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.OrdenTrabajoSolInsumo.superclass.constructor.call(this,config);
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_orden_trabajo_sol_insumo'
			},
			type:'Field',
			form:true 
		},
		{
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
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'otsoin.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cant_insum',
				fieldLabel: 'Cantidad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'otsoin.cant_insum',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'id_unidad_medida',
				fieldLabel: 'Unidad Medida',
				allowBlank: false,
				origen: 'UNIDADMEDIDA',
				gdisplayField: 'unidad_medida',
				gwidth: 200,
				renderer:function(value, p, record){return String.format('{0}', record.data['unidad_medida']);},
				anchor: '100%',
				tipo:''
			},
			type: 'ComboRec',
			id_grupo: 1,
			filters:{pfiltro:'otsoin.descripcion',type:'string'},
			grid: true,
			form: true
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
			filters:{pfiltro:'otsoin.estado_reg',type:'string'},
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
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'otsoin.fecha_reg',type:'date'},
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
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'otsoin.fecha_mod',type:'date'},
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
	
	title:'Insumos',
	ActSave:'../../sis_mantenimiento/control/OrdenTrabajoSolInsumo/insertarOrdenTrabajoSolInsumo',
	ActDel:'../../sis_mantenimiento/control/OrdenTrabajoSolInsumo/eliminarOrdenTrabajoSolInsumo',
	ActList:'../../sis_mantenimiento/control/OrdenTrabajoSolInsumo/listarOrdenTrabajoSolInsumo',
	id_store:'id_orden_trabajo_sol_insumo',
	fields: [
		{name:'id_orden_trabajo_sol_insumo', type: 'numeric'},
		{name:'id_orden_trabajo_sol', type: 'numeric'},
		{name:'id_unidad_medida', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'cant_insum', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'unidad_medida', type: 'string'}
	],
	sortInfo:{
		field: 'id_orden_trabajo_sol_insumo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function(){
		Phx.vista.OrdenTrabajoSolInsumo.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_orden_trabajo_sol').setValue(this.maestro.id_orden_trabajo_sol);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_orden_trabajo_sol:this.maestro.id_orden_trabajo_sol};
		this.load({params:{start:0, limit:50}});			
	},
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		
		