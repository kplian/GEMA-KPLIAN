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
		this.load({params:{start:0, limit:50}})
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
		{name:'localizacion', type: 'string'}
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
			 }
	}
)
</script>		
		