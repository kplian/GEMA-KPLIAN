<?php
/**
*@package pXP
*@file gen-MantPredefItem.php
*@author  (admin)
*@date 10-10-2013 23:53:04
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MantPredefItem=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.MantPredefItem.superclass.constructor.call(this,config);
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
					name: 'id_mant_predef_item'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_mant_predef'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'id_item',
				fieldLabel: 'Repuesto/ Material',
				allowBlank: false,
				emptyText: 'Elija un material...',
				store: new Ext.data.JsonStore({
					url: '../../sis_almacenes/control/Item/listarItem',
					id: 'id_item',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_item','nombre','codigo_unidad','id_unidad_medida','codigo'],
					remoteSort: true,
					baseParams: {par_filtro:'item.nombre'}
				}),
				//hidden: true,
				valueField: 'id_item',
				displayField: 'nombre',
				gdisplayField: 'desc_item',
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
					return String.format('{0}', value?record.data['desc_item']:'');
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>Código: {codigo}</p><p>Nombre: {nombre}</p><p>Unid.Med.: {codigo_unidad}</p></div></tpl>',
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
			config:{
				name: 'cantidad_item',
				fieldLabel: 'Cantidad',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'NumberField',
			filters:{pfiltro:'maprit.cantidad_item',type:'numeric'},
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
				filters:{pfiltro:'maprit.estado_reg',type:'string'},
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
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'maprit.fecha_reg',type:'date'},
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
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'maprit.fecha_mod',type:'date'},
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
	tam_pag:50,	
	title:'Repuestos por Mantenimiento',
	ActSave:'../../sis_mantenimiento/control/MantPredefItem/insertarMantPredefItem',
	ActDel:'../../sis_mantenimiento/control/MantPredefItem/eliminarMantPredefItem',
	ActList:'../../sis_mantenimiento/control/MantPredefItem/listarMantPredefItem',
	id_store:'id_mant_predef_item',
	fields: [
		{name:'id_mant_predef_item', type: 'numeric'},
		{name:'id_mant_predef', type: 'numeric'},
		{name:'id_item', type: 'numeric'},
		{name:'cantidad_item', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_item', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_mant_predef_item',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function(){
		Phx.vista.MantPredefItem.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_mant_predef').setValue(this.maestro.id_mant_predef);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_mant_predef:this.maestro.id_mant_predef};
		this.load({params:{start:0, limit:this.tam_pag}});			
	}
})
</script>
		
		