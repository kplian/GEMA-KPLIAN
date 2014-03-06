<?php
/**
*@package       pXP
*@file          gen-UniConsItem.php
*@author        (rac)
*@date          01-11-2012 11:53:15
*@description   Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.OrdenTrabajoCosto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
		Phx.vista.OrdenTrabajoCosto.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, id_orden_trabajo:this.id_orden_trabajo}})
		this.loadValoresIniciales();
	},
	
	loadValoresIniciales:function()
    {
        Phx.vista.OrdenTrabajoCosto.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_orden_trabajo').setValue(this.id_orden_trabajo);     
    },
			
	Atributos:[
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_orden_trabajo'
			},
			type:'Field',
			form:true 
		},
		{
		    config:{
		        name:'descripcion',
		        fieldLabel:'Descripción',
		        gwidth:200		        
		    },
		    type:'Field',
		    grid:true,
		    form:true
		},
		{
		    config:{
		        name:'costo',
		        fieldLabel:'Costo (Bs.)',
		        gwidth:120,
		        decimalPrecision:2	        
		    },
		    type:'Field',
		    grid:true,
		    form:true
		}
	],
	title:'Costo de la Orden de Trabajo',
	ActList:'../../sis_mantenimiento/control/OrdenTrabajo/listarCostoOIT',
	id_store:'id_orden_trabajo',
	fields: [
		{name:'id_orden_trabajo', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'costo', type: 'numeric'}		
	],
	sortInfo:{
		field: 'descripcion',
		direction: 'ASC'
	},
	bdel:false,
	bsave:false,
	bedit:false,
	bnew:false,
	fwidth: 450,
	fheight: 250,
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		
		