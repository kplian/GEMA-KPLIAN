<?php
/**
*@package pXP
*@file gen-PresupuestoLocalizacionUsuario.php
*@author  (admin)
*@date 02-07-2013 04:45:06
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PresupuestoLocalizacionUsuario=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
    	//llama al constructor de la clase padre
		Phx.vista.PresupuestoLocalizacionUsuario.superclass.constructor.call(this,config);
		this.init();
		this.Atributos[1].valorInicial=this.maestro.id_presupuesto_localizacion;
		this.load({params:{start:0, limit:this.tam_pag,
			id_presupuesto_localizacion:this.id_presupuesto_localizacion}})
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_presupuesto_localizacion_usuario'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_presupuesto_localizacion',
				fieldLabel: 'id_presupuesto_localizacion',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4,
				inputType:'hidden'
			},
			type:'NumberField',
			filters:{pfiltro:'gpreus.id_presupuesto_localizacion',type:'numeric'},
			id_grupo:1,
			grid:false,
			form:true
		},
		{
			config: {
				name: 'id_usuario',
				fieldLabel: 'Usuario',
				anchor: '100%',
				tinit: false,
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
				pfiltro: 'usu3.desc_persona',
				type: 'string'
			},
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
			filters:{pfiltro:'gpreus.estado_reg',type:'string'},
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
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'gpreus.fecha_reg',type:'date'},
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
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'gpreus.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Presupuesto Localización Usuario',
	ActSave:'../../sis_mantenimiento/control/PresupuestoLocalizacionUsuario/insertarPresupuestoLocalizacionUsuario',
	ActDel:'../../sis_mantenimiento/control/PresupuestoLocalizacionUsuario/eliminarPresupuestoLocalizacionUsuario',
	ActList:'../../sis_mantenimiento/control/PresupuestoLocalizacionUsuario/listarPresupuestoLocalizacionUsuario',
	id_store:'id_presupuesto_localizacion_usuario',
	fields: [
		{name:'id_presupuesto_localizacion_usuario', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_presupuesto_localizacion', type: 'numeric'},
		{name:'id_usuario', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_persona', type: 'string'}
	],
	sortInfo:{
		field: 'id_presupuesto_localizacion_usuario',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onReloadPage:function(m) {
		this.maestro=m;
		this.Atributos[1].valorInicial=this.maestro.id_presupuesto_localizacion;	
		this.load({params:{start:0, limit:50,
			id_presupuesto_localizacion:this.maestro.id_presupuesto_localizacion}
		})
	},
})
</script>
		
		