<?php
/**
*@package pXP
*@file gen-PresupuestoLocalizacion.php
*@author  (admin)
*@date 02-07-2013 00:18:34
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PresupuestoLocalizacion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PresupuestoLocalizacion.superclass.constructor.call(this,config);
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		this.init();
		
		this.addButton('btnUsuarios',
			{
				text: 'Usuarios autorizados',
				iconCls: 'bchecklist',
				disabled: true,
				handler: this.onBtnUsuarios,
				tooltip: '<b>Usuarios autorizados</b><br/>Habilitación de usuarios autorizados para registro de Presupuesto'
			}
		);
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_presupuesto_localizacion'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'id_presupuesto',
				fieldLabel: 'id_presupuesto',
				allowBlank: true,
				inputType:'hidden',
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			id_grupo:1,
			grid:false,
			form:true
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
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'gprelo.estado_reg',type:'string'},
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
			filters:{pfiltro:'gprelo.fecha_reg',type:'date'},
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
			filters:{pfiltro:'gprelo.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Presupuesto Localización',
	ActSave:'../../sis_mantenimiento/control/PresupuestoLocalizacion/insertarPresupuestoLocalizacion',
	ActDel:'../../sis_mantenimiento/control/PresupuestoLocalizacion/eliminarPresupuestoLocalizacion',
	ActList:'../../sis_mantenimiento/control/PresupuestoLocalizacion/listarPresupuestoLocalizacion',
	id_store:'id_presupuesto_localizacion',
	loadValoresIniciales:function(){
		Phx.vista.PresupuestoLocalizacion.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_presupuesto').setValue(this.maestro.id_presupuesto);		
	},
	tam_pag:30,
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_presupuesto:this.maestro.id_presupuesto};
		this.load({params:{start:0, limit:this.tam_pag}});			
	},
	fields: [
		{name:'id_presupuesto_localizacion', type: 'numeric'},
		{name:'id_presupuesto', type: 'numeric'},
		{name:'id_localizacion', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_localizacion', type: 'string'}		
	],
	sortInfo:{
		field: 'id_presupuesto_localizacion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onBtnUsuarios: function(){
		var rec=this.sm.getSelected();
		console.log(rec.data)
		Phx.CP.loadWindows('../../../sis_mantenimiento/vista/presupuesto_localizacion_usuario/PresupuestoLocalizacionUsuario.php',
				'Usuarios',
				{
					width:'70%',
					height:'80%'
			    },
			    rec.data,
			    this.idContenedor,
			    'PresupuestoLocalizacionUsuario'
		);
	}
})
</script>
		
		