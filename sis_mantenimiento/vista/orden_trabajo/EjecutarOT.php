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
				handler: closeOT,
				tooltip: '<b>Cierra la Orde de Trabajo para su revisión</b>'
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
				'¿Está seguro de iniciar la ejecución de esta Orden de Trabajo?', 
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
		
		function closeOT() {
			var rec=this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación',
				'¿Está seguro de dar por finalizada la ejecución a esta Orden de Trabajo?', 
				function(btn) {
					if (btn == "yes") {
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
					}
				}
			);
		}
	},
	preparaMenu:function(n) {
	  	var tb = Phx.vista.EjecutarOT.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	this.getBoton('btnCancelarOT').setDisabled(false);
	  	if(data.cat_estado == 'Pendiente') {
	  		this.getBoton('btnEjecucionPendienteOT').setDisabled(true);
	  		this.getBoton('btnAbrir').setDisabled(false);
	  		this.getBoton('btnCerrar').setDisabled(true);
	  		
	  	} else if(data.cat_estado == 'Abierto') {
	  		this.getBoton('btnEjecucionPendienteOT').setDisabled(false);
	  		this.getBoton('btnEjecucionPendienteOT').setIconClass('bpause');
	  		this.getBoton('btnEjecucionPendienteOT').setTooltip('<b>Pausar Ejecución</b>');
	  		this.getBoton('btnAbrir').setDisabled(true);
	  		this.getBoton('btnCerrar').setDisabled(false);
	  	} else if(data.cat_estado == 'EjecucionPendiente') {
	  		this.getBoton('btnEjecucionPendienteOT').setDisabled(false);
	  		this.getBoton('btnEjecucionPendienteOT').setIconClass('bplay');
	  		this.getBoton('btnEjecucionPendienteOT').setTooltip('<b>Reanudar Ejecución</b>');
	  		this.getBoton('btnAbrir').setDisabled(true);
	  		this.getBoton('btnCerrar').setDisabled(false);
	  	}
  		return tb;
	},
	liberaMenu:function() {
		var tb = Phx.vista.EjecutarOT.superclass.liberaMenu.call(this);
		this.getBoton('btnEjecucionPendienteOT').setDisabled(true);
		this.getBoton('btnCancelarOT').setDisabled(true);
		this.getBoton('btnAbrir').setDisabled(true);
	  	this.getBoton('btnCerrar').setDisabled(true);
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
		Phx.vista.RegistrarOT.superclass.onButtonEdit.call(this);
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
};
</script>
