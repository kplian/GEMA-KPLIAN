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
		    text:'Almacenero',
		    iconCls:'bassign',
		    disabled:true,
		    handler:this.onAlmacenUsuario,
		    tooltip:'<b>Registrar Almacenero'});
	},
	onAlmacenUsuario : function (){                   
            var rec=this.sm.getSelected();
                        
            Phx.CP.loadWindows('../../../sis_almacenes/vista/almacenUsuario/AlmacenUsuario.php',
            'Registrar Almacenero',
            {
                modal:true,
                width:600,
                height:300
            },rec.data,this.idContenedor,'AlmacenUsuario')
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
                name: 'nombre_completo1',
                fieldLabel: 'Almacenero',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:50
            },
            type:'TextField',
            filters:{type:'string'},
            id_grupo:1,
            grid:true,
            form:false
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
            if(!this.sm.getSelected().data.nombre_completo1){              
                this.getBoton('Almacenero').enable();
            }
            else{                   
                this.getBoton('Almacenero').disable();        
            }
            Phx.vista.Almacen.superclass.preparaMenu.call(this,tb);
        },
        
    south:{
          url:'../../../sis_almacenes/vista/almacenUsuario/AlmacenUsuario.php',
          title:'Almaceneros', 
          height:300,
          cls:'AlmacenUsuario'
    }    
}
)
</script>		
		