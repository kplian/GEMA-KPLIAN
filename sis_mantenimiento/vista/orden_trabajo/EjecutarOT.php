<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.EjecutarOT = {
	require:'../../../sis_mantenimiento/vista/orden_trabajo/OrdenTrabajo.php',
	requireclase:'Phx.vista.OrdenTrabajo',
	nombreVista:'ejecutarOT',
	title:'Registrar Orden Trabajo',
	swCerrar:false,
	bedit: true,
	constructor: function(config) {
		Phx.vista.EjecutarOT.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, 'nombreVista': this.nombreVista}});
		this.readOnlyGroup(0, true);
		this.blockGroup(1);
		
		this.addButton('btnCancelarOT',
			{
				text: '',
				iconCls: 'bcancelfile',
				disabled: true,
				handler: this.onBtnCancelarOT,
				tooltip: '<b>Cancelar Orden de Trabajo</b><br/>Cancela la orden de trabajo actual.'
			}
		);
		
		this.addButton('btnAbrir', 
			{
				text: 'Abrir',
				iconCls: 'bunlock',
				disabled: true,
				handler: openOT,
				tooltip: '<b>Abre la Orden de Trabajo para su ejecución</b>'
			}
		);
		this.addButton('btnCerrar',
			{
				text: 'Cerrar',
				iconCls: 'block',
				disabled: true,
				handler: btncloseOT,
				tooltip: '<b>Cierra la Orden de Trabajo para su revisión</b>'
			}
		);
		this.addButton('btnEjecucionPendienteOT', 
			{
				text: '',
				iconCls: 'bpause',
				disabled: true,
				handler: this.onBtnEjecucionPendienteOT,
				tooltip: '<b>Pausar Ejecución</b>'
			}
		);
		
		function openOT() {
			var rec=this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación',
				'¿Está seguro de Abrir esta Orden de Trabajo?', 
				function(btn) {
					if (btn == "yes") {
						Ext.Ajax.request({
							url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
							params: {
								'id_orden_trabajo': data.id_orden_trabajo,
								'cat_estado_anterior': data.cat_estado,
								'cat_estado': 'Abierto'
							},
							success: global.successSave,
							failure: global.conexionFailure,
							timeout: global.timeout,
							scope: global
						});
					}
				}
			);
		}
		
		function btncloseOT(){
			/*var rec=this.sm.getSelected();
			var data = rec.data;
			if(rec){
				this.wUC.show()	
			}*/
			//Enciende la bandera de cierre de la OT
			this.swCerrar=true;
			this.getComponente('descripcion_causa').allowBlank=false;
			this.getComponente('comentarios').allowBlank=false;
			this.getComponente('prevension').allowBlank=false;
			this.getComponente('accidentes').allowBlank=false;
			this.getComponente('reclamos').allowBlank=false;
			this.getComponente('fecha_eje_ini').allowBlank=false;
			this.getComponente('fecha_eje_fin').allowBlank=false;
			
			this.onButtonEdit();
		}
		
		function closeOT() {
			var rec=this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Phx.CP.loadingHide();
			/*Ext.Msg.confirm('Confirmación',
				'¿Está seguro de dar por finalizada la ejecución a esta Orden de Trabajo?', 
				function(btn) {
					if (btn == "yes") {*/
						Ext.Ajax.request({
							url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
							params: {
								'id_orden_trabajo': data.id_orden_trabajo,
								'cat_estado_anterior': data.cat_estado,
								'cat_estado': 'Cerrado'
							},
							success: global.successSave,
							failure: global.conexionFailure,
							timeout: global.timeout,
							scope: global
						});
					/*}
				}
			);*/
		}
		
		this.crearVentanaCerrar();
	},
	preparaMenu:function(n) {
	  	var tb = Phx.vista.EjecutarOT.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	this.getBoton('btnCancelarOT').setDisabled(false);
	  	if(data.cat_estado == 'Pendiente') {
	  		this.getBoton('btnEjecucionPendienteOT').setDisabled(true);
	  		this.getBoton('btnAbrir').setDisabled(false);
	  		this.getBoton('btnCerrar').setDisabled(true);
	  		this.getBoton('btnRecursos').setDisabled(true);
	  		
	  	} else if(data.cat_estado == 'Abierto') {
	  		this.getBoton('btnEjecucionPendienteOT').setDisabled(false);
	  		this.getBoton('btnEjecucionPendienteOT').setIconClass('bpause');
	  		this.getBoton('btnEjecucionPendienteOT').setTooltip('<b>Pausar Ejecución</b>');
	  		this.getBoton('btnAbrir').setDisabled(true);
	  		this.getBoton('btnCerrar').setDisabled(false);
	  		this.getBoton('btnRecursos').setDisabled(false);
	  	} else if(data.cat_estado == 'EjecucionPendiente') {
	  		this.getBoton('btnEjecucionPendienteOT').setDisabled(false);
	  		this.getBoton('btnEjecucionPendienteOT').setIconClass('bplay');
	  		this.getBoton('btnEjecucionPendienteOT').setTooltip('<b>Reanudar Ejecución</b>');
	  		this.getBoton('btnAbrir').setDisabled(true);
	  		this.getBoton('btnCerrar').setDisabled(false);
	  	}
	  	//Habilitación de botón de costos
	  	this.getBoton('btnCostoOIT').setDisabled(false);
  		return tb;
	},
	liberaMenu:function() {
		var tb = Phx.vista.EjecutarOT.superclass.liberaMenu.call(this);
		this.getBoton('btnEjecucionPendienteOT').setDisabled(true);
		this.getBoton('btnCancelarOT').setDisabled(true);
		this.getBoton('btnAbrir').setDisabled(true);
	  	this.getBoton('btnCerrar').setDisabled(true);
	  	this.getBoton('btnRecursos').setDisabled(true);
	  	this.getBoton('btnCostoOIT').setDisabled(true);
		return tb;
	},
	handleForm: function() {
		var data = this.getSelectedData();
		if(data.cat_estado == 'Pendiente' || data.cat_estado == 'EjecucionPendiente') {
	  		this.blockGroup(1);
	  	} else if(data.cat_estado == 'Abierto') {
	  		this.unblockGroup(1);
		}
	},
	onButtonEdit: function() {
		Phx.vista.EjecutarOT.superclass.onButtonEdit.call(this);
		this.handleForm();
	},
	onBtnCancelarOT: function() {
		this.mensajeEstadoForm.getForm().reset();
		this.mensajeEstadoForm.getForm().findField('estado').setValue('Cancelado');
		this.mensajeEstadoFormDialog.show();
	},
	onBtnEjecucionPendienteOT: function() {
		this.mensajeEstadoForm.getForm().reset();
		var data = this.getSelectedData();
		if(data.cat_estado == "EjecucionPendiente") {
			this.mensajeEstadoForm.getForm().findField('estado').setValue('Abierto');
		} else {
			this.mensajeEstadoForm.getForm().findField('estado').setValue('EjecucionPendiente');
		}
		this.mensajeEstadoFormDialog.show();
	},
	crearVentanaCerrar: function() {
			this.formUC = new Ext.form.FormPanel({
				baseCls: 'x-plain-' + this.idContenedor,
				bodyStyle: 'padding:10 20px 10;',
				autoDestroy: true,
				border: false,
				layout: 'form',
				items: [{
						xtype: 'textarea',
						name: 'descripcion_causa',
						fieldLabel: 'Descripción Causa',
						allowBlank: false,
						width:'100%'
					},
					{
						xtype: 'textarea',
						name: 'comentarios',
						fieldLabel: 'Acción Realizada',
						allowBlank: false,
						width:'100%'
					},
					{
						xtype: 'textarea',
						name: 'prevension',
						fieldLabel: 'Prevensión Tomada',
						allowBlank: false,
						width:'100%'
					},
					{
						xtype: 'textarea',
						name: 'accidentes',
						fieldLabel: 'Accidentes',
						allowBlank: false,
						width:'100%'
					},
					{
						xtype: 'textarea',
						name: 'reclamos',
						fieldLabel: 'Reclamos',
						allowBlank: false,
						width:'100%'
					}
				]
			});

			var desc_causa = this.formUC.getForm().findField('descripcion_causa');
			var comentarios = this.formUC.getForm().findField('comentarios');
			var prevension = this.formUC.getForm().findField('prevension');
			var accidentes = this.formUC.getForm().findField('accidentes');
			var reclamos = this.formUC.getForm().findField('reclamos');

			this.wUC = new Ext.Window({
				title: 'Cerrar Orden de Trabajo',
				collapsible: true,
				maximizable: true,
				autoDestroy: true,
				width: 450,
				height: 400,
				layout: 'fit',
				plain: true,
				bodyStyle: 'padding:5px;',
				buttonAlign: 'center',
				items: this.formUC,
				modal: true,
				closeAction: 'hide',
				buttons: [{
					text: 'Guardar',
					handler: this.onCerrarOIT,
					scope: this

				}, {
					text: 'Cancelar',
					handler: function() {
						this.wUC.hide()
					},
					scope: this
				}]
			});
		},
		onCerrarOIT: function() {
			if (this.formUC.getForm().isValid()) {
				var global = this;
				Ext.Msg.confirm('Confirmación',
				'¿Está seguro de cerrar la Orden de Trabajo?', 
				function(btn) {
					if (btn == "yes") {
						Phx.CP.loadingShow();
						var rec=global.sm.getSelected();
						var desc_causa = global.formUC.getForm().findField('descripcion_causa');
						var comentarios = global.formUC.getForm().findField('comentarios');
						var prevension = global.formUC.getForm().findField('prevension');
						var accidentes = global.formUC.getForm().findField('accidentes');
						var reclamos = global.formUC.getForm().findField('reclamos');
		
						Ext.Ajax.request({
							url: '../../sis_mantenimiento/control/OrdenTrabajo/precerrarOIT',
							params: {
								descripcion_causa: desc_causa.getValue(),
								comentarios: comentarios.getValue(),
								prevension: prevension.getValue(),
								accidentes: accidentes.getValue(),
								reclamos: reclamos.getValue(),
								id_orden_trabajo: rec.data.id_orden_trabajo
							},
							//success: global.closeOT,
							success: function(){
								global.wUC.hide();
								Ext.Ajax.request({
									url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
									params: {
										'id_orden_trabajo': rec.data.id_orden_trabajo,
										'cat_estado_anterior': rec.data.cat_estado,
										'cat_estado': 'Cerrado'
									},
									success: global.successSave,
									failure: global.conexionFailure,
									timeout: global.timeout,
									scope: global
								});
							},
							failure: global.conexionFailure,
							timeout: global.timeout,
							scope: global
						});
					}
				})
			}	
		},
		successCerrarOIT: function(resp) {
			Phx.CP.loadingHide();
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if (reg.ROOT.error) {
				alert("ERROR no esperado")
			} else {
				this.wUC.hide();
				this.reload();
			}
		},
		successSave: function(resp) {
			Phx.vista.EjecutarOT.superclass.successSave.call(this,resp);
			//Llamada para cerrar la OT
			if(this.swCerrar){
				this.swCerrar=false;
				Phx.CP.loadingShow();
				var rec=this.sm.getSelected();
				Ext.Ajax.request({
					url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
					params: {
						'id_orden_trabajo': rec.data.id_orden_trabajo,
						'cat_estado_anterior': rec.data.cat_estado,
						'cat_estado': 'Cerrado',
						fecha_eje_ini:this.getComponente('fecha_eje_ini').getValue(),
						fecha_eje_fin:this.getComponente('fecha_eje_fin').getValue()
					},
					success: function(){
						Phx.CP.loadingHide();
						this.reload();
					},
					failure: this.conexionFailure,
					timeout: this.timeout,
					scope: this
				});
			}
		} 
};
</script>
