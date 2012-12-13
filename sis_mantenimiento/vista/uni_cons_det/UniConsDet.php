<?php
/**
*@package pXP
*@file gen-UniConsDet.php
*@author  (admin)
*@date 08-11-2012 21:12:55
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UniConsDet=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.UniConsDet.superclass.constructor.call(this,config);
		this.init();
		this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll();
		
		//this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons_det'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_uni_cons',
				inputType:'hidden'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'codigo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:8,
				inputType:'hidden'
			},
			type:'TextField',
			filters:{pfiltro:'ucdet.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:25
			},
			type:'TextField',
			filters:{pfiltro:'ucdet.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'valor',
				fieldLabel: 'valor',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2000
			},
			type:'TextField',
			filters:{pfiltro:'ucdet.valor',type:'string'},
			id_grupo:1,
			grid:true,
			egrid:true,
			form:true
		},
			{
       			config:{
       				name:'id_unidad_medida',
       				fieldLabel:'Unidad de Medida',
       				allowBlank:true,
       				emptyText:'Unidades...',
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
      					// turn on remote sorting
    					remoteSort: true,
    					baseParams:{par_filtro:'codigo#descripcion'}
    				}),
    				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{codigo} - {descripcion} </p></div></tpl>',
	       			
       				valueField: 'id_unidad_medida',
       				displayField: 'codigo',
       				gdisplayField: 'codigo_unidad_medida',
       				hiddenName: 'id_unidad_medida',
       				//forceSelection:false,
       				typeAhead: true,
           			triggerAction: 'all',
           			lazyRender:true,
       				mode:'remote',
       				pageSize:10,
       				queryDelay:1000,
       				width:150,
       				minChars:2,
       				minListWidth:300,
       				renderer:function(value, p, record){return String.format('{0}', record.data['codigo_unidad_medida']);}

       			},
       			type:'ComboBox',
       			id_grupo:0,
       			filters:{   pfiltro:'um.codigo',
       						type:'string'
       					},
       			grid:true,
       			form:true
       	},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'ucdet.descripcion',type:'string'},
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
			filters:{pfiltro:'ucdet.estado_reg',type:'string'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'ucdet.fecha_reg',type:'date'},
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
				//gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'ucdet.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Detalle de Equipo',
	ActSave:'../../sis_mantenimiento/control/UniConsDet/insertarUniConsDet',
	ActDel:'../../sis_mantenimiento/control/UniConsDet/eliminarUniConsDet',
	ActList:'../../sis_mantenimiento/control/UniConsDet/listarUniConsDet',
	id_store:'id_uni_cons_det',
	fields: ['codigo_unidad_medida',
		{name:'id_uni_cons_det', type: 'numeric'},
		{name:'id_unidad_medida', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'codigo', type: 'numeric'},
		{name:'nombre', type: 'numeric'},
		{name:'descripcion', type: 'numeric'},
		{name:'valor', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_uni_cons_det',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onReloadPage:function(m){
        this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_uni_cons;
		
		
		// this.Atributos.config['id_subsistema'].setValue(this.maestro.id_subsistema);

       if(m.id != 'id'){
    	
		this.store.baseParams={id_uni_cons:this.maestro.id_uni_cons};
		this.load({params:{start:0, limit:50}})
       
       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll(); 
    	   
       }


	}
})
</script>
		
		
