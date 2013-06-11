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
Phx.vista.RegistrarOT = {
	require:'../../../sis_mantenimiento/vista/orden_trabajo/OrdenTrabajo.php',
	requireclase:'Phx.vista.OrdenTrabajo',
	title:'Registrar Orden Trabajo',
	nombreVista: 'registrarOT',
	bdel: true,
	bedit: true,
	bnew: true,
	constructor: function(config) {
		Phx.vista.RegistrarOT.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, 'nombreVista': this.nombreVista}});
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
		this.addButton('btnCheck',
			{
				text: 'Emitir',
				iconCls: 'bok',
				disabled: true,
				handler: checkOT,
				tooltip: '<b>Establece una OT en modo Pendiente para su ejecución.</b>'
			}
		);
		this.addButton('btnUncheck',
			{
				text: 'Corregir',
				iconCls: 'bundo',
				disabled: true,
				handler: uncheckOT,
				tooltip: '<b>Establece una OT en modo Borrador para poder ser modificada nuevamente.</b>'
			}
		);
		
		function checkOT() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación',
				'¿Está seguro de Emitir esta Orden de Trabajo?', 
				function(btn) {
					if (btn == "yes") {
						Ext.Ajax.request({
							url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
							params: {
								'id_orden_trabajo': data.id_orden_trabajo, 
								'cat_estado_anterior': data.cat_estado,
								'cat_estado': 'Pendiente'
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
		
		function uncheckOT() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación',
				'¿Está seguro de habilitar esta Orden de Trabajo para su modificación?', 
				function(btn) {
					if (btn == "yes") {
						Ext.Ajax.request({
							url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
							params: {
								'id_orden_trabajo': data.id_orden_trabajo,
								'cat_estado_anterior': data.cat_estado,
								'cat_estado': 'Borrador'
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
	preparaMenu: function(n) {
		var tb = Phx.vista.RegistrarOT.superclass.preparaMenu.call(this);
		var data = this.getSelectedData();
		this.getBoton('btnCancelarOT').setDisabled(false);
	  	if(data.cat_estado == 'Borrador'||data.cat_estado=='generado'||data.cat_estado=='Generado') {
	  		this.getBoton('btnCheck').setDisabled(false);
	  		this.getBoton('btnUncheck').setDisabled(true);
	  		this.getBoton('del').setDisabled(false);
	  	} else if(data.cat_estado == 'Pendiente') {
	  		this.getBoton('btnCheck').setDisabled(true);
	  		this.getBoton('btnUncheck').setDisabled(false);
	  		this.getBoton('del').setDisabled(true);
	  	}
	  	//Deshabilitación de botón de recursos
	  	this.getBoton('btnRecursos').setDisabled(true);
	  	//Habilitación de botón de costos
	  	this.getBoton('btnCostoOIT').setDisabled(false);

  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.RegistrarOT.superclass.liberaMenu.call(this);
		this.getBoton('btnCancelarOT').setDisabled(true);
		this.getBoton('btnCheck').setDisabled(true);
	  	this.getBoton('btnUncheck').setDisabled(true);
	  	this.getBoton('btnRecursos').setDisabled(true);
	  	this.getBoton('btnCostoOIT').setDisabled(true);
		return tb;
	},
	handleForm: function(source) {
		if (source == "bnew") {
			this.readOnlyGroup(0, false);
		} else {
			var data = this.getSelectedData();
			if(data.cat_estado == 'Borrador'|| data.cat_estado == 'generado') {
		  		this.readOnlyGroup(0, false);
		  	} else if(data.cat_estado == 'Pendiente') {
		  		this.readOnlyGroup(0, true);
			} 
		}
	},
	onButtonNew: function() {
		Phx.vista.RegistrarOT.superclass.onButtonNew.call(this);
		this.handleForm("bnew");
	},
	onButtonEdit: function() {
		Phx.vista.RegistrarOT.superclass.onButtonEdit.call(this);
		this.handleForm();
	},
	onBtnCancelarOT: function() {
		this.mensajeEstadoForm.getForm().reset();
		this.mensajeEstadoForm.getForm().findField('estado').setValue('Cancelado');
		this.mensajeEstadoFormDialog.show();
	}
};
</script>
