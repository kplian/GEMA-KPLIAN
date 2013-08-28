<?php
/**
*@package pXP
*@file gen-EquipoMedicionConsol.php
*@author  (admin)
*@date 08-12-2012 05:45:32
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.EquipoMedicionConsol=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
    	//llama al constructor de la clase padre
		Phx.vista.EquipoMedicionConsol.superclass.constructor.call(this,config);
		
		this.dteFechaIni = new Ext.form.DateField({
			vtype: 'daterange',
		    name:  'startdt1',
		    format: 'd/m/Y',
		    allowBlank: false,
		    id: 'startdt'+this.idContenedor,
	        endDateField: 'enddt'+this.idContenedor,
	        width:103
		});
		this.dteFechaFin = new Ext.form.DateField({
		    vtype: 'daterange',
		    name: 'enddt1',
		    format: 'd/m/Y',
		    allowBlank: false,
	        id: 'enddt'+this.idContenedor,
	        startDateField: 'startdt'+this.idContenedor,
	        width:103
		});
		
		this.tbar.add('Desde: ',this.dteFechaIni);
	    this.tbar.add('Hasta: ',this.dteFechaFin);
	    
	    if(isNaN(this.maestro.id_localizacion)){
	    	if(isNaN(this.maestro.id_uni_cons)){
	    		
	    	}
	    } else{
	    	this.getComponente('id_localizacion').setValue(this.maestro.id_localizacion);	
	    }
		
		this.init();
		
		var milisegundos=parseInt(7*24*60*60*1000);
		var fechaActual = new Date();
		var fechaini  = new Date();
		fechaini.setTime(parseInt(fechaActual.getTime()-milisegundos));
		this.dteFechaIni.setValue(fechaini);
		this.dteFechaFin.setValue(fechaActual);
		
		if(isNaN(this.maestro.id_localizacion)){
	    	if(!isNaN(this.maestro.id_uni_cons)){
	    		this.store.baseParams={
					'id_uni_cons':this.maestro.id_uni_cons,
					fecha_desde:this.dteFechaIni.getValue().dateFormat('d/m/Y'),
					fecha_hasta:this.dteFechaFin.getValue().dateFormat('d/m/Y') 
				};
	    	}
	    } else{
	    	this.store.baseParams={
				id_localizacion:this.maestro.id_localizacion,
				id_uni_cons:this.maestro.id_uni_cons,
				fecha_desde:this.dteFechaIni.getValue().dateFormat('d/m/Y'),
				fecha_hasta:this.dteFechaFin.getValue().dateFormat('d/m/Y') 
			};	
	    }
		
		
		this.load({params:{start:0, limit:50}})
	},
			
	Atributos:[
		{
			config:{
				name: 'id_localizacion',
				inputType: 'hidden',
				labelSeparator: ''
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 200,
				maxLength:15
			},
			type:'TextField',
			filters:{pfiltro:'tvar.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'total',
				fieldLabel: 'Total',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'unidad_medida',
				fieldLabel: 'Unidad Medida',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'umed.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Unidad Medida Descripción',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'umed.descripcin',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Consolidacion de Mediciones de Equipos',
	ActList:'../../sis_mantenimiento/control/EquipoMedicion/listarMedicionConsol',
	id_store:'id_localizacion',
	fields: [
		{name:'nombre', type: 'string'},
		{name:'total', type: 'bigint'},
		{name:'unidad_medida', type: 'string'},
		{name:'descripcion', type: 'string'}
	],
	sortInfo:{
		field: 'id_localizacion',
		direction: 'ASC'
	},
	bdel:false,
	bsave:false,
	bedit:false,
	loadValoresIniciales:function(){
		Phx.vista.EquipoMedicionConsol.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_localizacion').setValue(this.maestro.id_localizacion);
	},	
	onReloadPage:function(m)
	{
		this.maestro=m;	
		this.store.baseParams={
			id_localizacion:this.maestro.id_localización,
			id_uni_cons:this.maestro.id_uni_cons,
			fecha_desde:this.dteFechaIni.getValue().dateFormat('d/m/Y'),
			fecha_hasta:this.dteFechaFin.getValue().dateFormat('d/m/Y')};
		this.load({params:{start:0, limit:50}});			
	},
	onButtonAct:function(){
		if(this.dteFechaIni.isValid() && this.dteFechaFin.isValid())
		{
			this.store.baseParams=Ext.apply(this.store.baseParams,{fecha_desde:this.dteFechaIni.getValue().dateFormat('d/m/Y'),
																	fecha_hasta:this.dteFechaFin.getValue().dateFormat('d/m/Y')
																});
			
			
			if(this.store.lastOptions){
			 //Phx.vista.EquipoMedicionDinamico.superclass.onButtonAct.call(this);
			 
			 this.load({params:{start:0, limit:50},callback:this.successReloadGrid,scope:this})
			}
			else{
				this.load({params:{start:0, limit:50},callback:this.successReloadGrid,scope:this})
			}
			
		}
		
	},
	successReloadGrid:function(rec,con,res){

		
	},
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
})
</script>
		
		