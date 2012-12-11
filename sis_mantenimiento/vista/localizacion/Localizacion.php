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
		this.crearCtxMenu();
		
		this.tbar.items.get('b-new-'+this.idContenedor).disable()
		
		
		this.addButton('AddBlock', {
				text : 'Add Equipo',
				iconCls : 'bgear',
				disabled : true,
				handler : this.onBtnAddEquipo,
				tooltip : '<b>Add Equipo</b><br/>Adiciona equipo desde una plantilla en la ubicacion de referencia'
			});
		
		this.addButton('btnInCalGen', {
				text : 'Inc./Ret.',
				iconCls : 'blist',
				disabled : true,
				handler : this.onBtnIncluCalGen,
				tooltip : '<b>Considerar o no</b><br/>si la unidad es roja no se la considera en la generacion del calendario'
			});
		
			
	
			
		this.menuOp = new Ext.Toolbar.SplitButton({
   			id:'b-btnCalendar-' + this.idContenedor,
   			text: 'Calendario',
   			//handler: this.onMedicionesClick,
   			iconCls : 'bcalendar',
   			scope: this,
   			menu:{
   				items: [
   				{
   					id:'b-btnVerCalGen-' + this.idContenedor,
   					text: 'Ver el  Calendario', 
   					disabled : true,
   					tooltip : '<b>Ver el calendario</b><br/>Genera el Caledario para todos los equipos de manera recursiva',
   					 handler:this.onBtnVerCalGen, scope: this
   				},{
   					id:'b-btnCalGen-' + this.idContenedor,
   					text : 'Generar Calendario',
   					disabled : true,
   					handler: this.onBtnCalGen,
   					tooltip : '<b>Generar Calendario</b><br/>Genera el Caledario para todos los equipos de manera recursiva',
		            scope: this
   				}
   				]
   			}
   		});
   		
   		this.tbar.add(this.menuOp);	
			
	
		this.addButton('btnGenerarOT', {
				text : 'Generar OT',
				iconCls : 'block',
				disabled : false,
				handler : this.onBtnGenerarOT,
				tooltip : '<b>Generar Orden de Trabajo</b><br/>Genera las Ordenes de Trabajo correspondientes al nodo y sus hijos'
			});
			

		
		
		//add for to select  tipouni_cons
		
		this.formUC = new Ext.form.FormPanel({
        baseCls: 'x-plain-'+this.idContenedor,
        bodyStyle: 'padding:10 20px 10;',
		autoDestroy: true,
		border: false,
        layout: 'form',
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
				width:250,
		   		listWidth:'280',
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
    
      cmbUC.on('select',function(c,a,d){
      	
      	var nodo = this.sm.getSelectedNode();	
      	codigo.setValue(nodo.parentNode.attributes.codigo+'-'+nodo.attributes.codigo+'-'+a.data.codigo)  
      	
      },this);
    
    
     this.wUC = new Ext.Window({
        title: 'Compose message',
        collapsible: true,
        maximizable: true,
         autoDestroy: true,
        width: 450,
        height: 250,
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
       bodyStyle: 'padding:10 20px 10;',
		autoDestroy: true,
		border: false,
        layout: 'form',
        
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
    		
		
		
		this.baseParams={}

	},
	
	onBeforeLoad:function(treeLoader, node) {
		var tiponodo = node.attributes.tipo_nodo;
		treeLoader.baseParams.tipo_nodo = tiponodo;
		if(tiponodo=='uni_cons'|| tiponodo=='uni_cons_f'){
			treeLoader.baseParams.id_uni_cons = node.attributes.id_uni_cons;
		}
		Phx.vista.Localizacion.superclass.onBeforeLoad.call(this,treeLoader, node)
		
	},
	
	onBtnIncluCalGen:function(){
		var node = this.sm.getSelectedNode();
		var data =node.attributes;
		//el boton de bloqueo solo se habilita para
		//noso raiz del tipo TUC
		if(data && (data.tipo_nodo == 'rama' || data.tipo_nodo == 'uni_cons_f' || data.tipo_nodo == 'uni_cons')){
		    Phx.CP.loadingShow();
			
			var aux;
			
			if(data.incluir_calgen=="false"){
				aux=true;
			}
			else{
				
				aux=false;
			}
			
			
			
			Ext.Ajax.request({
				// form:this.form.getForm().getEl(),
				
				
				url:'../../sis_mantenimiento/control/UniCons/modificarInclucionGeneracionCalendarioUniCons',
				params:{'id_uni_cons':data.id_uni_cons,incluir_calgen:aux},
				success:this.successIncluCalGen,
				argument: {node:node.parentNode},
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
		}
	},
	
	successIncluCalGen:function(resp){
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if(!reg.ROOT.error){
				//alert(reg.ROOT.detalle.mensaje)
				
			}else{
				
				alert('ocurrio un error durante el proceso')
			}
			resp.argument.node.reload();
			
		},
	
	
	onCalGen:function(){
		var nodo = this.sm.getSelectedNode();
		 if (this.formUCCL.getForm().isValid()) {
		
			Phx.CP.loadingShow();
				
		    var tiponodo = nodo.attributes.tipo_nodo;
		    var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
		    var dateFechaFin =this.formUCCL.getForm().findField('fecha_fin');
		         
		    if(tiponodo == 'uni_cons_f' ||tiponodo == 'uni_cons' || tiponodo == 'rama'){
		    	var  id_nodo= nodo.attributes.id_uni_cons;
		    }
		    else{
		    	id_nodo= nodo.attributes.id_localizacion;
		    	
		    }
		    var parametros = {
	                    	tipo_nodo:nodo.attributes.tipo_nodo,
	                    	id_localizacion:id_nodo,
	                    	id_uni_cons:nodo.attributes.id_uni_cons,
	                    	fecha_ini:dateFechaIni.getValue().dateFormat('d-m-Y'),
	                    	fecha_fin:dateFechaFin.getValue().dateFormat('d-m-Y')};
		      
	 	 Ext.Ajax.request({
	                    url: '../../sis_mantenimiento/control/UniCons/GenerarCalendario',
	                    params: parametros,
	                    success: this.successCalGen,
	                    argument:parametros,
	                    failure:this.conexionFailure,
	                    timeout: this.timeout,
	                    scope: this
	               });
        }       
               
               
	},
	onCalGenConfirmado:function(parametros){
		Phx.CP.loadingShow();
	 	 Ext.Ajax.request({
	                    url: '../../sis_mantenimiento/control/UniCons/GenerarCalendarioConfirmado',
	                    params: parametros,
	                    success: this.successCalGen,
	                     failure:this.conexionFailure,
	                    timeout: this.timeout,
	                    scope: this
	               });
        },
        onAddUniCons:function(){
		
		if (this.formUC.getForm().isValid()) {
			 Phx.CP.loadingShow();
			
			 var nodo = this.sm.getSelectedNode();
			
			 var cmbUC =this.formUC.getForm().findField('id_uni_cons');
	         var codigo =this.formUC.getForm().findField('codigo_uni_cons');
	         var codigo_loc=nodo.parentNode.attributes.codigo+'-'+nodo.attributes.codigo
			
			 Ext.Ajax.request({
	                    url: '../../sis_mantenimiento/control/UniCons/addUniCons',
	                    params: {
	                    	id_uni_cons:cmbUC.getValue(),
	                    	codigo_uni_cons:codigo.getValue(),
	                    	id_localizacion:nodo.attributes.id_localizacion,
	                    	codigo_localizacion:codigo_loc,
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
			if(reg.ROOT.datos.generado=='true'){
				alert("Se incluyeron "+reg.ROOT.datos.contador+" equipos o partes");
			}
			else{
				
				if (confirm('La siguientes unidades se perderan: \n'+reg.ROOT.datos.unidades+'\n Desea continuar y sobreescribir esta planificación')){
					
				
					this.onCalGenConfirmado(resp.argument)
				
			        }
			    }
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
			var nodo = this.sm.getSelectedNode();
			nodo.reload();
		}
		
	},
	onBtnAddEquipo:function(){
		var nodo = this.sm.getSelectedNode();
		
		
		this.formUC.form.reset()
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
	
	onBtnVerCalGen:function(){
		var nodo = this.sm.getSelectedNode();
		if(nodo){
		    Phx.CP.loadWindows('../../../sis_mantenimiento/vista/localizacion/gridCalendario.php',
					'Calendario de Planificacion',
					{
						width:800,
						height:400
				    },nodo.attributes,this.idContenedor,'gridCalendario')
	
	   }
	},
	
	onBtnGenerarOT:function(){
		var nodo = this.sm.getSelectedNode();
           Phx.CP.loadWindows('../../../sis_mantenimiento/vista/orden_trabajo/GenerarOrdenTrabajo.php',
					'Generar Ordenes de Trabajo',
					{
						width:800,
						height:400
				    },nodo.attributes,this.idContenedor,'GenerarOdenTrabajo')
	
	
	},
	onBtnUsuario: function(){
		var node=this.sm.getSelectedNode();
		var data =node.attributes;
		if(data){
			Phx.CP.loadWindows('../../../sis_mantenimiento/vista/localizacion_usuario/LocalizacionUsuario.php',
				'Usuarios por Localización',{
						modal:true,
						width:900,
						height:400
				    },
				    data,this.idContenedor,'LocalizacionUsuario')
			}
   },
   onBtnMed: function(){
		var node=this.sm.getSelectedNode();
		var data =node.attributes;
		Phx.CP.log(node);
		if(data){
			Phx.CP.loadWindows('../../../sis_mantenimiento/vista/localizacion_med/LocalizacionMed.php',
				'Mediciones: '+node.text,{
						modal:true,
						width:900,
						height:400
				    },
				    data,this.idContenedor,'LocalizacionMed')
			}
   },
   
   onBtnTPMPorquePorque : function(){
        var rec = this.sm.getSelectedNode();
        var data = rec.attributes;
        if(data){
            Phx.CP.loadWindows('../../../sis_mantenimiento/vista/analisis_porque/AnalisisPorque.php',
                    'Analisis Porque',
                    {
                        modal:true,
                        width:900,
                        height:600
                    },
                    data,this.idContenedor,'AnalisisPorque')
        }
   },
   
   onBtnTarjetasTPM : function(){
       var rec = this.sm.getSelectedNode();
       var data = rec.attributes;
       if(data){
           Phx.CP.loadWindows('../../../sis_mantenimiento/vista/tpm_tarjeta/TpmTarjeta.php',
                    'Control de Tarjetas TPM',
                    {
                        modal:true,
                        width:900,
                        height:600
                    },
                    data, this.idContenedor,'TpmTarjeta')
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
	 onButtonDel:function(){
			var nodo = this.sm.getSelectedNode();	
			console.log(nodo)
			if(nodo.attributes.tipo_nodo=='uni_cons'||nodo.attributes.tipo_nodo=='uni_cons_f'){
				nodo.attributes.tipo_meta = nodo.attributes.tipo_nodo;
				nodo.attributes.id_localizacion = nodo.attributes.id_uni_cons;
				//Phx.CP.log('fas',nodo)
				console.log(nodo)	
			}
			Phx.vista.Localizacion.superclass.onButtonDel.call(this);
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
	
	liberaMenu:function(n){
		
		Phx.vista.Localizacion.superclass.liberaMenu.call(this,n);
		this.menuOp.menu.items.get('b-btnVerCalGen-' + this.idContenedor).disable();
		this.menuOp.menu.items.get('b-btnCalGen-' + this.idContenedor).enable();
		this.getBoton('btnInCalGen').disable();
		this.getBoton('AddBlock').disable();
		this.menuOp.disable();
		
	},
	
	preparaMenu:function(n){
			//si es una nodo tipo carpeta habilitamos la opcion de nuevo
				
			var tiponodo = n.attributes.tipo_nodo;	
							
			if(tiponodo == 'hijo' || tiponodo == 'raiz' || n.attributes.id == 'id'){
					this.tbar.items.get('b-new-'+this.idContenedor).enable()
				}
				else {
					this.tbar.items.get('b-new-'+this.idContenedor).disable()
				}
			
			 if(tiponodo != 'id'){
			 	this.menuOp.enable();
			    this.menuOp.menu.items.get('b-btnVerCalGen-' + this.idContenedor).enable();
			    this.menuOp.menu.items.get('b-btnCalGen-' + this.idContenedor).enable();
			 }
			 else{
			 	this.menuOp.disable();
			 	this.menuOp.menu.items.get('b-btnVerCalGen-' + this.idContenedor).disable();
			 	this.menuOp.menu.items.get('b-btnCalGen-' + this.idContenedor).enable();
			 }
			 	
				
				
			
			 if(tiponodo == 'hijo'){
			    this.getBoton('AddBlock').enable();
			 }
			 else{
			 	this.getBoton('AddBlock').disable();
			 	
			 }
			 
			
		
			// llamada funcion clace padre
			Phx.vista.Localizacion.superclass.preparaMenu.call(this,n)
			  if(tiponodo == 'uni_cons_f' || tiponodo == 'uni_cons' || tiponodo=='rama'){
			  	
			  	this.getBoton('AddBlock').disable();
			  	
			  	this.tbar.items.get('b-new-'+this.idContenedor).disable()
			  	this.tbar.items.get('b-edit-'+this.idContenedor).disable()
			  	//this.tbar.items.get('b-del-'+this.idContenedor).disable()
			 	
			  }
			  
			
			  if(tiponodo == 'uni_cons' || tiponodo == 'uni_cons_f' || tiponodo=='rama'){
			  	this.getBoton('btnInCalGen').enable();
			  }
			  else
			  {
			  	this.getBoton('btnInCalGen').disable();
			  }
			 
		},
		
		EnableSelect:function(n){
			
			var tiponodo = n.attributes.tipo_nodo;
			if(tiponodo != 'uni_cons_f' && tiponodo != 'uni_cons' && tiponodo !='rama'){	
				var nivel = n.getDepth();
		        var direc = this.getNombrePadre(n)
		        if(direc){
		          if(Phx.CP.getPagina(this.idContenedor+'-east')){				
				     Phx.CP.getPagina(this.idContenedor+'-east').ubicarPos(direc,nivel,n)
				  }
				  else
				  {
				  	 alert("No hay acceso a internet")
				  	
				  }
				}
			}
			else {
				
				var nodo_aux;	
				if(tiponodo != 'uni_cons' && tiponodo != 'uni_cons_f' &&tiponodo == 'rama'){
					nodo_aux=n.parentNode.parentNode
				}
				else{
					 nodo_aux=n.parentNode
				}
				var nivel = nodo_aux.getDepth();
		        var direc = this.getNombrePadre(nodo_aux)	
				
		        
		        if(direc){	
		        	
		        	if(Phx.CP.getPagina(this.idContenedor+'-east')){	
				       Phx.CP.getPagina(this.idContenedor+'-east').ubicarPos(direc,nivel,nodo_aux)
				    }
				    else{
				    	
				    	alert("No hay acceso a internet")
				    }
				
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

		
	 },
	 onEqMantClick: function(){					
		var node=this.sm.getSelectedNode();
		var data =node.attributes;
		if(data){
			Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_mant_predef/UniConsMantPredef.php',
				'Mantenimientos predefinidos [Equipo: '+data.codigo+'-'+data.nombre+']',{
						modal:true,
						width:900,
						height:400
				    },
				    data,this.idContenedor,'UniConsMantPredef')
				    
			}
	},
	crearCtxMenu: function(){
		//Grupo de opciones a nivel de localizaciones
		this.ctxMenu.add('-');
		this.ctxMenu.addMenuItem({text:'Usuarios por Localización',handler:this.onBtnUsuario,scope:this});
		this.ctxMenu.addMenuItem({text:'Registro de Mediciones',handler:this.onBtnMed,scope:this});
		this.ctxMenu.addMenuItem({text:'Tarjetas TPM',handler:this.onBtnTarjetasTPM,scope:this});
		//Grupo de opciones para Equipos
		this.ctxMenu.add('-');
		this.ctxMenu.addMenuItem({text:'Agregar Equipo',handler:this.onBtnAddEquipo,scope:this});
		this.ctxMenu.addMenuItem({
			text:'Equipos',
			menu:{
				items:[
					{text:'Ficha Técnica',handler:this.onClickDatosEq,scope:this},
					{text:'Mantenimientos predefinidos',handler: this.onEqMantClick,scope:this},
					{text:'Mediciones',handler: this.onClickMed,scope:this},
					{text:'Upload archivos',handler: this.onClickUp,scope:this},
					{
						text:'TPM',
						menu:{
						items:[
							{text:'Análisis Porqué-Porqué',handler:this.onBtnTPMPorquePorque,scope:this}
						]}
					},
					{
						text:'RCM',
						menu:{
						items:[
							{text:'Análisis',handler:this.onBtnRCMAnalisis,scope:this},
							{text:'Planificación',handler:this.onClickRCMAnalisis,scope:this}
						]}
					}
				]}
			}
		);
		
		//Grupo de opciones para el Calendario
		this.ctxMenu.add('-');	
		this.ctxMenu.addMenuItem({
			text:'Planificación del Mantenimiento',
			menu:{
				items:[
					{text:'Ver Calendario',handler:this.onBtnVerCalGen,scope:this},
					{text:'Generar Calendario',handler: this.onBtnCalGen,scope:this}
				]}
			}
		)
			
		this.ctxMenu.addMenuItem({text:'Indicadores'});
	},
	onBtnTarjetaTPM: function(){
		
	},
	onClickMed: function(){
		
	},
	onClickUp: function(){
		
	},
	onClickRCMAnalisis: function(){
		
	}
	
	
	
	}	
)
</script>
		
		