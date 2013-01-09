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
Phx.vista.IndicadoresMediciones=Ext.extend(Phx.baseInterfaz,{
	title:'indicadores-Interfaz',
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
		 this.panel.doLayout(true,true);
		 var mysize = this.panel.getSize()
		 if(this.grafPanel){
				this.grafPanel.setData(data,mysize);
		}
			
	},
	onReloadPage:function(){
				
				
				
			},
				
	
	constructor: function(config){
	
		Phx.vista.IndicadoresMediciones.superclass.constructor.call(this,config);
		
		
		
		this.grafPanel = new Ext.Panel({
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
					  
					// google.load('visualization', '1', {'packages':['motionchart'], "callback": retorno});
					 
			    //  if (window['google']){
						google.load("visualization", "1", {packages:["corechart",'annotatedtimeline'],"callback": retorno});                
						var domEl = this.body.dom;
					 	var mysize =this.size ;
					 	  
				 	  
					function retorno(){
					  	
					 						  	
					  	Ext.Panel.chart = new google.visualization.LineChart(domEl);
					  	//Ext.Panel.chart = new google.visualization.AnnotatedTimeLine(domEl);
					  
					  	
					    //Ext.Panel.chart = new google.visualization.MotionChart(domEl);
					    //Ext.Panel.chart.draw(data, {width: mysize.width, height:mysize.height});
					    
					  }
				
				//}
				
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
			         /*if (typeof this.getMap() == 'object') {
			           // this.gmap.checkResize();
			           
			           //this.gmap.event.trigger(map, 'resize')
			             //google.maps.event.trigger(this.gmap, 'resize');
			           
			        }*/
			        
			
			    }
		});
		
			
		this.regiones = new Array();
		//agrega el treePanel
		this.regiones.push(this.grafPanel);
		/*arma los panles de ventanas hijo*/
	    this.definirRegiones();
		
		this.panel.doLayout(true,true);
		var _char_panel = this.grafPanel.getEl();
		
		
		
		Phx.CP.getPagina(this.idContenedorPadre).onButtonGrafica();
		

   }
   

	
})
</script>
		
		