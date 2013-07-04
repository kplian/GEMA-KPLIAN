<?php
/**
*@package pXP
*@file gen-PresupuestoLoc.php
*@author  (admin)
*@date 11-06-2013 19:38:04
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PresupuestoLoc=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PresupuestoLoc.superclass.constructor.call(this,config);
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		this.init();
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_presupuesto_loc'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_presupuesto',
				inputType:'hidden'
			},
			type:'Field',
			id_grupo:1
		},
		{
			config:{	
				name:'id_localizacion',
    			tinit:true,
    			tasignacion:true,
    			tname:'id_localizacion',
    			tdisplayField:'nombre',
    			turl:'../../../sis_mantenimiento/vista/localizacion/LocalizacionLista.php',
	   			ttitle:'Localizaciones',
	   			tdata:{},
	   			tcls:'LocalizacionLista',
	   			pid:this.idContenedor,
	   			fieldLabel:'Localización',
	   			allowBlank:false,
	   			emptyText:'Buscar Equipo po Localización ...',
	   			store:new Ext.data.JsonStore(
				{
					url: '../../sis_mantenimiento/control/Localizacion/listarLocalizacion',
					id: 'id_localizacion',
					root:'datos',
					sortInfo:{
						field:'nombre',
						direction:'ASC'
					},
					totalProperty:'total',
					fields: ['id_localizacion','codigo','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre#codigo'}
				}),
	   			tpl:'<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p></div></tpl>',
				valueField: 'id_localizacion',
				hiddenValue: 'id_localizacion',
				hiddenName:'id_localizacion',
				displayField: 'nombre',
				gdisplayField: 'desc_localizacion',
				forceSelection:true,
				typeAhead: false,
    			triggerAction: 'all',
    			lazyRender:true,
				mode:'remote',
				pageSize:20,
				queryDelay:500,
				anchor: '100%',
				gwidth:220,
				minChars:2,
				renderer:function (value, p, record){return String.format('{0}', record.data['desc_localizacion']);},
				autoSelect:true
    		},
			type:'TrigguerCombo',
			filters:{pfiltro:'gprlo.nombre',type:'string'},
			id_grupo:0,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'mes',
				fieldLabel: 'Mes',
				anchor: '100%',
				tinit: true,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'mes',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__mes'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['mes']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'geprlo.cat_prior',type:'string'},
			grid: true,
			form: true
		},

		{
			config:{
				name: 'monto_prog',
				fieldLabel: 'Prog. Jefes Mantto.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'geprlo.monto_prog',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'monto_techo',
				fieldLabel: 'Techo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'geprlo.monto_techo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'porcen_prog_techo',
				fieldLabel: '% Prog./Techo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'geprlo.porcen_prog_techo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'monto_presup',
				fieldLabel: 'Presup. Mensual',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'geprlo.monto_presup',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'monto_ejec',
				fieldLabel: 'Ejec.Mensual',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'geprlo.monto_ejec',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
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
			filters:{pfiltro:'geprlo.estado_reg',type:'string'},
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
			filters:{pfiltro:'geprlo.fecha_reg',type:'date'},
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
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'geprlo.fecha_mod',type:'date'},
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
	
	title:'Presupuesto Localización',
	ActSave:'../../sis_mantenimiento/control/PresupuestoLoc/insertarPresupuestoLoc',
	ActDel:'../../sis_mantenimiento/control/PresupuestoLoc/eliminarPresupuestoLoc',
	ActList:'../../sis_mantenimiento/control/PresupuestoLoc/listarPresupuestoLoc',
	id_store:'id_presupuesto_loc',
	loadValoresIniciales:function(){
		Phx.vista.PresupuestoLoc.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_presupuesto').setValue(this.maestro.id_presupuesto);		
	},
	tam_pag:30,
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_presupuesto:this.maestro.id_presupuesto};
		this.load({params:{start:0, limit:this.tam_pag}});			
	},
	fields: [
		{name:'id_presupuesto_loc', type: 'numeric'},
		{name:'id_localizacion', type: 'numeric'},
		{name:'mes', type: 'numeric'},
		{name:'id_presupuesto', type: 'numeric'},
		{name:'monto_ejec', type: 'numeric'},
		{name:'porcen_prog_techo', type: 'numeric'},
		{name:'monto_prog', type: 'numeric'},
		{name:'monto_techo', type: 'numeric'},
		{name:'monto_presup', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'nombre_localizacion', type: 'string'},
		{name:'desc_localizacion', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_presupuesto_loc',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true
})
</script>
		
		