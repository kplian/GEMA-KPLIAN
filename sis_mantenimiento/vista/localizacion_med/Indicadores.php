<?php
/**
*@package pXP
*@file gen-TipoMant.php
*@author  (admin)
*@date 17-08-2012 12:04:43
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.IndicadoresGraf=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
    	//llama al constructor de la clase padre
		Phx.vista.IndicadoresGraf.superclass.constructor.call(this,config);
		this.init();
		this.getComponente('id_localizacion').setValue(this.maestro.id_localizacion);
		//deshabilita botones
		/*this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();*/
		this.load({params:{
			start:0,
			limit:50,
			id_localizacion:this.maestro.id_localizacion,
			num_dias: this.maestro.num_dias,
			fecha_ini: this.maestro.fecha_ini,
			fecha_fin: this.maestro.fecha_fin
			}});
		/*if(Phx.CP.getPagina(this.idContenedorPadre)){
	      	var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
		 	if(dataMaestro){
		 		this.onEnablePanel(this,dataMaestro)
	 		}
		}*/
	},
	v_id_localizacion:'',
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
				fieldLabel: 'Indicador',
				allowBlank: false,
				anchor: '80%',
				gwidth: 170,
				maxLength:20
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'indicador',
				fieldLabel: 'Valor',
				allowBlank: false,
				anchor: '80%',
				gwidth: 150,
				maxLength:100
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: false,
				anchor: '80%',
				gwidth: 250,
				maxLength:100
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		}
	],
	title:'Indicadores',
	ActSave:'../../sis_mantenimiento/control/TipoMant/insertarTipoMant',
	ActDel:'../../sis_mantenimiento/control/TipoMant/eliminarTipoMant',
	ActList:'../../sis_mantenimiento/control/LocalizacionMed/listarIndicadores',
	id_store:'nombre',
	fields: [
		{name:'id_localizacion', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'indicador', type: 'numeric'},
		{name:'observaciones', type: 'string'}
	],
	sortInfo:{
		field: 'nombre',
		direction: 'ASC'
	},
	bdel:false,
	bsave:false,
	bedit:false,
	bnew: false,
	bexcel:false,
	loadValoresIniciales:function(){
		Phx.vista.FallaEvento.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_localizacion').setValue(this.maestro.id_localizacion);		
	},
	onReloadPage:function(m){
		this.maestro=m;
		this.Atributos[0].valorInicial=this.maestro.id_localizacion_orig;
        if(m.id != 'id'){
    	this.store.baseParams={id_localizacion:this.maestro.id_localizacion_orig};
		this.load({params:{start:0, limit:50}})
       
       }
       else{
    	 this.grid.getTopToolbar().disable();
   		 this.grid.getBottomToolbar().disable(); 
   		 this.store.removeAll(); 
    	   
       }
      },
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L',
	onLoadReady: function(a){
		/*Ext.Ajax.request({
				url: '../../sis_mantenimiento/control/LocalizacionMed/graficarIndicadores',
				params: {
					start:0,
					limit:50,
					id_localizacion:this.maestro.id_localizacion,
					num_dias: this.maestro.num_dias,
					fecha_ini: this.maestro.fecha_ini,
					fecha_fin: this.maestro.fecha_fin
				},
				success: this.successGrafInd,
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});*/
	},
	successGrafInd: function(x,y){
		var objRes = Ext.util.JSON.decode(Ext.util.Format.trim(x.responseText));
		console.log(objRes)
        var nomArch=objRes.nombre_archivo;
        alert(nomArch);
		
		
	}/*,
	east:{
			url: '../../../sis_mantenimiento/vista/localizacion_med/IndicadoresGrafRes.php',
			title: 'Ubicación',
			width: '50%' ,
			cls: 'IndicadoresGrafRes'
	}*/
})
</script>