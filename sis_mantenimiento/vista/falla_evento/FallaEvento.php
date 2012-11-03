<?php
/**
*@package pXP
*@file gen-FallaEvento.php
*@author  (admin)
*@date 30-09-2012 21:53:04
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FallaEvento=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.FallaEvento.superclass.constructor.call(this,config);
		this.init();
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
					name: 'id_falla_evento'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tipo_equipo'
			},
			type:'Field',
			form:true 
		},
		{
	       	config:{
	       			name:'tipo',
	       			fieldLabel:'Falla/Evento',
	       			allowBlank:false,
	       			emptyText:'Evento/Falla...',
	       			typeAhead: true,
	       		    triggerAction: 'all',
	       		    lazyRender:true,
	       		    mode: 'local',
	       		    //readOnly:true,
	       		    valueField: 'tipo',
	       		   // displayField: 'descestilo',
	       		    store:['falla','evento']
	       		},
	       		type:'ComboBox',
	       		id_grupo:0,
	       		filters:{	
	       		         type: 'list',
	       				 options: ['falla','evento'],	
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
			filters:{pfiltro:'gefaev.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
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
			filters:{pfiltro:'gefaev.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'gefaev.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
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
			filters:{pfiltro:'gefaev.fecha_reg',type:'date'},
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
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'gefaev.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Falla/Evento',
	ActSave:'../../sis_mantenimiento/control/FallaEvento/insertarFallaEvento',
	ActDel:'../../sis_mantenimiento/control/FallaEvento/eliminarFallaEvento',
	ActList:'../../sis_mantenimiento/control/FallaEvento/listarFallaEvento',
	id_store:'id_falla_evento',
	fields: [
		{name:'id_falla_evento', type: 'numeric'},
		{name:'id_tipo_equipo', type: 'numeric'},
		{name:'tipo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_falla_evento',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function()
	{
		Phx.vista.FallaEvento.superclass.loadValoresIniciales.call(this);
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
})
</script>
		
		