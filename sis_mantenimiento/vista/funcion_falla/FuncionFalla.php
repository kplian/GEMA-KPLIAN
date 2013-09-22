<?php
/**
*@package pXP
*@file gen-FuncionFalla.php
*@author  (admin)
*@date 30-09-2012 21:52:08
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FuncionFalla=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.FuncionFalla.superclass.constructor.call(this,config);
		//this.grid.getTopToolbar().disable();
		//this.grid.getBottomToolbar().disable();
		this.init();
		this.load({params:{start:0, limit:50,id_funcion:this.id_funcion}})
        this.loadValoresIniciales();
        this.ocultarComponente(this.getComponente('modo_falla'));
        this.ocultarComponente(this.getComponente('efecto_falla'));
        this.ocultarComponente(this.getComponente('id_falla_evento'));
	},
	
	loadValoresIniciales:function()
    {        
        Phx.vista.FuncionFalla.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_funcion').setValue(this.id_funcion);     
    },
    	
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcion_falla'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_funcion'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_falla_evento',
				fieldLabel: 'Falla',
				allowBlank: true,
				emptyText:'Elija una falla...',
				store:new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/FallaEvento/listarFallaEvento',
					id: 'id_falla_evento',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_falla_evento','nombre','codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_falla_evento',
				displayField: 'nombre',
				gdisplayField:'desc_falla_evento',
				//hiddenName: 'id_administrador',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_falla_evento']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'gefaev.nombre',type:'string'},
			id_grupo:0,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'falla',
				fieldLabel: 'Falla',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'gefall.falla',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'modo_falla',
				fieldLabel: 'Modo falla',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextField',
			filters:{pfiltro:'gefall.modo_falla',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'efecto_falla',
				fieldLabel: 'Efecto falla',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextField',
			filters:{pfiltro:'gefall.efecto_falla',type:'string'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config:{
				name: 'orden',
				fieldLabel: 'Orden',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:4
			},
			type:'TextField',
			filters:{pfiltro:'gefall.orden',type:'string'},
			id_grupo:1,
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
			filters:{pfiltro:'gefall.estado_reg',type:'string'},
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
			filters:{pfiltro:'gefall.fecha_reg',type:'date'},
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'gefall.fecha_mod',type:'date'},
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
	title:'Fallas',
	ActSave:'../../sis_mantenimiento/control/FuncionFalla/insertarFuncionFalla',
	ActDel:'../../sis_mantenimiento/control/FuncionFalla/eliminarFuncionFalla',
	ActList:'../../sis_mantenimiento/control/FuncionFalla/listarFuncionFalla',
	id_store:'id_funcion_falla',
	fields: [
		{name:'id_funcion_falla', type: 'numeric'},
		{name:'id_funcion', type: 'numeric'},
		{name:'id_falla_evento', type: 'numeric'},
		{name:'modo_falla', type: 'string'},
		{name:'orden', type: 'string'},
		{name:'efecto_falla', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_falla_evento', type: 'string'},
		'falla'
	],
	sortInfo:{
		field: 'id_funcion_falla',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	fwidth: 450,
	fheight: 250,
	/*
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_funcion:this.maestro.id_funcion};
		this.load({params:{start:0, limit:50}});			
	},*/
	
    south:{
          url:'../../../sis_mantenimiento/vista/modo_falla/ModoFalla.php',
          title:'Modo Falla', 
          height:'50%',   //altura de la ventana hijo
          width:'50%',      //ancho de la ventana hjo
          cls:'ModoFalla'
    },
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		
		