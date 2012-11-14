<?php
/**
*@package       pXP
*@file          gen-UniConsProveedor.php
*@author        (rac)
*@date          01-11-2012 14:45:49
*@description   Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.UniConsProveedor=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.UniConsProveedor.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, id_uni_cons:this.id_uni_cons}})
        this.loadValoresIniciales();
    },
    
    loadValoresIniciales:function()
    {        
        Phx.vista.UniConsProveedor.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_uni_cons').setValue(this.id_uni_cons);     
    },
			
	Atributos:[
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_uni_cons_proveedor'
			},
			type:'Field',
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
                name:'id_proveedor',
                fieldLabel:'Proveedor',
                allowBlank:false,
                emptyText:'Proveedor...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Proveedor/listarProveedorCombos',
                    id: 'id_proveedor',
                    root: 'datos',
                    sortInfo:{
                        field: 'desc_proveedor',
                        direction: 'ASC'
                    },
                    fields: ['id_proveedor','desc_proveedor'],
                    remoteSort: true,
                    baseParams:{par_filtro:'desc_proveedor'}
                }),
                valueField: 'id_proveedor',
                displayField: 'desc_proveedor',
                gdisplayField: 'desc_proveedor',
                hiddenName: 'id_proveedor',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:250,
                enableMultiSelect:true,            
                renderer:function(value, p, record){return String.format('{0}', record.data['desc_proveedor']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'desc_proveedor',
                type:'string'
            },
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
				//gwidth: 110,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'unipro.fecha_reg',type:'date'},
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
				//gwidth: 110,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d'
			},
			type:'DateField',
			filters:{pfiltro:'unipro.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Proveedores del equipo',
	ActSave:'../../sis_mantenimiento/control/UniConsProveedor/insertarUniConsProveedor',
	ActDel:'../../sis_mantenimiento/control/UniConsProveedor/eliminarUniConsProveedor',
	ActList:'../../sis_mantenimiento/control/UniConsProveedor/listarUniConsProveedor',
	id_store:'id_uni_cons_proveedor',
	fields: [
		{name:'id_uni_cons_proveedor', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_uni_cons', type: 'numeric'},
		{name:'id_proveedor', type: 'numeric'},
		{name:'desc_proveedor', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'timestamp'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'timestamp'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'}		
	],
	sortInfo:{
		field: 'id_uni_cons_proveedor',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
}
)
</script>
		
		