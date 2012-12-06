<?php
/**
*@package pXP
*@file gen-LocalizacionUsuario.php
*@author  (admin)
*@date 25-11-2012 04:18:07
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.LocalizacionUsuario=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
    	//llama al constructor de la clase padre
		Phx.vista.LocalizacionUsuario.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, id_localizacion:this.maestro.id_localizacion}});
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_localizacion_usuario'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'id_usuario',
				fieldLabel: 'Usuario',
				anchor: '90%',
				tinit: true,
				allowBlank: false,
				origen: 'USUARIO',
				gdisplayField: 'desc_persona',
				gwidth: 200,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_persona']);
				}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters: {
				pfiltro: 'nombre_completo1#nombre_completo2',
				type: 'string'
			},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'tipo',
				fieldLabel: 'Responsabilidad',
				anchor: '90%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'descripcion',
				gwidth: 200,
				baseParams:{
						cod_subsistema:'GEM',
						catalogo_tipo:'tlocalizacion_usuario'
					}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'locosu.tipo',type:'string'},
			grid: true,
			form: true
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
			filters:{pfiltro:'locusu.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_localizacion'
			},
			type:'Field',
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
			filters:{pfiltro:'locusu.fecha_reg',type:'date'},
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
			filters:{pfiltro:'locusu.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	title:'Localización - Usuario',
	ActSave:'../../sis_mantenimiento/control/LocalizacionUsuario/insertarLocalizacionUsuario',
	ActDel:'../../sis_mantenimiento/control/LocalizacionUsuario/eliminarLocalizacionUsuario',
	ActList:'../../sis_mantenimiento/control/LocalizacionUsuario/listarLocalizacionUsuario',
	id_store:'id_localizacion_usuario',
	fields: [
		{name:'id_localizacion_usuario', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'tipo', type: 'string'},
		{name:'id_localizacion', type: 'numeric'},
		{name:'id_usuario', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date', dateFormat:'Y-m-d H:i:s'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_persona', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_localizacion_usuario',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function(){
		Phx.vista.LocalizacionUsuario.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_localizacion').setValue(this.maestro.id_localizacion);
	},	
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_localizacion:this.maestro.id_localizacion};
		this.load({params:{start:0, limit:50}});			
	}

})
</script>
		
		