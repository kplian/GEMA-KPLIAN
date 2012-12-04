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
				text : 'Bloquear',
				iconCls : 'block',
				disabled : true,
				handler : this.onBtnBlock,
				tooltip : '<b>Bloquear</b><br/>Bloquea la edición del equipo'
			});
			
			
		//para definir atributos del equipo	
		this.addButton('btnAtrib', {
				text : 'Atributos',
				iconCls : 'blist',
				disabled : false,
				handler : this.onBtnAtribPlan,
				tooltip : '<b>Atributos de la plantilla</b><br/>Definir atributos de la plantilla'
			});
		
		/*this.addButton('btn_MedicionGraf',{
			text:'Mediciones/Indicadores',
			iconCls: 'blist',
			disabled: false,
			handler:this.btn_MedicionGraf,
			tooltip: '<b>Mediciones/Indicadores</b><br/>Detalle de las mediciones / Indicadores'
			}
		);*/
		this.addButton('btnList',{
            text :'PLAN RCM',
            iconCls : 'blist',
            disabled: true,
            handler : this.onButtonList,
            tooltip : '<b>PLAN RCM</b><br/><b>PLAN RCM para un Uni Cons</b>'
        });
        this.addButton('btnUpload',{
           text :'Archivos',
           iconCls : 'bupload',
           disabled : true,
           handler : this.onButtonUpload,
           tooltip : '<b>Archivos</b><br/><b>Archivos de Unidades Constructoras</b>'
        });
        
        this.addButton('btnItems',{
            text : 'Items',
            iconCls : 'bven1',
            disabled : true,
            handler : this.onButtonItems,
            tooltip : '<b>Items</b><br/><b>Registro de items del equipo</b>'
        });
        
        this.addButton('btnProveedores',{
            text : 'Proveedores',
            iconCls : 'bven1',
            disabled : true,
            handler : this.onButtonProv,
            tooltip : '<b>Proveedores</b><br/><b>Registro de proveedores del equipo</b>'
        });
		
		//Incluye un menú
   		this.menuOp = new Ext.Toolbar.SplitButton({
   			text: 'Mediciones/Indicadores',
   			handler: this.onMedicionesClick,
   			iconCls: 'blist',
   			scope: this,
   			menu:{
   				items: [
   				{
   					text: 'Archivos', handler:this.onArchivosClick, scope: this
   				},{
   					text: 'Análisis de Mantenimiento', handler: this.onAnalisisClick, scope: this
   				},{
   					text: 'Plan de Mantenimiento', handler: this.onPlanClick, scope: this
   				}
   				]
   			}
   		});
   		
   		this.tbar.add(this.menuOp);
    
		
    	
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
	       				width:250,
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
		},*/{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
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
				allowBlank: true,
				anchor: '80%',
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
	        width:135
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
		{name:'usr_mod', type: 'string'}		
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
		var tiponodo = n.attributes.tipo_nodo;
			//si es una nodo tipo carpeta habilitamos la opcion de nuevo	
			if((tiponodo == 'raiz_borrador' || tiponodo == 'raiz_aprobado' )&& n.attributes.id != 'id'){
				this.getBoton('btnBlock').enable();	
                this.getBoton('btnUpload').disable();
                this.getBoton('btnItems').disable();
                this.getBoton('btnProveedores').disable();
				if(tiponodo == 'raiz_aprobado'){
					this.getBoton('btnBlock').setIconClass('bunlock'); 
		            this.getBoton('btnBlock').setText( 'Desbloquear' ); 
		            this.getBoton('btnBlock').setTooltip('<p>Desbloquear permite editar</p>'); 
		        }
				else{
					this.getBoton('btnBlock').setIconClass('block'); 
		            this.getBoton('btnBlock').setText( 'Bloquear' ); 
		            this.getBoton('btnBlock').setTooltip('<p>Bloquea la edición del equipo</p>'); 
				}
				
				
			}
			else {
				this.getBoton('btnBlock').disable();
				this.getBoton('btnList').enable();
                this.getBoton('btnUpload').enable();
                this.getBoton('btnItems').enable();
                this.getBoton('btnProveedores').enable();
			}
			// llamada funcion clace padre
			Phx.vista.UniCons.superclass.preparaMenu.call(this,n)
			
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
		Phx.vista.UniCons.superclass.onButtonEdit.call(this)
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
					'Calendario de Planificacion',
					{
						width:800,
						height:400
				    },nodo.attributes,this.idContenedor,'EquipoVariable')
		
		
	},
	

	onButtonList: function(){          
        
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
	onArchivosClick: function(){
		
	},
	onAnalisisClick: function(){
		var node=this.sm.getSelectedNode();
		var data =node.attributes;
		if(data){
			Phx.CP.loadWindows('../../../sis_mantenimiento/vista/analisis_mant/AnalisisMant.php',
				'AnalisisMant',{
						modal:true,
						width:900,
						height:400
				    },
				    data,this.idContenedor,'AnalisisMant')
				    
			}
		
	},
	onPlanClick: function(){
		
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
		  title:'Variables del Equipo', 
		  width:400,
		  cls:'UniConsDet'
		 }
	
	
})
</script>
		
		