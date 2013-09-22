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
		
		//Eventos
		this.Cmp.id_lugar.on('select',this.filtrarProveedor,this);
		this.Cmp.id_lugar.on('blur',this.filtrarProveedor,this);
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
                    baseParams:{par_filtro:'item.codigo#item.nombre'}
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
                anchor: '100%',
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
				name:'id_lugar',
    			tinit:true,
    			tasignacion:true,
    			tname:'id_lugar',
    			tdisplayField:'nombre',
    			turl:'../../../sis_parametros/vista/lugar/Lugar.php',
	   			ttitle:'Lugares',
	   			tdata:{},
	   			tcls:'Lugar',
	   			pid:this.idContenedor,
	   			fieldLabel:'Lugar x Proveedor',
	   			allowBlank:true,
	   			emptyText:'Lugar ...',
	   			store: new Ext.data.JsonStore({
                    url: '../../sis_parametros/control/Lugar/listarLugar',
                    id: 'id_lugar',
                    root: 'datos',
                    sortInfo:{
                        field: 'nombre',
                        direction: 'ASC'
                    },
                    fields: ['id_lugar','codigo','nombre'],
                    remoteSort: true,
                    baseParams:{par_filtro:'nombre'}
                }),
	   			tpl:'<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p></div></tpl>',
				valueField: 'id_lugar',
				hiddenValue: 'id_lugar',
				hiddenName:'id_lugar',
				displayField: 'nombre',
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth:220,
				minChars:2,
				renderer:function(value, p, record){return String.format('{0}', record.data['nombre']);},
				autoSelect:true
    		},
			type:'TrigguerCombo',
			id_grupo:0,
			grid:false,
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
                anchor: '100%',               
                renderer:function(value, p, record){return String.format('{0}', record.data['estado_reg']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'unitem.estado_reg',
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
		        anchor:'100%',
		        allowBlank:true,
		        gwidth:150,
		        maxLength:2000		        
		    },
		    type:'TextArea',
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
				format:'Y-m-d',
				hidden:true
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				//gwidth: 110,
				//renderer:function (value,p,record){return value?value.dateFormat('d/m/Y h:i:s'):''}
				format:'Y-m-d',
				hidden:true
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
	title:'Item del Equipo',
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
		{name:'usr_mod', type: 'string'},
		'id_proveedor',
		'desc_proveedor'		
	],
	sortInfo:{
		field: 'id_uni_cons_item',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	fwidth: 450,
	fheight: 250,
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L',
	filtrarProveedor: function(a){
		this.Cmp.id_proveedor.store.baseParams.id_lugar=a.value;
		this.Cmp.id_proveedor.setValue('');
		this.Cmp.id_proveedor.modificado=true;
	}
	
})
</script>
		
		