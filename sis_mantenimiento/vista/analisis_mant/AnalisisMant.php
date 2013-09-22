<?php
/**
*@package pXP
*@file gen-AnalisisMant.php
*@author  (admin)
*@date 30-09-2012 21:44:06
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AnalisisMant=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
		console.log(this.maestro);
    	//llama al constructor de la clase padre
		Phx.vista.AnalisisMant.superclass.constructor.call(this,config);		
        this.addButton('btnReporte',{
            text :'Reporte Analisis RCM',
            iconCls : 'bpdf32',
            disabled: true,
            handler : this.onButtonAnalisisRCM,
            tooltip : '<b>Reporte RCM</b><br/><b>Reporte Analisis RCM</b>'
        });
		this.init();
		this.load({params:{start:0, limit:50,id_uni_cons:this.id_uni_cons}})
        this.loadValoresIniciales();
        
        //Define el store para obtener los subsistemas
        this.getComponente('id_uni_cons_hijo').store.baseParams={par_filtro:'nombre#codigo',id_uni_cons:this.maestro.id_uni_cons,tipo:'tuc'}
        
        //Eventos
        this.getComponente('preparado_por').on('blur',function(a){
        	if(a.value=='Organigrama'){
        		this.getComponente('id_uo').enable();
        		this.getComponente('id_persona_prep').disable();
        		this.getComponente('id_uo').allowBlank=false;
        		this.getComponente('id_persona_prep').allowBlank=true;
        		this.getComponente('id_persona_prep').setValue('');
        	} else{
        		this.getComponente('id_uo').disable();
        		this.getComponente('id_persona_prep').enable();
        		this.getComponente('id_uo').allowBlank=true;
        		this.getComponente('id_persona_prep').allowBlank=false;
        		this.getComponente('id_uo').setValue('');
        	}
        },this);
	},
	
	loadValoresIniciales:function()
    {        
        Phx.vista.AnalisisMant.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_uni_cons').setValue(this.id_uni_cons);     
    },
    
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_analisis_mant'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
   				name:'id_uni_cons_hijo',
   				fieldLabel:'Subsistema',
   				allowBlank:true,
   				emptyText:'Subsistema...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/UniCons/listarUniConsHijo',
					id: 'id_uni_cons_hijo',
					root: 'datos',
					sortInfo:{
						field: 'prioridad',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_uni_cons_hijo','nombre','codigo'],
					remoteSort: true
				}),
   				valueField: 'id_uni_cons_hijo',
   				displayField: 'nombre',
   				gdisplayField: 'codigo',
   				hiddenName: 'id_uni_cons_hijo',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				anchor: '100%',
   				minChars:2,
       			enableMultiSelect:true,   			
   				renderer:function(value, p, record){return String.format('{0}', record.data['desc_uni_cons_hijo']);}
	       	},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{
   		        pfiltro:'nombre',
                type:'string'
   			},
   			grid:true,
   			form:true
	    },
		{
			config:{
				name: 'id_tipo_mant',
				fieldLabel: 'Tipo Mantenimiento',
				allowBlank: false,
				emptyText:'Elija un tipo de mantenimiento...',
				store:new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/TipoMant/listarTipoMant',
					id: 'id_tipo_mant',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_tipo_mant','nombre','codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_tipo_mant',
				displayField: 'nombre',
				gdisplayField:'desc_tipo_mant',
				//hiddenName: 'id_administrador',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_tipo_mant']);}
			},
			type:'ComboBox',
			filters:{pfiltro:'getima.nombre',type:'string'},
			id_grupo:0,
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
			filters:{pfiltro:'geanma.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_emision',
				fieldLabel: 'Fecha de Emisión',
				allowBlank: true,
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geanma.fecha_emision',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextArea',
			filters:{pfiltro:'geanma.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'preparado_por',
				fieldLabel: 'Quien Prepara',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 200,
				hiddenName: 'preparado_por',
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'tanalisis_mant__preparado_por'
					}
			},
			type: 'ComboRec',
			id_grupo: 0,
			grid: false,
			form: true
		},
		{
			config: {
				name: 'id_uo',
				fieldLabel: 'Preparado por UO',
				allowBlank: false,
				origen: 'UO',
				gdisplayField: 'nombre_unidad',
				gwidth: 200,
				renderer:function(value, p, record){return String.format('{0}', record.data['nombre_unidad']);},
				anchor: '100%',
				disabled:true,
				hiddenName:'id_uo'
			},
			type: 'ComboRec',
			id_grupo: 2,
			filters:{pfiltro:'gemapr.tipo',type:'string'},
			grid: true,
			form: true
		},
		{
	   		config:{
	       		    name:'id_persona_prep',
	   				origen:'PERSONA',
	   				fieldLabel: 'Preparado por Persona',
	   				tinit:true,
	   				gdisplayField:'desc_person',//mapea al store del grid
	   			    gwidth:200,
	   			    anchor:'100%',
		   			renderer:function (value, p, record){return String.format('{0}', record.data['preparado_por']);},
		   			disabled: true,
		   			hiddenName:'id_persona_prep'
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'per1.nombre_completo1',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
	   	},
		{
	   		config:{
	       		    name:'id_persona_rev',
	   				origen:'PERSONA',
	   				tinit:true,
	   				allowBlank:false,
	   				fieldLabel:'Revisado por',
	   				gdisplayField:'desc_person',//mapea al store del grid
	   			    gwidth:200,
	   			    anchor:'100%',
		   			renderer:function (value, p, record){return String.format('{0}', record.data['desc_person']);}
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
	   			filters:{	
			        pfiltro:'per.nombre_completo1',
					type:'string'
				},
	   		   
	   			grid:true,
	   			form:true
	   	},
		
		{
			config:{
				name: 'fecha_rev',
				fieldLabel: 'Fecha Rev.',
				allowBlank: true,
				gwidth: 100,
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				format:'d/m/Y'
			},
			type:'DateField',
			filters:{pfiltro:'geanma.fecha_rev',type:'date'},
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
				maxLength:4,
				hidden:true
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'geanma.fecha_reg',type:'date'},
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
				maxLength:4,
				hidden:true
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
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''},
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'geanma.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Análisis de Mantenimiento',
	ActSave:'../../sis_mantenimiento/control/AnalisisMant/insertarAnalisisMant',
	ActDel:'../../sis_mantenimiento/control/AnalisisMant/eliminarAnalisisMant',
	ActList:'../../sis_mantenimiento/control/AnalisisMant/listarAnalisisMant',
	id_store:'id_analisis_mant',
	fields: [
		{name:'id_analisis_mant', type: 'numeric'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'id_tipo_mant', type: 'numeric'},
		{name:'id_persona_rev', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_emision', type: 'date', dateFormat:'Y-m-d'},
		{name:'descripcion', type: 'string'},
		{name:'fecha_rev', type: 'date', dateFormat:'Y-m-d'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_tipo_mant', type: 'string'},
		{name:'desc_person', type: 'string'},
		{name:'preparado_por', type: 'string'},
		{name:'id_uni_cons_hijo', type: 'numeric'},
		{name:'desc_uni_cons_hijo', type: 'string'},
		'id_uo',
		'nombre_unidad',
		'id_persona_prep'
	],
	sortInfo:{
		field: 'id_analisis_mant',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	fwidth: 450,
	onReloadPage:function(m)
	{
		this.maestro=m;						
		this.store.baseParams={id_uni_cons:this.maestro.id_uni_cons};
		this.load({params:{start:0, limit:50,}});			
	},
	
	onButtonAnalisisRCM:function(){
	    var rec=this.sm.getSelected();
                console.debug(rec);
                Ext.Ajax.request({
                    url:'../../sis_mantenimiento/control/AnalisisMant/reporteAnalisisMant',
                    params:{'id_analisis_mant':rec.data.id_analisis_mant},
                    success: this.successExport,
                    failure: function() {
                        console.log("fail");
                    },
                    timeout: function() {
                        console.log("timeout");
                    },
                    scope:this
                });  
	},
	south:{
		  url:'../../../sis_mantenimiento/vista/funcion/Funcion.php',
		  title:'Funciones', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'FFuncion'
	},
	preparaMenu: function(n) {
		var tb = Phx.vista.AnalisisMant.superclass.preparaMenu.call(this);
	  	this.getBoton('btnReporte').setDisabled(false);
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.AnalisisMant.superclass.liberaMenu.call(this);
		this.getBoton('btnReporte').setDisabled(true);
		return tb;
	},
	codReporte:'GMAN-RG-SM-009',
	codSistema:'GEM',
	pdfOrientacion:'L',
	onButtonEdit: function(){
		Phx.vista.AnalisisMant.superclass.onButtonEdit.call(this);
		var data = this.getSelectedData();
		console.log(data.id_uo)
		if(data.id_uo!=''&&data.id_uo!=null){
			this.getComponente('preparado_por').setValue('Organigrama');
			this.getComponente('id_uo').enable();
    		this.getComponente('id_persona_prep').disable();
    		this.getComponente('id_uo').allowBlank=false;
    		this.getComponente('id_persona_prep').allowBlank=true;
    		this.getComponente('id_persona_prep').setRawValue('');
		} else{
			this.getComponente('preparado_por').setValue('Persona');
			this.getComponente('id_uo').disable();
    		this.getComponente('id_persona_prep').enable();
    		this.getComponente('id_uo').allowBlank=true;
    		this.getComponente('id_persona_prep').allowBlank=false;
    		this.getComponente('id_uo').setRawValue('');
		}
		
	},
	title1:'REGISTRO',
	title2:'Análisis RCM'
})
</script>
		
		