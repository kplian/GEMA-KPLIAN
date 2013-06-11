<?php
/**
*@package pXP
*@file gen-Metodologia.php
*@author  (admin)
*@date 17-08-2012 15:52:47
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.IndicadoresGrafRes=Ext.extend(Phx.baseInterfaz,{
	title:'Gráfico Indicadores',
    bsave:false,
	bnew:false,
	bedit:false,
	bdel:false,
	bact:true,
    bexcel:false,
    //Funcion nuevo del toolbar
	onButtonNew:function(){
	},
	//Funcion editar del toolbar
	onButtonEdit:function(){
	},
	
	
	//Funcion eliminar del toolbar
	onButtonDel:function(){ 
	},
	
	//Funcion actualizar del toolbar
	onButtonAct:function(){
	},

	onReloadPage:function(){
	},
				
	
	constructor: function(config){
	
		Phx.vista.IndicadoresGrafRes.superclass.constructor.call(this,config);
		
		var store = new Ext.data.JsonStore({
		    url: '../../sis_mantenimiento/control/LocalizacionMed/graficarIndicadores',
		    root: 'images',
		    method:'POST',
		    fields: ['url','nombre','nombre_corto']
		});
		
		store.load({params:{
			start:0,
			limit:50,
			id_localizacion:1,
			num_dias: 27,
			fecha_ini: '01-01-2013',
			fecha_fin: '31-01-2013'
			}}
		);
		
		store.on('load',this.onReadyLoad);
		store.on('loadexception',this.conexionFailure);
		
		var tpl = new Ext.XTemplate(
		    '<tpl for=".">',
		        '<div class="thumb-wrap" id="{nombre}">',
		        '<div class="thumb"><img src="{url}" title="{nombre}"></div>',
		        '<span class="x-editable">{nombre_corto}</span></div>',
		    '</tpl>',
		    '<div class="x-clear"></div>'
		);
		
		var panel = new Ext.Panel({
		    id:'images-view'+this.idContenedor,
		    frame:true,
		    region: 'center',
		    autoHeight:true,
		    collapsible:true,
		    layout:'fit',
		    title:'Gráfico Indicadores',
		    items: new Ext.DataView({
		        store: store,
		        tpl: tpl,
		        autoHeight:true,
		        multiSelect: true,
		        overClass:'x-view-over',
		        itemSelector:'div.thumb-wrap',
		        emptyText: 'No hay imágenes para desplegar'
		    })
		});
		
		this.regiones = new Array();
		//agrega el treePanel
		this.regiones.push(panel);
		/*arma los panles de ventanas hijo*/
	    this.definirRegiones();
		
		panel.expand(true);
		panel.doLayout(true,true);
		
		
		//var _char_panel = panel.getEl();
		
		//panel.render(document.body);

  },
  onReadyLoad: function(a,b,c){
  	alert('cargado con éxito');
  	console.log('dddddd',a,b);
  }
   
})
</script>
		
		