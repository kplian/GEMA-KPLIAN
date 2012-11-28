<?php
/**
 * @package pxP
 * @file 	Almacen.php
 * @author 	Gonzalo Sarmiento
 * @date	21-09-2012
 * @description	Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.Almacen=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Almacen.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}});
		this.addButton('Almacenero',{
		    text:'Almaceneros',
		    iconCls:'bassign',
		    disabled:false,
		    handler:this.onAlmacenUsuario,
		    tooltip:'<b>Registrar Almacenero'});
	},
	onAlmacenUsuario : function (){                   
            //var rec=this.sm.getSelected();
                        
            Phx.CP.loadWindows('../../../sis_almacenes/vista/almacenUsuario/AlmacenUsuario.php',
            'Registrar Almacenero',
            {
                modal:true,
                width:600,
                height:300
            },'',this.idContenedor,'AlmacenUsuario')
    },
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_almacen'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Codigo',
				allowBlank: false,
				anchor: '80%',
				gwidth: 70,
				maxLength:10
			},
			type:'TextField',
			filters:{type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre almacen',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'localizacion',
				fieldLabel: 'Localizacion',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
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
                name:'id_almacen_usuario',
                fieldLabel:'Almacenero',
                allowBlank:true,
                emptyText:'Almacenero...',
                store: new Ext.data.JsonStore({
                    url: '../../sis_almacenes/control/AlmacenUsuario/listarAlmacenUsuario',
                    id: 'id_almacen_usuario',
                    root: 'datos',
                    sortInfo:{
                        field: 'cuenta',
                        direction: 'ASC'
                    },
                    totalProperty: 'total',
                    fields: ['id_almacen_usuario','cuenta'],
                    // turn on remote sorting
                    remoteSort: true,
                    baseParams:{par_filtro:'cuenta'}
                }),
                valueField: 'id_almacen_usuario',
                displayField: 'cuenta',
                gdisplayField: 'nombre_completo1',
                hiddenName: 'id_almacen_usuario',
                forceSelection:true,
                typeAhead: true,
                triggerAction: 'all',
                lazyRender:true,
                mode:'remote',
                pageSize:10,
                queryDelay:1000,
                width:250,
                minChars:2,            
                renderer:function(value, p, record){return String.format('{0}', record.data['nombre_completo1']);}
            },
            type:'ComboBox',
            id_grupo:0,
            filters:{   
                pfiltro:'nombre_completo1',
                type:'string'
            },
            grid:true,
            form:true
    }		
	],
	title:'Almacen',
	ActSave:'../../sis_almacenes/control/Almacen/insertarAlmacen',
	ActDel:'../../sis_almacenes/control/Almacen/eliminarAlmacen',
	ActList:'../../sis_almacenes/control/Almacen/listarAlmacen',
	id_store:'id_almacen',
	fields: [
		{name:'id_almacen'},
		{name:'codigo', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'localizacion', type: 'string'},
		{name:'id_almacen_usuario', type: 'numeric'},
		{name:'nombre_completo1', type: 'string'}
	],
	sortInfo:{
		field: 'id_almacen',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	east:{
		  url:'../../../sis_almacenes/vista/almacenStock/AlmacenStock.php',
		  title:'Stock Minimo de almacenes', 
		  width:400,
		  cls:'AlmacenStock'
		 },
		 
    preparaMenu:function(tb){
            //llamada funcion clace padre
            /*
            if(!this.sm.getSelected().data.nombre_completo1){              
                this.getBoton('Almacenero').enable();
            }
            else{                   
                this.getBoton('Almacenero').disable();        
            }*/
            Phx.vista.Almacen.superclass.preparaMenu.call(this,tb);
    }  
}
)
</script>		
		