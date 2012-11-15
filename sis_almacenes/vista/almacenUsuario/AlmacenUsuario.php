<?php
/**
*@package pXP
*@file gen-AlmacenUsuario.php
*@author  (admin)
*@date 13-11-2012 01:30:22
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AlmacenUsuario=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.AlmacenUsuario.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_almacen_usuario'
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
				name: 'id_usuario',
				fieldLabel: 'id_usuario',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'almusu.id_usuario',type:'numeric'},
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
			filters:{pfiltro:'almusu.fecha_reg',type:'date'},
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
			filters:{pfiltro:'almusu.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Almaceneros',
	ActSave:'../../sis_almacenes/control/AlmacenUsuario/insertarAlmacenUsuario',
	ActDel:'../../sis_almacenes/control/AlmacenUsuario/eliminarAlmacenUsuario',
	ActList:'../../sis_almacenes/control/AlmacenUsuario/listarAlmacenUsuario',
	id_store:'id_almacen_usuario',
	fields: [
		{name:'id_almacen_usuario', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_almacen_usuario',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	onReloadPage:function(m){
        this.maestro=m;
        this.Atributos[1].valorInicial=this.maestro.id_almacen_usuario;
       if(m.id != 'id'){
        this.store.baseParams={id_almacen_usuario:this.maestro.id_almacen_usuario};
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
		
		