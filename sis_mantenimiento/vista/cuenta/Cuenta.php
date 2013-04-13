<?php
/**
*@package pXP
*@file Cuenta.php
*@author  RCM
*@date 14-04-2013
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Cuenta=Ext.extend(Phx.arbInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Cuenta.superclass.constructor.call(this,config);
		this.init();
		this.iniciarEventos();
	
	},
		
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_cuenta'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_cuenta_padre',
				inputType:'hidden'
			},
			type:'Field',
			form:true
		},
		{
			config:{
				name: 'nro_cuenta',
				fieldLabel: 'Nro Cuenta',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'nombre_cuenta',
				fieldLabel: 'Nombre Cuenta',
				allowBlank: false,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			id_grupo:1,
			grid:true,
			form:true
		}
	],
	
	title:'Cuenta',
	ActSave:'../../sis_mantenimiento/control/Cuenta/insertarCuenta',
	ActDel:'../../sis_mantenimiento/control/Cuenta/eliminarCuenta',
	ActList:'../../sis_mantenimiento/control/Cuenta/listarCuentaArb',
	id_store:'id_cuenta',
	
	textRoot:'Plan de Cuentas',
 	id_nodo:'id_cuenta',
 	id_nodo_p:'id_cuenta_padre',
	
	fields: [
		{name:'id_cuenta', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre_cuenta', type: 'string'},
		{name:'id_cuenta_padre', type: 'numeric'},
		{name:'nro_cuenta', type: 'string'}
	],
	
	sortInfo:{
		field: 'id_cuenta',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	rootVisible:true,
	expanded:false/*,
	
	
    getTipoCuentaPadre: function(n) {
			var direc
			var padre = n.parentNode;
            if (padre) {
				if (padre.attributes.id != 'id') {
					return this.getTipoCuentaPadre(padre);
				} else {
					return n.attributes.tipo_cuenta;
				}
			} else {
				return undefined;
			}
		},
    loadValoresIniciales:function()
	{
		Phx.vista.Cuenta.superclass.loadValoresIniciales.call(this);
	},
    iniciarEventos:function(){
    	
	}*/
})
</script>