<?php
/**
*@package pXP
*@file gen-TipoEvento.php
*@author  (prueba1)
*@date 13-10-2011 11:22:31
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.mapaLocalizacion=Ext.extend(Phx.gmapInterfaz,{
	autoLoad :true,
	
		mostrarDatos:function(datos){
		
	   },
	    
	    Atributos:[
	    ],
		

	constructor:function(config){
		this.maestro=config.maestro;
		
		
		Phx.vista.mapaLocalizacion.superclass.constructor.call(this,config);
	
        
    	this.regiones = new Array();
		//agrega el treePanel
		this.regiones.push(this.gm);
		/*arma los panles de ventanas hijo*/
	    this.definirRegiones();
    	this.gm.expand(true);
        this.panel.doLayout(true,true)
        this.geocoder = new google.maps.Geocoder();
	
			
		
			  
			            
            
            

	},
	
	onReloadPage:function(dat){
		
		//this.ubicarPos('Rio Btanco - Acre - Brasil');
		
	},
	
	setMarkerDragableOn:function(){
		var myMapa = this.gm.getMap();
		
		this.marker.setDraggable(true);
		
		var ICP  = this.idContenedorPadre;
		
		google.maps.event.addListener(this.marker, 'dragend', function(event) {
		    var clat = Phx.CP.getPagina(ICP).getComponente('latitud');
		    var clog = Phx.CP.getPagina(ICP).getComponente('longitud');
		    var ccor = Phx.CP.getPagina(ICP).getComponente('coordenadas');
		    var LatLong = event.latLng.toUrlValue().split(',')
		    clat.setValue(LatLong[0]);
		    clog.setValue(LatLong[1]);
		    ccor.setValue(myMapa.getZoom());
		  },this);
	},
	
		
		
	ubicarPos:function(direc,zoom,n){
			var myMapa = this.gm.getMap()
			var address = direc;
			
			var lon = n.attributes.longitud;
		    var lat = n.attributes.latitud;
		    var coo =n.attributes.coordenadas;
		    var swFinder=true;
		    swFinder=(lon!='' && lat !='')?false:true;
		    
		    zoom=zoom>3?zoom*3:zoom*2;
		    zoom=(coo!='')?coo:zoom;
		    
		    
			
			
			if(!this.marker){
			this.marker = new google.maps.Marker({
			            map: myMapa 
			        });
			        
			}  
			var marker = this.marker      
			        
			if(swFinder){
			this.geocoder.geocode({ 'address': address}, function(results, status) {
			      if (status == google.maps.GeocoderStatus.OK) {
			        myMapa.setCenter(results[0].geometry.location);
			        myMapa.setZoom(zoom)
			        marker.setPosition(results[0].geometry.location)
			        
			      } else {
			        alert("No se pudo encontrar la direccion por este motivo: " + status);
			      }
			    });
			 }
			 else{
			 	var ll = new google.maps.LatLng(lat,lon)
			 	myMapa.setCenter(ll);
			 	myMapa.setZoom(zoom/1);
			    marker.setPosition(ll);
			    delete ll;
			 }
		
		
	},
	getMarker:function(){
		return this.marker 
		
	}
	
		
	
	})
</script>