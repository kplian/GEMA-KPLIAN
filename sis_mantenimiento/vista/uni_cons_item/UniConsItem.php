<?php
/**
*@package       pXP
*@file          gen-UniConsItem.php
*@author        (rac)
*@date          01-11-2012 11:53:15
*@description   Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UniConsItem=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
		Phx.vista.UniConsItem.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, id_uni_cons:this.id_uni_cons}})
		this.loadValoresIniciales();
	},
	
	loadValoresIniciales:function()
    {
        
        Phx.vista.UniConsItem.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_uni_cons').setValue(this.id_uni_cons);     
    },
			
	Atributos:[
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons_item'
			},
			type:'Field',
			form:true 
		},
		{
          config:{
                name:'id_item',
                fieldLabel:'Item',
                allowBlank:false,
                emptyText:'Item...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_almacenes/control/Item/listarItem',
                    id: 'id_item',
                    root: 'datos',
                    sortInfo:{
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    fields: ['id_item','codigo','nombre'],
                    remoteSort: true,
                    baseParams:{par_filtro:'codigo#nombre'}
                }),
                valueField: 'id_item',
                displayField: 'nombre',
                gdisplayField: 'nombre',
                hiddenName: 'id_item',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:250,
                minChars:2,
                enableMultiSelect:true,            
                renderer:function(value, p, record){return String.format('{0}', record.data['nombre']);}
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
			    name:'estado_reg',
                fieldLabel:'Estado reg.',
                allowBlank:false,
                emptyText:'Estado reg...',
                store: ['activo','inactivo'],
                valueField: 'estado_reg',
                displayField: 'estado_reg',
                forceSelection:true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'local',
                pageSize:10,
                width:250,               
                renderer:function(value, p, record){return String.format('{0}', record.data['estado_reg']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'estado_reg',
                type:'string'
            },
            grid:true,
            form:true
		},
		{
			config:{
				name: 'id_uni_cons',
				labelSeparator:'',
				inputType:'hidden'				
			},
			type:'Field',
			form:true
		},
		{
		    config:{
		        name:'observaciones',
		        fieldLabel:'Observaciones',
		        anchor:'80%',
		        allowBlank:true,
		        gwidth:150,
		        maxLength:2000		        
		    },
		    type:'TextField',
		    filters:{pfiltro:'unitem.observaciones',type:'string'},
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
				//gwidth: 110,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'unitem.fecha_reg',type:'date'},
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
				//gwidth: 110,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'unitem.fecha_mod',type:'date'},
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
	title:'Items de la Unidad constructiva',
	ActSave:'../../sis_mantenimiento/control/UniConsItem/insertarUniConsItem',
	ActDel:'../../sis_mantenimiento/control/UniConsItem/eliminarUniConsItem',
	ActList:'../../sis_mantenimiento/control/UniConsItem/listarUniConsItem',
	id_store:'id_uni_cons_item',
	fields: [
		{name:'id_uni_cons_item', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'id_item', type: 'numeric'},
		{name:'nombre',type:'string'},
		{name:'observaciones',type:'string'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}		
	],
	sortInfo:{
		field: 'id_uni_cons_item',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
}
)
</script>
		
		