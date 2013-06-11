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
Phx.vista.RevisarOT = {
	require:'../../../sis_mantenimiento/vista/orden_trabajo/OrdenTrabajo.php',
	requireclase:'Phx.vista.OrdenTrabajo',
	nombreVista:'revisarOT',
	title:'Revisión de Orden Trabajo',
	bedit: true,
	constructor: function(config) {
		Phx.vista.RevisarOT.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, 'nombreVista': this.nombreVista}});
		this.readOnlyGroup(0, true);
		this.readOnlyGroup(1, true);
		
		this.addButton('btnCancelarOT',
			{
				text: '',
				iconCls: 'bcancelfile',
				disabled: true,
				handler: this.onBtnCancelarOT,
				tooltip: '<b>Cancelar Orden de Trabajo</b><br/>Cancela la orden de trabajo actual.'
			}
		);
		
		this.addButton('btnReabrir', 
			{
				text: 'Re Abrir',
				iconCls: 'bselect',
				disabled: true,
				handler: openOT,
				tooltip: '<b>Abre la Orden de Trabajo nuevamente para su corrección</b>'
			}
		);
		this.addButton('btnFinalizar', 
			{
				text: 'Finalizar',
				iconCls: 'bend',
				disabled: true,
				handler: reviewOT,
				tooltip: '<b>Marca una Orden de Trabajo como revisada.</b>'
			}
		);
		function openOT() {
			var rec=this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación',
				'¿Está seguro de reabrir la Orden de Trabajo para su corrección?', 
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
		function reviewOT() {
			var rec=this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación',
				'¿Está seguro de dar por finalizada la revisión de esta Orden de Trabajo?', 
				function(btn) {
					if (btn == "yes") {
						Ext.Ajax.request({
							url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
							params: {
								'id_orden_trabajo': data.id_orden_trabajo,
								'cat_estado_anterior': data.cat_estado,
								'cat_estado': 'Revisado'
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
		var tb = Phx.vista.RevisarOT.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	this.getBoton('btnCancelarOT').setDisabled(false);
	  	if(data.cat_estado == 'Cerrado') {
	  		this.getBoton('btnFinalizar').setDisabled(false);
	  		this.getBoton('btnReabrir').setDisabled(false);
	  		this.getBoton('btnRecursos').setDisabled(false);
	  	} else if(data.cat_estado == 'Revisado') {
	  		this.getBoton('btnFinalizar').setDisabled(true);
	  		this.getBoton('btnReabrir').setDisabled(true);
	  		this.getBoton('btnRecursos').setDisabled(false);
	  	}
	  	//Habilitación de botón de costos
	  	this.getBoton('btnCostoOIT').setDisabled(false);
  		return tb;
	},
	liberaMenu:function() {
		var tb = Phx.vista.RevisarOT.superclass.liberaMenu.call(this);
		this.getBoton('btnCancelarOT').setDisabled(true);
		this.getBoton('btnFinalizar').setDisabled(true);
	  	this.getBoton('btnReabrir').setDisabled(true);
	  	this.getBoton('btnRecursos').setDisabled(true);
	  	this.getBoton('btnCostoOIT').setDisabled(true);
		return tb;
	},
	onBtnCancelarOT: function() {
		this.mensajeEstadoForm.getForm().reset();
		this.mensajeEstadoForm.getForm().findField('estado').setValue('Cancelado');
		this.mensajeEstadoFormDialog.show();
	}
};
</script>
