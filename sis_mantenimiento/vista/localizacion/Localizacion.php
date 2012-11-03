<?php
/**
*@package pXP
*@file gen-Localizacion.php
*@author  (rac)
*@date 14-06-2012 03:46:45
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Localizacion=Ext.extend(Phx.arbInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Localizacion.superclass.constructor.call(this,config);
		this.init();
		
		this.tbar.items.get('b-new-'+this.idContenedor).disable()
		
		
		this.addButton('btnBlock', {
				text : 'Add Equipo',
				iconCls : 'block',
				disabled : true,
				handler : this.onBtnAddEquipo,
				tooltip : '<b>Add Equipo</b><br/>Adiciona equipo dede un aplantilla en la ubicacion de referencia'
			});
			
		this.addButton('btnCalGen', {
				text : 'Generar Calendario',
				iconCls : 'block',
				disabled : false,
				handler : this.onBtnCalGen,
				tooltip : '<b>Add Equipo</b><br/>GEnera el CAledario para todos los equipos de manera recursiva'
			});
		
		//add for to select  tipouni_cons
		
		this.formUC = new Ext.form.FormPanel({
        baseCls: 'x-plain',
        autoDestroy: true,
        labelWidth: 55,
        layout: {
            type: 'vbox',
            align: 'stretch'  // Child items are stretched to full width
        },
        defaults: {
            xtype: 'textfield'
        },

        items: [{
        	    xtype: 'combo',
				name: 'id_uni_cons',
				fieldLabel: 'Equipo',
				allowBlank: false,
				emptyText:'Elija un equipo...',
				store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/UniCons/listarUniConsPlano',
					id: 'id_uni_cons',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_uni_cons','codigo','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'tuc.nombre#tuc.codigo',tipo:'tuc'}
				}),
				valueField: 'id_uni_cons',
				displayField: 'nombre',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				width:210,
				gwidth:220,
				minChars:2
			},{
				xtype: 'textfield',
				name: 'codigo_uni_cons',
				fieldLabel: 'Código',
				allowBlank: false,				
			}]
    });
    
    
     var cmbUC =this.formUC.getForm().findField('id_uni_cons');
     cmbUC.store.on('exception',this.conexionFailure,this)
     var codigo =this.formUC.getForm().findField('codigo_uni_cons');
    
      cmbUC.on('select',function(c,a,d){ console.log(c,a,d);codigo.setValue(a.data.codigo)})
    
    
     this.wUC = new Ext.Window({
        title: 'Compose message',
        collapsible: true,
        maximizable: true,
         autoDestroy: true,
        width: 350,
        height: 200,
        layout: 'fit',
        plain: true,
        bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: this.formUC,
        modal:true,
         closeAction: 'hide',
        buttons: [{
            text: 'Guardar',
             handler:this.onAddUniCons,
            scope:this
            
        },{
            text: 'Cancelar',
            handler:function(){this.wUC.hide()},
            scope:this
        }]
    });
		
    //ventana para desplegar  calendario
    
    
    
    
    this.formUCCL = new Ext.form.FormPanel({
        //baseCls: 'x-plain',
        autoDestroy: true,
        labelWidth: 55,
        autoScroll: true,
        /*layout: {
            type: 'vbox',
            align: 'stretch'  // Child items are stretched to full width
        },*/
        defaults: {
            xtype: 'textfield'
        },

        items: [{
				xtype: 'datefield',
				name: 'fecha_ini',
				fieldLabel: 'Inicia',
				format:'d-m-Y',
				allowBlank: false,
				allowBlank: false				
			},{
				xtype: 'datefield',
				name: 'fecha_fin',
				fieldLabel: 'Termina',
				format:'d-m-Y',
				allowBlank: false,	
				allowBlank: false					
			}]
    });
    
    
     var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
     var dateFechaFin =this.formUCCL.getForm().findField('fecha_fin');
    
     this.wUCCL = new Ext.Window({
        title: 'Compose message',
        collapsible: true,
        maximizable: true,
         autoDestroy: true,
        width: 400,
        height: 350,
        layout: 'fit',
        //plain: true,
        //bodyStyle: 'padding:5px;',
        buttonAlign: 'center',
        items: this.formUCCL,
        modal:true,
        closeAction: 'hide',
        buttons: [{
            text: 'Guardar',
             handler:this.onCalGen,
            scope:this
            
        },{
            text: 'Cancelar',
            handler:function(){this.wUCCL.hide()},
            scope:this
        }]
    });
    
		
   //quita la opcion de dmover marcador al cerrar la ventana
    this.window.on('hide',function(){Phx.CP.getPagina(this.idContenedor+'-east').marker.setDraggable(false)},this);
    		
		

	},
	
	onCalGen:function(){
		 if (this.formUCCL.getForm().isValid()) {
		
			Phx.CP.loadingShow();
				
			var nodo = this.sm.getSelectedNode();
				
		
		    var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
		    var dateFechaFin =this.formUCCL.getForm().findField('fecha_fin');
		         
		       
		    var  id_nodo= nodo.attributes.leaf?nodo.attributes.id_uni_cons:nodo.attributes.id_localizacion
		      
		        
		       
		       
				 Ext.Ajax.request({
		                    form: this.form.getForm().getEl(),
		                    url: '../../sis_mantenimiento/control/UniCons/GenerarCalendario',
		                    params: {
		                    	tipo_nodo:nodo.attributes.tipo_nodo,
		                    	id_localizacion:id_nodo,
		                    	fecha_ini:dateFechaIni.getValue().dateFormat('d-m-Y'),
		                    	fecha_fin:dateFechaFin.getValue().dateFormat('d-m-Y')},
		                    success: this.successCalGen,
		                    failure:this.conexionFailure,
		                    timeout: this.timeout,
		                    scope: this
		               });
        }       
               
               
	},
	
	
	onAddUniCons:function(){
		
		if (this.formUCCL.getForm().isValid()) {
			 Phx.CP.loadingShow();
			
			 var nodo = this.sm.getSelectedNode();
			
			 var cmbUC =this.formUC.getForm().findField('id_uni_cons');
	         var codigo =this.formUC.getForm().findField('codigo_uni_cons');
	         
	       
			
			 Ext.Ajax.request({
	                    form: this.form.getForm().getEl(),
	                    url: '../../sis_mantenimiento/control/UniCons/addUniCons',
	                    params: {
	                    	id_uni_cons:cmbUC.getValue(),
	                    	codigo_uni_cons:codigo.getValue(),
	                    	id_localizacion:nodo.attributes.id_localizacion,
	                    	codigo_localizacion:nodo.attributes.codigo,
	                    	nombre:nodo.attributes.nombre},
	                    success: this.successAddUniCons,
	                    failure:this.conexionFailure,
	                    timeout: this.timeout,
	                    scope: this
	               });
          }     
               
               
	},
	
	successCalGen:function(resp){
		 Phx.CP.loadingHide();
         
         var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
         
         if(reg.ROOT.error){
			alert("ERROR no esperado")
		}
		else{
			this.wUCCL.hide();
		}

         
         
	},
	
	successAddUniCons:function(resp){
		
		 Phx.CP.loadingHide();
          var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
         
         if(reg.ROOT.error){
			alert("ERROR no esperado")
		}
		else{
			this.wUC.hide();
		}
		
	},
	onBtnAddEquipo:function(){
		var nodo = this.sm.getSelectedNode();
		if(nodo){
			this.wUC.show()
		}
	},
	
	onBtnCalGen:function(){
		var nodo = this.sm.getSelectedNode();
		if(nodo){
			this.wUCCL.show()
		}
	},
	
	winmodal:false,
		
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_localizacion'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_localizacion_fk',
				inputType:'hidden',
				labelSeparator:''
				
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'codigo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'loc.codigo',type:'string'},
			id_grupo:1,
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
			filters:{pfiltro:'loc.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:150
			},
			type:'TextField',
			filters:{pfiltro:'loc.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'ubicacion',
				fieldLabel: 'ubicacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'loc.ubicacion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'latitud',
				fieldLabel: 'LAtitud',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'loc.latitud',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'longitud',
				fieldLabel: 'Longitud',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'loc.longitud',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'coordenadas',
				fieldLabel: 'Zoom',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'NumberField',
			filters:{pfiltro:'loc.coordenadas',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'desc_ubicacion',
				fieldLabel: 'Descripcion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:2000
			},
			type:'TextArea',
			filters:{pfiltro:'loc.desc_ubicacion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'loc.fecha_reg',type:'date'},
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
			filters:{pfiltro:'loc.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Localizacion',
	ActSave:'../../sis_mantenimiento/control/Localizacion/insertarLocalizacion',
	ActDel:'../../sis_mantenimiento/control/Localizacion/eliminarLocalizacion',
	ActList:'../../sis_mantenimiento/control/Localizacion/listarLocalizacionArb',
	id_store:'id_localizacion',
	textRoot:'YPFB Logística',
	id_nodo:'id_localizacion',
	id_nodo_p:'id_localizacion_fk',
	
	onButtonNew:function(){
			var nodo = this.sm.getSelectedNode();			
			Phx.vista.Localizacion.superclass.onButtonNew.call(this);
			
		
			Phx.CP.getPagina(this.idContenedor+'-east').setMarkerDragableOn();
			
		//this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
	 },
	 
	 onButtonEdit:function(){
			var nodo = this.sm.getSelectedNode();			
			Phx.vista.Localizacion.superclass.onButtonEdit.call(this);
			
		
			Phx.CP.getPagina(this.idContenedor+'-east').setMarkerDragableOn();
			
		//this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
	 },
	 
	
	
	
	
	fields: [
	    'id',
	    'tipo_meta',
		{name:'id_localizacion', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'id_localizacion_fk', type: 'numeric'},
		{name:'ubicacion', type: 'string'},
		{name:'coordenadas', type: 'string'},
		{name:'desc_ubicacion', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	east:{
		  url:'../../../sis_mantenimiento/vista/localizacion/mapaLocalizacion.php',
		  title:'Ubicación', 
		  width:'50%',
		  cls:'mapaLocalizacion'
		 },
	
	sortInfo:{
		field: 'id_localizacion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	rootVisible:true,
	
	preparaMenu:function(n){
			//si es una nodo tipo carpeta habilitamos la opcion de nuevo
							
			if(n.attributes.tipo_nodo == 'hijo' || n.attributes.tipo_nodo == 'raiz' || n.attributes.id == 'id'){
					
					this.tbar.items.get('b-new-'+this.idContenedor).enable()
				}
				else {
					
					this.tbar.items.get('b-new-'+this.idContenedor).disable()
				}
			
			 if(n.attributes.tipo_nodo == 'hijo'){
			    this.getBoton('btnBlock').enable();
			 }
			 else{
			 	this.getBoton('btnBlock').disable();
			 	
			 }
			 
			
		
			// llamada funcion clace padre
			Phx.vista.Localizacion.superclass.preparaMenu.call(this,n)
			  if(n.attributes.tipo_nodo == 'uni_cons'){
			  	
			  	this.getBoton('btnBlock').disable();
			  	this.tbar.items.get('b-new-'+this.idContenedor).disable()
			  	this.tbar.items.get('b-edit-'+this.idContenedor).disable()
			  	this.tbar.items.get('b-del-'+this.idContenedor).disable()
			 	
			  }
			 
		},
		
		EnableSelect:function(n){
			if(n.attributes.tipo_nodo != 'uni_cons' ){	
				var nivel = n.getDepth();
		        var direc = this.getNombrePadre(n)
		        if(direc){				
				  Phx.CP.getPagina(this.idContenedor+'-east').ubicarPos(direc,nivel,n)
				}
			}
			else{
				var nivel = n.parentNode.getDepth();
		        var direc = this.getNombrePadre(n.parentNode)	
		        if(direc){		
				  Phx.CP.getPagina(this.idContenedor+'-east').ubicarPos(direc,nivel,n.parentNode)
				}
			}
			Phx.vista.Localizacion.superclass.EnableSelect.call(this,n)
	
	},
	
	getNombrePadre:function(n){
		var direc 
		
		
		var padre = n.parentNode;
		
		
		if(padre){
			if(padre.attributes.id!='id'){
			   direc = n.attributes.nombre +' - '+ this.getNombrePadre(padre)
			   return direc;
			}else{
				
				return n.attributes.nombre;
			}
		}
		else{
				return undefined;
		}

		
	 }
	
	
	
	
	
	}	
)
</script>
		
		