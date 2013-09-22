<?php
/**
*@package       pXP
*@file          gen-PlanMant.php
*@author        (rac)
*@date          12-10-2012 16:15:31
*@description   Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PlanMant=Ext.extend(Phx.gridInterfaz,{
    
	constructor:function(config){
		this.maestro=config;
		Phx.vista.PlanMant.superclass.constructor.call(this,config);
		this.addButton('btnReporte',{
            text:'Reporte Plan RCM',
            iconCls: 'bpdf32',
            disabled: true,
            handler: this.onButtonReportePlanRCM,
            tooltip: '<b>Plan RCM</b><br/>Reporte Plan RCM'
        });
		this.init();
		this.load({params:{start:0, limit:50, id_uni_cons:this.id_uni_cons}});
		
		//Define el store para obtener los subsistemas
        this.getComponente('id_uni_cons_hijo').store.baseParams={par_filtro:'nombre#codigo',id_uni_cons:this.maestro.id_uni_cons,tipo:'tuc'}
        
        //Eventos
        this.getComponente('preparado_por').on('blur',function(a){
        	if(a.value=='Organigrama'){
        		this.getComponente('id_uo').enable();
        		this.getComponente('id_persona').disable();
        		this.getComponente('id_uo').allowBlank=false;
        		this.getComponente('id_persona').allowBlank=true;
        		this.getComponente('id_persona').setValue('');
        	} else{
        		this.getComponente('id_uo').disable();
        		this.getComponente('id_persona').enable();
        		this.getComponente('id_uo').allowBlank=true;
        		this.getComponente('id_persona').allowBlank=false;
        		this.getComponente('id_uo').setValue('');
        	}
        },this);
	},
				
	Atributos:[
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_plan_mant'
			},
			type:'Field',
			form:true,
			valorInicial: this.id_plan_mant 
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
   				gdisplayField: 'desc_uni_cons_hijo',
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
	       		    name:'id_persona',
	   				origen:'PERSONA',
	   				fieldLabel: 'Preparado por Persona',
	   				tinit:true,
	   				gdisplayField:'nombre_funcionario',//mapea al store del grid
	   			    gwidth:200,
	   			    anchor:'100%',
		   			renderer:function (value, p, record){return String.format('{0}', record.data['nombre_funcionario']);},
		   			disabled: true,
		   			hiddenName:'id_persona'
	       	     },
	   			type:'ComboRec',
	   			id_grupo:0,
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
	   				gdisplayField:'nombre_funcionario_rev',//mapea al store del grid
	   			    gwidth:200,
	   			    anchor:'100%',
		   			renderer:function (value, p, record){return String.format('{0}', record.data['nombre_funcionario_rev']);}
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
				name: 'id_tipo_mant',
				fieldLabel: 'Tipo de mantenimiento',
				allowBlank: false,
				emptyText:'Tipo de mantenimiento...',
   				store: new Ext.data.JsonStore({
					url: '../../sis_mantenimiento/control/TipoMant/listarTipoMant',
					id: 'id_tipo_mant',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_tipo_mant','nombre'],
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
				valueField: 'id_tipo_mant',
   				displayField: 'nombre',
   				gdisplayField:'tipo_mant',
   				hiddenName: 'id_tipo_mant',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				anchor: '100%',
   				gwidth:100,
   				minChars:2,   				   			   
   				renderer:function (value, p, record){return String.format('{0}', record.data['tipo_mant']);}
			},
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{	
		        pfiltro:'nombre',
				type:'string'
            },   		   
   			grid:false,
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
                name: 'tipo_mant',
                fieldLabel: 'Tipo Mantenimiento',
                anchor: '100%',
                gwidth: 100
            },
            type:'TextField',
            id_grupo:1,
            grid:true,
            form:false
        },		
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextArea',
			filters:{pfiltro:'plama.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_emision',
				fieldLabel: 'Fecha de Emisión',
				allowBlank: true,
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y/m/d'
			},
			type:'DateField',
			filters:{pfiltro:'plama.fecha_emision',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha',
				fieldLabel: 'Fecha de Revisión',
				allowBlank: true,
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y/m/d'
			},
			type:'DateField',
			filters:{pfiltro:'plama.fecha',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'plama.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
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
				//gwidth: 100,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d',
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'plama.fecha_reg',type:'date'},
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
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d',
				hidden:true
			},
			type:'DateField',
			filters:{pfiltro:'plama.fecha_mod',type:'date'},
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
		}
	],
	title:'Plan de Mantenimiento',
	ActSave:'../../sis_mantenimiento/control/PlanMant/insertarPlanMant',
	ActDel:'../../sis_mantenimiento/control/PlanMant/eliminarPlanMant',
	ActList:'../../sis_mantenimiento/control/PlanMant/listarPlanMant',
	id_store:'id_plan_mant',
	
	onButtonNew: function() {		
		Phx.vista.PlanMant.superclass.onButtonNew.call(this);	
		this.getComponente('id_uni_cons').setValue(this.id_uni_cons);	
	},
	
	fields: [
		{name:'id_plan_mant', type: 'numeric'},
		{name:'id_persona', type: 'numeric'},
		{name:'id_persona_rev', type: 'numeric'},		
		{name:'id_tipo_mant', type: 'numeric'},
		{name:'tipo_mant', type: 'string'},
		{name:'nombre_funcionario', type: 'string'},
		{name:'nombre_funcionario_rev', type: 'string'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'fecha', type: 'timestamp'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'id_uni_cons_hijo', type: 'numeric'},
		{name:'desc_uni_cons_hijo', type: 'string'},
		'id_uo',
		'nombre_unidad',
		{name:'fecha_emision', type: 'date'},	
	],
	sortInfo:{
		field: 'id_plan_mant',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	fwidth: 450,
	fheight: 300,
	onButtonReportePlanRCM:function(){
        var rec=this.sm.getSelected();
                console.debug(rec);
                Ext.Ajax.request({
                    url:'../../sis_mantenimiento/control/PlanMant/reportePlanMant',
                    params:{'id_plan_mant':rec.data.id_plan_mant},
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
		  url:'../../../sis_mantenimiento/vista/tarea/Tarea.php',
		  title:'Tareas de mantenimiento',
		  height:'40%', 
		  width:400,
		  cls:'Tarea'
	},
	preparaMenu: function(n) {
		var tb = Phx.vista.PlanMant.superclass.preparaMenu.call(this);
	  	this.getBoton('btnReporte').setDisabled(false);
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.PlanMant.superclass.liberaMenu.call(this);
		this.getBoton('btnReporte').setDisabled(true);
		return tb;
	},
    codReporte:'GMAN-RG-SM-010',
	codSistema:'GEM',
	pdfOrientacion:'L',
	onButtonEdit: function(){
		Phx.vista.PlanMant.superclass.onButtonEdit.call(this);
		var data = this.getSelectedData();
		if(data.id_uo!=''&&data.id_uo!=null){
			this.getComponente('preparado_por').setValue('Organigrama');
			this.getComponente('id_uo').enable();
    		this.getComponente('id_persona').disable();
    		this.getComponente('id_uo').allowBlank=false;
    		this.getComponente('id_persona').allowBlank=true;
    		this.getComponente('id_persona').setRawValue('');
		} else{
			this.getComponente('preparado_por').setValue('Persona');
			this.getComponente('id_uo').disable();
    		this.getComponente('id_persona').enable();
    		this.getComponente('id_uo').allowBlank=true;
    		this.getComponente('id_persona').allowBlank=false;
    		this.getComponente('id_uo').setRawValue('');
		}
		
	},
	title1:'REGISTRO',
	title2:'Requerimiento de Mantenimiento'
})
</script>