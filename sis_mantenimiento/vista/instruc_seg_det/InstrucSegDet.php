<?php
/**
*@package pXP
*@file gen-InstrucSegDet.php
*@author  (admin)
*@date 13-04-2013 03:01:16
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.InstrucSegDet=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.InstrucSegDet.superclass.constructor.call(this,config);
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		this.init();
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_instruc_seg_det'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_instruc_seg'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nro',
				fieldLabel: 'Nro.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 70,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'insede.nro',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '80%',
				gwidth: 400,
				maxLength:1000
			},
			type:'TextField',
			filters:{pfiltro:'insede.descripcion',type:'string'},
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
			filters:{pfiltro:'insede.estado_reg',type:'string'},
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
			filters:{pfiltro:'insede.fecha_reg',type:'date'},
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
			filters:{pfiltro:'insede.fecha_mod',type:'date'},
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
	
	title:'Detalle de Instrucciones de Seguridad',
	ActSave:'../../sis_mantenimiento/control/InstrucSegDet/insertarInstrucSegDet',
	ActDel:'../../sis_mantenimiento/control/InstrucSegDet/eliminarInstrucSegDet',
	ActList:'../../sis_mantenimiento/control/InstrucSegDet/listarInstrucSegDet',
	id_store:'id_instruc_seg_det',
	loadValoresIniciales:function(){
		Phx.vista.InstrucSegDet.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_instruc_seg').setValue(this.maestro.id_instruc_seg);		
	},
	tam_pag:50,
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_instruc_seg:this.maestro.id_instruc_seg};
		this.load({params:{start:0, limit:this.tam_pag}});			
	},
	fields: [
		{name:'id_instruc_seg_det', type: 'numeric'},
		{name:'id_instruc_seg', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'nro', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_instruc_seg_det',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
	}
)
</script>
		
		