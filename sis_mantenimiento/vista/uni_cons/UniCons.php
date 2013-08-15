<?php
/**
*@package pXP
*@file gen-UniCons.php
*@author  (rac)
*@date 09-08-2012 00:42:57
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UniCons=Ext.extend(Phx.arbInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	
    	
    	//llama al constructor de la clase padre
    	this.initButtons=[this.cmbTipo];
    	Phx.vista.UniCons.superclass.constructor.call(this,config);
    	
			
		//coloca elementos en la barra de herramientas
    	//this.tbar.add();
    	//this.tbar.add('<-',this.cmbTipo);
    	
    	//
		this.addButton('btnBlock', {
				text : '',
				iconCls : 'block',
				disabled : true,
				handler : this.onBtnBlock,
				tooltip : '<b>Bloquear</b><br/>Bloquea la edición del equipo'
			});
			
			
		//para definir atributos del equipo	
		this.addButton('btnAtrib', {
				text : '',
				iconCls : 'bchecklist',
				disabled : false,
				handler : this.onBtnAtribPlan,
				tooltip : '<b>Variables de Medición</b><br/>Define las variables del equipo'
		});
		
		/*this.addButton('btn_MedicionGraf',{
			text:'Mediciones/Indicadores',
			iconCls: 'blist',
			disabled: false,
			handler:this.btn_MedicionGraf,
			tooltip: '<b>Mediciones/Indicadores</b><br/>Detalle de las mediciones / Indicadores'
			}
		);*/		
        this.addButton('btnUpload',{
           text :'',
           iconCls : 'bupload',
           disabled : true,
           handler : this.onButtonUpload,
           tooltip : '<b>Archivos</b><br/>Archivos del Equipo'
        });
        
        this.addButton('btnItems',{
            text : '',
            iconCls : 'bengine',
            disabled : true,
            handler : this.onButtonItems,
            tooltip : '<b>Repuestos/Proveedores</b><br/>Registro de Repuestos y Proveedores del Equipo'
        });
        
        /*this.addButton('btnProveedores',{
            text : '',
            iconCls : 'bassign',
            disabled : true,
            handler : this.onButtonProv,
            tooltip : '<b>Proveedores</b><br/>Registro de proveedores del equipo'
        });*/
		
		//Incluye un menú
   		this.menuOp = new Ext.Toolbar.SplitButton({
   			text: '',
   			handler: this.onMedicionesClick,
   			iconCls: 'bgear',
   			scope: this,
   			tooltip : '<b>Mantenimientos</b><br/>',
   			menu:{
   				items: [
   				{
   					text: 'Análisis de Mantenimiento', handler: this.onAnalisisClick, scope: this
   				},{
   					text: 'Plan de Mantenimiento', handler: this.onPlanClick, scope: this
   				}
   				]
   			}
   		});
   		
   		//this.tbar.add(this.menuOp);
    
		this.addButton('btnDocTecnica', {
				text : '',
				iconCls : 'bdocuments',
				disabled : false,
				handler : this.onBtnDocTecnica,
				tooltip : '<b>Documentación Técnica</b><br/>Define la documentación técnica.'
		});
		
		this.addButton('btnAddPlantilla', {
				text : '',
				iconCls : 'bengineadd',
				disabled : false,
				handler : this.onBtnAddPlantilla,
				tooltip : '<b>Agregar Plantilla</b><br/>Permite agregar una plantilla ya existente.'
		});
    	
    	// initButtons:[this.cmbTipo],
		/*this.tbar.add('->');
   		this.tbar.add(' Filtrar:');
   		this.tbar.add(this.datoFiltro);
   		*/
   		
   		
   		this.loaderTree.baseParams={tipo:'tuc'};
		this.init();
		this.cmbTipo.setValue('Plantillas');
		//inicia los eventos del formulario
		this.iniciarEventos();
		
		this.ocultarComponente(this.getComponente('id_tipo_equipo'));
		
		
		this.rootVisible=false;
		
        this.tbar.items.get('b-new-' + this.idContenedor).disable();
		this.getBoton('btnAtrib').disable();
		
		//Creación de ventana para adición de plantillas
		this.createWindowAddPlantilla()
	},
	expanded:false,

	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons'
			},
			type:'Field',
			form:true 
		},{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons_padre'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				labelSeparator:'',
				inputType:'hidden',
				name: 'tipo'
				
			},
			type:'Field',
			form:true
		},{
	       			config:{
	       				 typeAhead: false,
	       				  hideTrigger:true,
	       				  forceSelection:false,
	       				  name:'id_tipo_equipo',
	       				  fieldLabel:'Tipo de Equipo',
	       				  allowBlank:false,
	       				  emptyText:'Tipos...',
	       				  store: new Ext.data.JsonStore({

	    					url: '../../sis_mantenimiento/control/TipoEquipo/listarTipoEquipo',
	    					id: 'id_tipo_equipo',
	    					root: 'datos',
	    					sortInfo:{
	    						field: 'codigo',
	    						direction: 'ASC'
	    					},
	    					totalProperty: 'total',
	    					fields: ['id_tipo_equipo','codigo','nombre','descripcion'],
	    					// turn on remote sorting
	    					remoteSort: true,
	    					baseParams:{par_filtro:'codigo#nombre#descripcion'}
	    				}),
	    				rawValueField:'nombre_tipo_equipo',//campo adicional utilizado para utilizar el combo como insercion
	    				hiddenName: 'id_tipo_equipo',
	    			    valueField: 'id_tipo_equipo',
	       				displayField: 'nombre',
	       				gdisplayField: 'nombre_tipo_equipo',
	       				//typeAhead: true,
	           			triggerAction: 'all',
	           			lazyRender:true,
	       				mode:'remote',
	       				pageSize:10,
	       				queryDelay:200,
	       				anchor:'100%',
	       				minChars:2,
		       			tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p><p>{codigo}</p> </div></tpl>'
		   			},
	       			type:'ComboBox',
	       			id_grupo:1,
	       			filters:{   pfiltro:'descripcion#codigo#nombre',
	       						type:'string'
	       					},
	       			grid:true,
	       			form:true
	       	},
		
		/*{
			config:{
				name: 'id_localizacion',
				fieldLabel: 'id_localizacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'tuc.id_localizacion',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},*/
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'tuc.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:140
			},
			type:'TextField',
			filters:{pfiltro:'tuc.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'funcion',
				fieldLabel: 'Funcion',
				allowBlank: true,
				width: '100%',
				gwidth: 250,
				maxLength: 200
			},
			type: 'TextArea',
			filters:{pfiltro: 'geoott.funcion',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'punto_recepcion_despacho',
				fieldLabel: 'Pto. Recepcion/ Despacho',
				allowBlank: true,
				width: '100%',
				gwidth: 250,
				maxLength: 100
			},
			type: 'TextArea',
			filters:{pfiltro: 'geoott.punto_recepcion_despacho',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'herramientas_especiales',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				width: '100%',
				gwidth: 250,
				maxLength: 1000
			},
			type: 'TextArea',
			filters:{pfiltro: 'geoott.descripcion_lugar',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'otros_datos_tec',
				fieldLabel: 'Otros Datos Técnicos',
				allowBlank: true,
				width: '100%',
				gwidth: 250,
				maxLength: 1000
			},
			type: 'TextArea',
			filters:{pfiltro: 'geoott.descripcion_lugar',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'ficha_tecnica',
				fieldLabel: 'Ficha Técnica?',
				anchor: '50%',
				tinit: false,
				allowBlank: true,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__bandera'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['ficha_tecnica']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'ficha_tecnica',type:'string'},
			grid: true,
			form: true
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
			filters:{pfiltro:'tuc.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		/*{
			config:{
				name: 'estado',
				fieldLabel: 'estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:20
			},
			type:'TextField',
			filters:{pfiltro:'tuc.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},*/
		
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
				//gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'tuc.fecha_reg',type:'date'},
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
				//gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'tuc.fecha_mod',type:'date'},
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
		}
	],
	//colocan e combo al inicio de la barra de herramientas
   
	title:'Equipos',
	ActSave:'../../sis_mantenimiento/control/UniCons/insertarUniCons',
	ActDel:'../../sis_mantenimiento/control/UniCons/eliminarUniCons',
	ActList:'../../sis_mantenimiento/control/UniCons/listarUniCons',
	datoFiltro:new Ext.form.Field({ 
		                        allowBlank:true,
					       		width: 200}),
					       		
	cmbTipo:new Ext.form.ComboBox({
	        store:['Plantillas','Equipos'],
	        typeAhead: true,
	        mode: 'local',
	        triggerAction: 'all',
	        emptyText:'Tipo..',
	        selectOnFocus:true,
	        width:100
	    }),
	enableDD:false,
		expanded:false,
		fheight:'80%',
		fwidth:'50%',
		textRoot:'Estructura Organizacional',
		id_nodo:'id_uni_cons',
		id_nodo_p:'id_uni_cons_padre',
	
	fields: ['id',//identificador unico del nodo (concatena identificador de tabla con el tipo de nodo)
		      //porque en distintas tablas pueden exitir idetificadores iguales
		      'tipo_nodo',
		{name:'id_uni_cons', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'id_tipo_equipo', type: 'numeric'},
		{name:'id_localizacion', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'herramientas_especiales', type: 'string'},
		{name:'otros_datos_tec', type: 'string'},
		{name:'funcion', type: 'string'},
		{name:'punto_recepcion_despacho', type: 'string'}
	],
	sortInfo:{
		field: 'id_uni_cons',
		direction: 'ASC'
	},
	bdel:true,
	
	onButtonNew:function(){
			var nodo = this.sm.getSelectedNode();			
			Phx.vista.UniCons.superclass.onButtonNew.call(this);
			//if(nodo.)
			
						
			
			//this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
	 },
	 
	 
    onButtonAct: function(){
        Phx.vista.UniCons.superclass.onButtonAct.call(this);
        this.tbar.items.get('b-new-' + this.idContenedor).disable();
    },
	 
	loadValoresIniciales:function(){
		var tipo = (this.cmbTipo.getValue()=='Plantillas')?'tuc':'uc';
		Phx.vista.UniCons.superclass.loadValoresIniciales.call(this);
		this.getComponente('tipo').setValue(tipo);
		
	},
	
	iniciarEventos:function(){
		
		this.cmbTipo.on('beforeselect',function(combo,record,index){
		var cmbtipo;
		cmbtipo = record.data.field1;
		this.loaderTree.baseParams.tipo=(cmbtipo=='Plantillas')?'tuc':'uc';	
		this.onButtonAct();
		
		},this);
		
		
		
		
	},
	
	preparaMenu:function(n){
	    Phx.vista.UniCons.superclass.preparaMenu.call(this,n);
	    this.tbar.items.get('b-new-' + this.idContenedor).enable();
		var tiponodo = n.attributes.tipo_nodo;
			//si es una nodo tipo carpeta habilitamos la opcion de nuevo	
			if((tiponodo == 'raiz_borrador' || tiponodo == 'raiz_aprobado' )&& n.attributes.id != 'id'){
			    this.getBoton('btnBlock').enable();	
                if(tiponodo == 'raiz_aprobado'){
					this.getBoton('btnBlock').setIconClass('bunlock'); 
		            this.getBoton('btnBlock').setTooltip('<p>Desbloquear permite editar</p>');
		            this.getBoton('btnUpload').enable();
                    this.getBoton('btnItems').enable();
                    //this.getBoton('btnProveedores').enable();
                    this.getBoton('btnAtrib').enable();
                    this.tbar.items.get('b-new-' + this.idContenedor).disable();
                    this.tbar.items.get('b-edit-' + this.idContenedor).disable();
                    this.tbar.items.get('b-del-' + this.idContenedor).disable(); 
		        }
				else{
					this.getBoton('btnBlock').setIconClass('block'); 
		            this.getBoton('btnBlock').setTooltip('<p>Bloquea la edición del equipo</p>');
		            this.getBoton('btnUpload').enable();
                    this.getBoton('btnItems').enable();
                    //this.getBoton('btnProveedores').enable();
                    this.getBoton('btnAtrib').enable();                     
				}			
				
			}
			else {
			    if(tiponodo=='base'){
    				this.getBoton('btnBlock').disable();
                    this.getBoton('btnUpload').disable();
                    this.getBoton('btnItems').disable();
                    //this.getBoton('btnProveedores').disable();
                    this.getBoton('btnAtrib').disable();
                }
                else{
                    this.tbar.items.get('b-new-' + this.idContenedor).disable();
                    this.getBoton('btnBlock').disable();
                    this.getBoton('btnUpload').enable();
                    this.getBoton('btnItems').enable();
                    //this.getBoton('btnProveedores').enable();
                    this.getBoton('btnAtrib').enable();
                }                
			}
			// llamada funcion clace padre
			
			
		},
	
	onButtonNew:function(){
		var node = this.sm.getSelectedNode();
		var tiponodo =  node?node.attributes.tipo_nodo:'newnodo';
		    if(tiponodo == 'base' || tiponodo == 'raiz_borrador' || tiponodo == 'raiz_aprobado'){
				this.mostrarComponente(this.getComponente('id_tipo_equipo'))
			}else{
				this.ocultarComponente(this.getComponente('id_tipo_equipo'))
			}
		Phx.vista.UniCons.superclass.onButtonNew.call(this)
	},
	onButtonEdit:function(){
		var node = this.sm.getSelectedNode()
		var tiponodo = node.attributes.tipo_nodo;
		   if(tiponodo == 'raiz_borrador' || tiponodo == 'raiz_aprobado'|| tiponodo=='rama'){
				this.mostrarComponente(this.getComponente('id_tipo_equipo'))
			}else{
				this.ocultarComponente(this.getComponente('id_tipo_equipo'))
			}
		Phx.vista.UniCons.superclass.onButtonEdit.call(this);
	},
	
	onBtnBlock:function(){
		var node = this.sm.getSelectedNode();
		var data =node.attributes;
		//el boton de bloqueo solo se habilita para
		//noso raiz del tipo TUC
		if(data && (data.tipo_nodo == 'raiz_borrador' || data.tipo_nodo =='raiz_aprobado')){
		    Phx.CP.loadingShow();
			var est = (data.estado == 'borrador')?'aprobado':'borrador';
			Ext.Ajax.request({
				// form:this.form.getForm().getEl(),
				url:'../../sis_mantenimiento/control/UniCons/setBlockUnblockUniCons',
				params:{'id_uni_cons':data.id_uni_cons,estado:est},
				success:this.successBU,
				argument: {node:node.parentNode},
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
		}
	},
	

	onBtnAtribPlan:function(){
		var nodo = this.sm.getSelectedNode();
           Phx.CP.loadWindows('../../../sis_mantenimiento/vista/equipo_variable/EquipoVariable.php',
					'Variables de Medición',
					{
						width:800,
						height:400
				    },nodo.attributes,this.idContenedor,'EquipoVariable')
		
		
	},
    
    onButtonUpload: function(){
       var rec = this.sm.getSelectedNode();
       var data = rec.attributes;
       if(data){
           Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_archivo/UniConsArchivo.php',
                               'Archivos de Unidades Constructoras',
                               {
                                   modal:true,
                                   width:900,
                                   height:500
                               },
                               data,this.idContenedor,'UniConsArchivo');
           
       }  
    },
    onButtonItems: function(){
      var rec = this.sm.getSelectedNode();
      var data = rec.attributes;
      if(data){
          Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_item/UniConsItem.php',
          'Registro de items por equipo',{
              modal:true,
              width:900,
              height:400
          },
          data,this.idContenedor,'UniConsItem');
      }  
    },
    
    onButtonProv : function(){
       var rec = this.sm.getSelectedNode();
       var data = rec.attributes;
       if(data){
           Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_proveedor/UniConsProveedor.php',
           'Registro de proveedores por equipo',{
               modal:true,
               width:900,
               height:400
           },
           data,this.idContenedor,'UniConsProveedor')
       }    
    },
    

	onMedicionesClick: function(){					
		var node=this.sm.getSelectedNode();
		var data =node.attributes;
		if(data){
			Phx.CP.loadWindows('../../../sis_mantenimiento/vista/equipo_medicion/EquipoMedicionDinamico.php',
				'EquipoMedicion',{
						modal:true,
						width:900,
						height:400
				    },
				    data,this.idContenedor,'EquipoMedicionDinamico')
				    
			}
	},
	onAnalisisClick: function(){
				var node=this.sm.getSelectedNode();
		        var data =node.attributes;
		        if(data){
					Phx.CP.loadWindows('../../../sis_mantenimiento/vista/analisis_mant/AnalisisMant.php',
					'Análisis de Mantenimiento (RCM)',{
						modal:true,
						width:900,
						height:600
					},
					data,this.idContenedor,'AnalisisMant')
				}
	},

	onPlanClick: function(){
        
        var rec=this.sm.getSelectedNode();
            var data = rec.attributes;
            if(data){
            Phx.CP.loadWindows('../../../sis_mantenimiento/vista/plan_mant/PlanMant.php',
                    'Plan de Mantenimiento',
                    {
                        modal:true,
                        width:900,
                        height:600
                    },
                    data,this.idContenedor,'PlanMant')
            }
    },
    onBtnDocTecnica: function() {
    	var rec=this.sm.getSelectedNode();
        var data = rec.attributes;
        if(data) {
        	Phx.CP.loadWindows('../../../sis_mantenimiento/vista/uni_cons_doc_tec/UniConsDocumentoTec.php',
                'Documentacion Técnica',
                {
                    modal:true,
                    width:700,
                    height:500
                },
                data,this.idContenedor,'UniConsDocumentoTec')
        }
    },
	successBU:function(resp){
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if(!reg.ROOT.error){
				alert(reg.ROOT.detalle.mensaje)
				
			}else{
				
				alert('ocurrio un error durante el proceso')
			}
			resp.argument.node.reload();
			
		},
	
    	east:{
		  url:'../../../sis_mantenimiento/vista/uni_cons_det/UniConsDet.php',
		  title:'Atributos del Equipo', 
		  width:400,
		  cls:'UniConsDet'
		 },
		 onBeforeLoad:function(treeLoader, node) {
				treeLoader.baseParams.tipo_nodo = node.attributes.tipo_nodo;
				Phx.vista.UniCons.superclass.onBeforeLoad.call(this,treeLoader, node)
		},
	
	fwidth: 450,
	fheight: 500,
	createWindowAddPlantilla : function() {
		this.formUC = new Ext.form.FormPanel({
			baseCls: 'x-plain-' + this.idContenedor,
			bodyStyle: 'padding:10 20px 10;',
			autoDestroy: true,
			border: false,
			layout: 'form',
			items: [{
				xtype: 'combo',
				name: 'id_uni_cons',
				fieldLabel: 'Plantilla',
				allowBlank: false,
				emptyText: 'Elija una Plantilla...',
				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/UniCons/listarUniConsPlano',
					id: 'id_uni_cons',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_uni_cons', 'codigo', 'nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {
						par_filtro: 'tuc.nombre#tuc.codigo',
						tipo: 'tuc'
					}
				}),
				valueField: 'id_uni_cons',
				displayField: 'nombre',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 500,
				width: 250,
				listWidth: '280',
				minChars: 2
			}]
		});

		var cmbUC = this.formUC.getForm().findField('id_uni_cons');
		cmbUC.store.on('exception', this.conexionFailure, this)

		this.wUC = new Ext.Window({
			title: 'Agregar Plantilla',
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
			modal: true,
			closeAction: 'hide',
			buttons: [{
				text: 'Guardar',
				handler: this.onAddPlantilla,
				scope: this

			}, {
				text: 'Cancelar',
				handler: function() {
					this.wUC.hide()
				},
				scope: this
			}]
		});
	},
	onAddPlantilla: function() {
		if (this.formUC.getForm().isValid()) {
			//Phx.CP.loadingShow();
			var nodo = this.sm.getSelectedNode();
			var cmbUC = this.formUC.getForm().findField('id_uni_cons');
			console.log(nodo)

			Ext.Ajax.request({
				url: '../../sis_mantenimiento/control/UniCons/addPlantilla',
				params: {
					id_plantilla : cmbUC.getValue(),
					id_uni_cons : nodo.attributes.id_uni_cons
				},
				success: this.successAddPlantilla,
				failure: this.conexionFailure,
				timeout: this.timeout,
				scope: this
			});
		}
	},
	onBtnAddPlantilla: function(){
    	var nodo = this.sm.getSelectedNode();
			this.formUC.form.reset()
			if (nodo) {
				this.wUC.show()
			}
   },
   successAddPlantilla: function(resp) {
		Phx.CP.loadingHide();
		var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
		if (reg.ROOT.error) {
			alert("ERROR no esperado")
		} else {
			this.wUC.hide();
			var nodo = this.sm.getSelectedNode();
			nodo.reload();
		}
	}
		
})
</script>
		
		