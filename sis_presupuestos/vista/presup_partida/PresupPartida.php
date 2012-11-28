<?php
/**
*@package pXP
*@file gen-PresupPartida.php
*@author  Gonzalo Sarmiento Sejas
*@date 26-11-2012 22:02:47
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PresupPartida=Ext.extend(Phx.gridInterfaz,{  
           
	constructor:function(config){
		this.maestro=config.maestro;
		this.tipo=config.tipo;
    	//llama al constructor de la clase padre
		Phx.vista.PresupPartida.superclass.constructor.call(this,config);
		this.init();
		if(Phx.CP.getPagina(this.idContenedorPadre)){
            var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
            if(dataMaestro){
                this.onEnablePanel(this,dataMaestro)
            }
        }
	},
	
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_presup_partida'
			},
			type:'Field',
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
			filters:{pfiltro:'prepar.estado_reg',type:'string'},
			id_grupo:1,
			grid:false,
			form:false
		},
		{
			config:{
				name: 'tipo',
				fieldLabel: 'Tipo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:15,
				disabled: true
			},
			type:'TextField',
			filters:{pfiltro:'prepar.tipo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		/*{
			config:{
				name: 'id_centro_costo',
				fieldLabel: 'id_centro_costo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'prepar.id_centro_costo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},*/
		{
            config:{
                name:'id_centro_costo',
                fieldLabel:'Centro Costo',
                allowBlank:true,
                emptyText:'Centro Costo...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_mantenimiento/control/CentroCosto/listarCentroCosto',
                    id: 'id_centro_costo',
                    root: 'datos',
                    sortInfo:{
                        field: 'codigo',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_centro_costo','codigo','descripcion'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'codigo#descripcion'}
                }),
                valueField: 'id_centro_costo',
                displayField: 'codigo',
                gdisplayField: 'descripcion',
                hiddenName: 'id_centro_costo',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:260,
                minChars:2,            
                renderer:function(value, p, record){return String.format('{0}', record.data['centro_codigo']);}
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
			    labelSeparator:'',
                inputType:'hidden',
				name: 'id_presupuesto'
			},
			type:'Field',
			form:true
		},
		{
            config:{
                name:'id_partida',
                fieldLabel:'Partida',
                allowBlank:false,
                emptyText:'Partida...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_presupuestos/control/Partida/listarPartida',
                    id: 'id_partida',
                    root: 'datos',
                    sortInfo:{
                        field: 'descripcion',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_partida','codigo','descripcion'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'codigo#descripcion'}
                }),
                valueField: 'id_partida',
                displayField: 'codigo',
                gdisplayField: 'descripcion',
                hiddenName: 'id_partida',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:260,
                minChars:2,            
                renderer:function(value, p, record){return String.format('{0}', record.data['partida_codigo']);}
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
				name: 'fecha_hora',
				fieldLabel: 'Fecha hora',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				format: 'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'prepar.fecha_hora',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
            config:{
                name:'id_moneda',
                fieldLabel:'Moneda',
                allowBlank:true,
                emptyText:'Moneda...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Moneda/listarMoneda',
                    id: 'id_moneda',
                    root: 'datos',
                    sortInfo:{
                        field: 'moneda',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_moneda','moneda','codigo'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'moneda#codigo'}
                }),
                valueField: 'id_moneda',
                displayField: 'moneda',
                gdisplayField: 'codigo',
                hiddenName: 'id_moneda',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:260,
                minChars:2,            
                renderer:function(value, p, record){return String.format('{0}', record.data['moneda']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'moneda',
                type:'string'
            },
            grid:true,
            form:true
        },
		{
			config:{
				name: 'importe',
				fieldLabel: 'Importe',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'prepar.importe',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				format: 'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'prepar.fecha_reg',type:'date'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'prepar.fecha_mod',type:'date'},
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
	title:'PresupPartida',
	ActSave:'../../sis_presupuestos/control/PresupPartida/insertarPresupPartida',
	ActDel:'../../sis_presupuestos/control/PresupPartida/eliminarPresupPartida',
	ActList:'../../sis_presupuestos/control/PresupPartida/listarPresupPartida',
	id_store:'id_presup_partida',
	fields: [
		{name:'id_presup_partida', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'id_centro_costo', type: 'numeric'},
		{name:'centro_codigo',type: 'string'},
		{name:'id_presupuesto', type: 'numeric'},
		{name:'id_partida', type: 'numeric'},
		{name:'partida_codigo', type: 'string'},
		{name:'fecha_hora', type: 'timestamp'},
		{name:'id_moneda', type: 'numeric'},
		{name:'moneda', type: 'moneda'},
		{name:'importe', type: 'numeric'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_presup_partida',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	loadValoresIniciales:function()
    {
        Phx.vista.PresupPartida.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_presupuesto').setValue(this.maestro.id_presupuesto);     
    },
    
    onReloadPage:function(m){       
        this.maestro=m;
        this.Atributos[2].valorInicial=this.tipo;
        this.Atributos[4].valorInicial=this.maestro.id_presupuesto;
        if(m.id != 'id'){
        this.store.baseParams={id_presupuesto:this.maestro.id_presupuesto,tipo:this.tipo};
        this.load({params:{start:0, limit:50,tipo:this.tipo}})       
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
		
		