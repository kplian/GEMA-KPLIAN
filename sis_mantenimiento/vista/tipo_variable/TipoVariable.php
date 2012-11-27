<?php
/**
*@package pXP
*@file gen-TipoVariable.php
*@author  (rac)
*@date 15-08-2012 15:28:09
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.TipoVariable=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TipoVariable.superclass.constructor.call(this,config);
		this.init();
		//deshabilita botones
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		//this.load({params:{start:0, limit:50}})
		 if(Phx.CP.getPagina(this.idContenedorPadre)){
      	 var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
	 	 if(dataMaestro){
	 	 	this.onEnablePanel(this,dataMaestro)
	 	 }
	  }
	  
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_variable'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_tipo_equipo',
				inputType:'hidden',
				fieldLabel: ''
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'tva.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},{
       			config:{
       				name:'id_unidad_medida',
       				fieldLabel:'Unidad de Medida',
       				allowBlank:false,
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
				maxLength:300
			},
			type:'TextArea',
			filters:{pfiltro:'tva.descripcion',type:'string'},
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
			filters:{pfiltro:'tva.estado_reg',type:'string'},
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
			filters:{pfiltro:'tva.fecha_reg',type:'date'},
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
			filters:{pfiltro:'tva.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '100%',
				maxLength:300,
				gwidth: 200
			},
			type:'TextArea',
			filters:{pfiltro:'tva.observaciones',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		}
	],
	title:'Variables Tipo',
	ActSave:'../../sis_mantenimiento/control/TipoVariable/insertarTipoVariable',
	ActDel:'../../sis_mantenimiento/control/TipoVariable/eliminarTipoVariable',
	ActList:'../../sis_mantenimiento/control/TipoVariable/listarTipoVariable',
	id_store:'id_tipo_variable',
	fields: [
		{name:'id_tipo_variable', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'id_tipo_equipo', type: 'numeric'},
		{name:'id_unidad_medida', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'codigo_unidad_medida', type: 'string'},
		{name:'observaciones', type: 'string'}
	],
	sortInfo:{
		field: 'id_tipo_variable',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function()
	{
		Phx.vista.TipoVariable.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_tipo_equipo').setValue(this.maestro.id_tipo_equipo);		
	},
	onReloadPage:function(m){

       
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_tipo_equipo;
        if(m.id != 'id'){
    	this.store.baseParams={id_tipo_equipo:this.maestro.id_tipo_equipo};
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
		
		