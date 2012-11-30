<?php
/**
*@package   pXP
*@file      TpmTarjetaDet.php
*@author    Gonzalo Sarmiento Sejas
*@date 29-11-2012 14:51:50
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
//var localizacion=0;
Phx.vista.TpmTarjetaDet=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.TpmTarjetaDet.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_tpm_tarjeta_det'
			},
			type:'Field',
			form:true 
		},
		{
			config:{			    
                labelSeparator:'',
                inputType:'hidden',
				name: 'id_tpm_tarjeta',
			},
			type:'Field',
			form:true
		},
        {
            config:{
                name:'id_funcionario_detec',
                fieldLabel:'Detec. Funcionario',
                allowBlank:true,
                emptyText:'Detec Funcionario...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_organigrama/control/Funcionario/listarFuncionario',
                    id: 'id_funcionario',
                    root: 'datos',
                    sortInfo:{
                        field: 'desc_person',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_funcionario','desc_person'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'desc_person'}
                }),
                valueField: 'id_funcionario',
                displayField: 'desc_person',
                gdisplayField: 'desc_person',
                hiddenName: 'id_funcionario',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:250,
                minChars:2,
                gwidth: 140,            
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_func_detec']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   pfiltro:'descripcion',
                        type:'string'
                    },
            grid:true,
            form:true
        },
        {
            config:{
                name:'id_uni_cons',
                fieldLabel:'Unidad Construc.',
                allowBlank:true,
                emptyText:'Unidad Construc...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_mantenimiento/control/UniCons/listarUniConsLocalizacion',
                    id: 'id_uni_cons',
                    root: 'datos',
                    sortInfo:{
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_uni_cons','nombre','codigo'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'nombre#codigo'}
                }),
                valueField: 'id_uni_cons',
                displayField: 'nombre',
                gdisplayField: 'codigo',
                hiddenName: 'id_uni_cons',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:250,
                minChars:2,
                gwidth: 130,            
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_uni_cons']);}
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
                name: 'descripcion',
                fieldLabel: 'Descripcion',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:2000
            },
            type:'TextField',
            filters:{pfiltro:'tardet.descripcion',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        }, 
        {
            config:{                
                name:'acceso_dificil',
                fieldLabel:'Acceso Dificil',
                allowBlank:false,
                emptyText:'...',
                store: ['si','no'],
                valueField: 'acceso_dificil',
                displayField: 'acceso_dificil',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',              
                renderer:function(value, p, record){return String.format('{0}', record.data['acceso_dificil']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'acceso_dificil',
                type:'string'
            },
            grid:true,
            form:true
        },       
        {
            config:{                
                name:'cond_inseg',
                fieldLabel:'Cond. Insegura',
                allowBlank:false,
                emptyText:'...',
                store: ['si','no'],
                valueField: 'cond_inseg',
                displayField: 'cond_inseg',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',
                gwidth: 120,              
                renderer:function(value, p, record){return String.format('{0}', record.data['cond_inseg']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'cond_inseg',
                type:'string'
            },
            grid:true,
            form:true
        },
        {
            config:{                
                name:'contaminacion',
                fieldLabel:'Contaminacion',
                allowBlank:false,
                emptyText:'...',
                store: ['si','no'],
                valueField: 'contaminacion',
                displayField: 'contaminacion',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',
                gwidth: 120,              
                renderer:function(value, p, record){return String.format('{0}', record.data['contaminacion']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'contaminacion',
                type:'string'
            },
            grid:true,
            form:true
        },   
        {
            config:{                
                name:'falla_me',
                fieldLabel:'Falla ME',
                allowBlank:false,
                emptyText:'...',
                store: ['si','no'],
                valueField: 'falla_me',
                displayField: 'falla_me',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',              
                renderer:function(value, p, record){return String.format('{0}', record.data['falla_me']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'falla_me',
                type:'string'
            },
            grid:true,
            form:true
        },
        {
            config:{                
                name:'falla_el',
                fieldLabel:'Falla EL',
                allowBlank:false,
                emptyText:'...',
                store: ['si','no'],
                valueField: 'falla_el',
                displayField: 'falla_el',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',              
                renderer:function(value, p, record){return String.format('{0}', record.data['falla_el']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'falla_el',
                type:'string'
            },
            grid:true,
            form:true
        },
        {
            config:{                
                name:'falla_ist',
                fieldLabel:'Falla IST',
                allowBlank:false,
                emptyText:'...',
                store: ['si','no'],
                valueField: 'falla_ist',
                displayField: 'falla_ist',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',              
                renderer:function(value, p, record){return String.format('{0}', record.data['falla_ist']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'falla_ist',
                type:'string'
            },
            grid:true,
            form:true
        },
        {
            config:{                
                name:'falla_ne',
                fieldLabel:'Falla NE',
                allowBlank:false,
                emptyText:'...',
                store: ['si','no'],
                valueField: 'falla_ne',
                displayField: 'falla_ne',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',              
                renderer:function(value, p, record){return String.format('{0}', record.data['falla_ne']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'falla_ne',
                type:'string'
            },
            grid:true,
            form:true
        },
        {
            config:{                
                name:'falla_hi',
                fieldLabel:'Falla HI',
                allowBlank:false,
                emptyText:'...',
                store: ['si','no'],
                valueField: 'falla_hi',
                displayField: 'falla_hi',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',              
                renderer:function(value, p, record){return String.format('{0}', record.data['falla_hi']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'falla_hi',
                type:'string'
            },
            grid:true,
            form:true
        },
        {
            config:{
                name: 'oportunidad_mejora',
                fieldLabel: 'Oport. Mejora',
                allowBlank: true,
                anchor: '80%',
                gwidth: 110,
                maxLength:500
            },
            type:'TextField',
            filters:{pfiltro:'tardet.oportunidad_mejora',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'fecha_coloc',
                fieldLabel: 'Fecha Colocacion',
                allowBlank: true,
                anchor: '80%',
                gwidth: 140,
                renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
                format:'d/m/Y'
            },
            type:'DateField',
            filters:{pfiltro:'tardet.fecha_coloc',type:'date'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'fecha_retiro',
                fieldLabel: 'Fecha Retiro',
                allowBlank: true,
                anchor: '80%',
                gwidth: 120,
                renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
                format:'d/m/Y'
            },
            type:'DateField',
            filters:{pfiltro:'tardet.fecha_retiro',type:'date'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name:'id_funcionario_efec',
                fieldLabel:'Efect. Funcionario',
                allowBlank:true,
                emptyText:'Efect Funcionario...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_organigrama/control/Funcionario/listarFuncionario',
                    id: 'id_funcionario',
                    root: 'datos',
                    sortInfo:{
                        field: 'desc_person',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_funcionario','desc_person'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'desc_person'}
                }),
                valueField: 'id_funcionario',
                displayField: 'desc_person',
                gdisplayField: 'desc_person',
                hiddenName: 'id_funcionario',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:250,
                minChars:2,            
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_func_efec']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'descripcion',
                type:'string'
            },
            grid:true,
            form:true
        },
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '80%',
				gwidth: 120,
				maxLength:1000
			},
			type:'TextField',
			filters:{pfiltro:'tardet.observaciones',type:'string'},
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
			filters:{pfiltro:'tardet.estado_reg',type:'string'},
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
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'tardet.fecha_reg',type:'date'},
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
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'tardet.fecha_mod',type:'date'},
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
				gwidth: 120,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Detalle',
	ActSave:'../../sis_mantenimiento/control/TpmTarjetaDet/insertarTpmTarjetaDet',
	ActDel:'../../sis_mantenimiento/control/TpmTarjetaDet/eliminarTpmTarjetaDet',
	ActList:'../../sis_mantenimiento/control/TpmTarjetaDet/listarTpmTarjetaDet',
	id_store:'id_tpm_tarjeta_det',
	fields: [
		{name:'id_tpm_tarjeta_det', type: 'numeric'},
		{name:'id_tpm_tarjeta', type: 'numeric'},
		{name:'id_funcionario_detec', type: 'numeric'},
		{name:'desc_func_detec', type: 'string'},
		{name:'id_funcionario_efec', type: 'numeric'},
		{name:'desc_func_efec', type: 'string'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'desc_uni_cons', type: 'string'},
		{name:'observaciones', type: 'string'},
		{name:'falla_el', type: 'string'},
		{name:'fecha_retiro', type: 'date', dateFormat:'Y-m-d'},
		{name:'contaminacion', type: 'string'},
		{name:'oportunidad_mejora', type: 'string'},
		{name:'falla_ist', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'acceso_dificil', type: 'string'},
		{name:'falla_ne', type: 'string'},
		{name:'falla_me', type: 'string'},
		{name:'fecha_coloc', type: 'date', dateFormat:'Y-m-d'},
		{name:'estado_reg', type: 'string'},
		{name:'cond_inseg', type: 'string'},
		{name:'falla_hi', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_tpm_tarjeta_det',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	onReloadPage:function(m){       
        this.maestro=m;
        this.Atributos[1].valorInicial=this.maestro.id_tpm_tarjeta;
        this.Atributos[3].config.store.baseParams.id_localizacion=this.maestro.id_localizacion;
        if(m.id != 'id'){
        this.store.baseParams={id_tpm_tarjeta:this.maestro.id_tpm_tarjeta};        
        this.load({params:{start:0, limit:50}})       
       }
       else{
         this.grid.getTopToolbar().disable();
         this.grid.getBottomToolbar().disable(); 
         this.store.removeAll();            
       }
   } 
}
)
</script>
		
		