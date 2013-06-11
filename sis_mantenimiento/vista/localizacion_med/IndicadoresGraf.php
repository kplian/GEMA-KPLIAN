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
	
	setDatachart:function(data){
		 /*this.panel.doLayout(true,true);
		 var mysize = this.panel.getSize()
		 if(this.grafPanel){
				this.grafPanel.setData(data,mysize);
		}*/
			
	},
	onReloadPage:function(){
				
				
				
			},
				
	
	constructor: function(config){
	
		Phx.vista.IndicadoresGrafRes.superclass.constructor.call(this,config);
		
		var store = new Ext.data.JsonStore({
		    url: '../../sis_mantenimiento/control/LocalizacionMed/graficarIndicadores',
		    root: 'images',
		    method:'POST',
		    fields: [
		        'url'
		    ]
		});
		
		/*this.storeAtributos= new Ext.data.JsonStore({
          			url:'../../sis_mantenimiento/control/EquipoVariable/listarColumnasEquipoVariable',
				    id: 'id_equipo_variable',
   					root: 'datos',
   				    totalProperty: 'total',
   					fields: ['key','codigo_unidad_medida','id_unidad_medida','nombre_tipo_variable',
								{name:'id_equipo_variable', type: 'numeric'},
								{name:'valor_max', type: 'numeric'},
								{name:'id_uni_cons', type: 'numeric'},
								{name:'obs', type: 'string'},
								{name:'valor_min', type: 'numeric'},
								{name:'id_tipo_variable', type: 'numeric'}],
						sortInfo:{
							field: 'id_equipo_variable',
							direction: 'ASC'
						}});*/
		store.load({params:{
			start:0,
			limit:50,
			id_localizacion:1,
			num_dias: 27,
			fecha_ini: '01-01-2013',
			fecha_fin: '31-01-2013'
			}}
		);
		
		var tpl = new Ext.XTemplate(
		    '<tpl for=".">',
		        '<div class="thumb-wrap" id="{nombre}">',
		        '<div class="thumb"><img src="{url}" title="{nombre}"></div>',
		        '<span class="x-editable">{nombreCorto}</span></div>',
		    '</tpl>',
		    '<div class="x-clear"></div>'
		);
		
		var panel = new Ext.Panel({
		    id:'images-view'+this.idContenedor,
		    frame:true,
		    width:535,
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
		panel.render(document.body);

		
		
		
		
		
	
		/*this.grafPanel = new Ext.Panel({
			autoDestroy :true,
			//autoShow :true,
			 border: false, 
			 region:'center',
			 autoHeight :false,
			 layout:'fit',
			 size: this.panel.getSize(),
			 
			 constructor:function(config){
			 	
			 	
			 	
			 	Ext.Panel.superclass.constructor.call(this,config); 
			 	
			 	 
			 },
			 
			 setData:function(data,mysize){
			 	 this.doLayout(true,true)
			 	 this.data=data;
			 	
			 	
			 	if(Ext.Panel.chart){
			 	    Ext.Panel.chart.draw(data, {legend: 'none',pointSize: 5,width: mysize.width,height:mysize.height});
			 	}
			 	
			 },
			 
			 afterRender : function(x,y,z){
				 Ext.Panel.superclass.afterRender.call(this,x,y,z);  
					  

						google.load("visualization", "1", {packages:["corechart",'annotatedtimeline'],"callback": retorno});                
						var domEl = this.body.dom;
					 	var mysize =this.size ;
					 	  
				 	  
					function retorno(){
					  	
					 						  	
					  	Ext.Panel.chart = new google.visualization.LineChart(domEl);

					    
					  }
				

				
			},
			
			  onResize : function(w, h,v,x,k){

			              
			       this.doLayout(true,true)
			        if(Ext.Panel.chart){
					 	    Ext.Panel.chart.draw(this.data, {
					 	    	legend: 'none',
						        pointSize: 5,
					 		    width: w, 
					 		    height:h
					 		});
			 		}
			 		
			 		 Ext.Panel.superclass.onResize.call(this, w, h);

			        
			
			    }
		});*/
		
			
			/*
		this.regiones = new Array();
		//agrega el treePanel
		this.regiones.push(this.grafPanel);
		//arma los panles de ventanas hijo
	    this.definirRegiones();
		
		this.panel.doLayout(true,true);
		var _char_panel = this.grafPanel.getEl();
		*/
		
		
		
		//Phx.CP.getPagina(this.idContenedorPadre).onButtonGrafica();
		

   }
   

	
})
</script>
		
		