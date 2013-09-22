<?php
/**
*@package pXP
*@file gen-Funcion.php
*@author  (admin)
*@date 30-09-2012 21:50:33
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.FFuncion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.FFuncion.superclass.constructor.call(this,config);
		this.addButton('btnFallaFuncion',{
            text :'Fallas',
            iconCls : 'blist',
            disabled: true,
            handler : this.onButtonFuncionFalla,
            tooltip : '<b>Falla Funcion</b><br/><b>Fallas de funcion</b>'
        });
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
					name: 'id_funcion'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_analisis_mant'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: false,
				anchor: '100%',
				gwidth: 200,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'gefunc.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'orden',
				fieldLabel: 'Orden',
				allowBlank: true,
				anchor: '100%',
				gwidth: 80,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'gefunc.orden',type:'numeric'},
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
			filters:{pfiltro:'gefunc.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'gefunc.fecha_reg',type:'date'},
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
			filters:{pfiltro:'gefunc.fecha_mod',type:'date'},
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
	title:'Funciones',
	ActSave:'../../sis_mantenimiento/control/Funcion/insertarFuncion',
	ActDel:'../../sis_mantenimiento/control/Funcion/eliminarFuncion',
	ActList:'../../sis_mantenimiento/control/Funcion/listarFuncion',
	id_store:'id_funcion',
	fields: [
		{name:'id_funcion', type: 'numeric'},
		{name:'id_analisis_mant', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'orden', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_funcion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	fwidth: 450,
	fheight: 220,
	loadValoresIniciales:function(){
		Phx.vista.FFuncion.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_analisis_mant').setValue(this.maestro.id_analisis_mant);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_analisis_mant:this.maestro.id_analisis_mant};
		this.load({params:{start:0, limit:50}});			
	},	
    
    onButtonFuncionFalla : function (){                   
            var rec=this.sm.getSelected();
                        
            Phx.CP.loadWindows('../../../sis_mantenimiento/vista/funcion_falla/FuncionFalla.php',
            'Fallas de Función',
            {
                modal:true,
                width:800,
                height:600
            },rec.data,this.idContenedor,'FuncionFalla')
    },
    preparaMenu: function(n) {
		var tb = Phx.vista.FFuncion.superclass.preparaMenu.call(this);
	  	this.getBoton('btnFallaFuncion').setDisabled(false);
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.FFuncion.superclass.liberaMenu.call(this);
		this.getBoton('btnFallaFuncion').setDisabled(true);
		return tb;
	},
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		
		