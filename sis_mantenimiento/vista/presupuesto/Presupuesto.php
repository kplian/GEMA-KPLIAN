<?php
/**
*@package pXP
*@file gen-Presupuesto.php
*@author  (admin)
*@date 12-06-2013 08:25:14
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Presupuesto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Presupuesto.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}});
		
		this.addButton('btnHabilitarPres',
			{
				text: 'Habilitar Presupuesto',
				iconCls: 'bchecklist',
				disabled: true,
				handler: this.onBtnHabilitarPresup,
				tooltip: '<b>Habilitar Presupuesto</b><br/>Opción para habilitar el presupuesto'
			}
		);
		
		this.addButton('btnPresupRep', {
				text: 'Reporte',
				iconCls: 'bgear',
				disabled: false,
				handler: this.onBtnPresupRep,
				tooltip: '<b>Reporte</b><br/>Reporte de presupueto de los meses registrados'
			});
		
		//Creación ventana para generar el reporte
		this.crearVentanaRep();
	},
	tam_pag:50,
	estado_reg:'',
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_presupuesto'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:30
			},
			type:'TextField',
			filters:{pfiltro:'gepres.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'gepres.nombre',type:'string'},
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
			filters:{pfiltro:'gepres.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config: {
				name: 'gestion',
				fieldLabel: 'Gestión',
				anchor: '50%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'gestion',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__gestion'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['gestion']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'gepres.gestion',type:'numeric'},
			grid: true,
			form: true
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
			filters:{pfiltro:'gepres.fecha_reg',type:'date'},
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
			filters:{pfiltro:'gepres.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Presupuestos',
	ActSave:'../../sis_mantenimiento/control/Presupuesto/insertarPresupuesto',
	ActDel:'../../sis_mantenimiento/control/Presupuesto/eliminarPresupuesto',
	ActList:'../../sis_mantenimiento/control/Presupuesto/listarPresupuesto',
	id_store:'id_presupuesto',
	fields: [
		{name:'id_presupuesto', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'codigo', type: 'string'},
		{name:'gestion', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	east:{
		  url:'../../../sis_mantenimiento/vista/presupuesto_loc/PresupuestoLoc.php',
		  title:'Meses', 
		  width:'35%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'PresupuestoLoc'
	},
	south:{
		  url:'../../../sis_mantenimiento/vista/presupuesto_localizacion/PresupuestoLocalizacion.php',
		  title:'Localizaciones', 
		  height:'50%',	//altura de la ventana hijo
		  //width:'50%',		//ancho de la ventana hjo
		  cls:'PresupuestoLocalizacion'
	},	
	sortInfo:{
		field: 'id_presupuesto',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onBtnHabilitarPresup: function(){
		var rec=this.sm.getSelected();
		if(rec){
			Ext.Msg.confirm('Confirmación','¿Está seguro de Habilitar el Presupuesto seleccionado?',function(btn){
				if(btn=='yes'){
					Ext.Ajax.request({
						url:'../../sis_mantenimiento/control/PresupuestoLocalizacion/habilitarPresupuesto',
						params:{
							id_presupuesto: rec.data.id_presupuesto,
							estado_reg: this.estado_reg
						},
						success:function(){
							this.reload();
						},
						failure: this.conexionFailure,
						timeout: this.timeout,
						scope:this
					});
				}
			}, this)
		} else{
			Ext.Msg.alert('Alerta','Seleccione un registro y vuelva a intentarlo');
		}
		
	},
	preparaMenu: function(n) {
		var tb = Phx.vista.Presupuesto.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	var btn = this.getBoton('btnHabilitarPres');
	  	if(data.estado_reg=='activo'){
	  		btn.enable();
	  		btn.setText('Habilitar Formulación');	
	  		btn.setTooltip('<b>Habilitar Formulación</b><br/>Opción para habilitar el presupuesto para su Formulación');
	  		this.estado_reg = 'formular'
	  	} else if(data.estado_reg=='formular'){
	  		btn.enable();
	  		btn.setText('Habilitar Ejecución');
	  		btn.setTooltip('<b>Habilitar Ejecución</b><br/>Opción para habilitar el presupuesto para su Ejecución');
	  		this.estado_reg = 'ejecucion'
	  	} else if(data.estado_reg=='ejecucion'){
	  		btn.disable();
	  		this.estado_reg = 'ejecucion'
	  	} else{
	  		btn.disable();
	  		btn.setText('Habilitar Presupuesto');	
	  		btn.setTooltip('<b>Habilitar Presupuesto</b><br/>Opción para habilitar el presupuesto');
	  		this.estado_reg = ''
	  	}
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.Presupuesto.superclass.liberaMenu.call(this);
		this.getBoton('btnHabilitarPres').disable();
		return tb;
	},
	crearVentanaRep: function() {
			this.formRep = new Ext.form.FormPanel({
				//baseCls: 'x-plain',
				bodyStyle: 'padding:10 20px 10;',
				autoDestroy: true,
				border: false,
				layout: 'form',
				autoScroll: true,
				defaults: {
					xtype: 'textfield'
				},

				items: [
				{
					xtype: 'combo',
					name: 'mes_ini',
					fieldLabel: 'Desde',
					allowBlank: false,
					store:[1,2,3,4,5,6,7,8,9,10,11,12],
					mode: 'local',
			        triggerAction: 'all',
			        emptyText:'Desde..',
			        selectOnFocus:true,
			        width:100
				},
				{
					xtype: 'combo',
					name: 'mes_fin',
					fieldLabel: 'Hasta',
					allowBlank: false,
					store:[1,2,3,4,5,6,7,8,9,10,11,12],
					mode: 'local',
			        triggerAction: 'all',
			        emptyText:'Hasta..',
			        selectOnFocus:true,
			        width:100
				}]
			});

			//var dateFechaIni =this.formUCCL.getForm().findField('fecha_ini');
			var mesIni = this.formRep.getForm().findField('mes_ini');
			var mesFin = this.formRep.getForm().findField('mes_fin');

			this.winRep = new Ext.Window({
				title: 'Reporte',
				collapsible: true,
				maximizable: true,
				autoDestroy: true,
				width: 280,
				height: 130,
				layout: 'fit',
				//plain: true,
				//bodyStyle: 'padding:5px;',
				buttonAlign: 'center',
				items: this.formRep,
				modal: true,
				closeAction: 'hide',
				buttons: [{
					text: 'Guardar',
					handler: this.onPresupRep,
					scope: this

				}, {
					text: 'Cancelar',
					handler: function() {
						this.winRep.hide()
					},
					scope: this
				}]
			});
		},
	onPresupRep: function(){
		//Verificación de parámetros
		var mesIni = this.formRep.getForm().findField('mes_ini');
		var mesFin = this.formRep.getForm().findField('mes_fin');
		if(this.formRep.getForm().isValid()){
			if(mesIni.getValue()>mesFin.getValue()){
				Ext.Msg.alert('Mensaje','El Mes de incio debe ser menor o igual al Mes de finalización');
			} else{
				//Generar reporte
				this.winRep.hide();
				var rec = this.sm.getSelected();
				var parametros = {
					id_presupuesto: rec.data.id_presupuesto,
					mes_ini: mesIni.getValue(),
					mes_fin: mesFin.getValue()
				};

				Phx.CP.loadWindows('../../../sis_mantenimiento/vista/presupuesto/PresupuestoRep.php', 'Reporte', {
					width: '95%',
					height: '85%'
				}, parametros, this.idContenedor, 'PresupuestoRep')
			}
		}
	},
	onBtnPresupRep: function() {
		var data = this.sm.getSelected();
		this.formRep.form.reset()
		if (data) {
			this.winRep.show()
		}
	}
})
</script>
		
		