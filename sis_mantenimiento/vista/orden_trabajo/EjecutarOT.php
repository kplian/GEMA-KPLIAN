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
		
		function openOT() {
			var rec=this.sm.getSelected();
			var data = rec.data;
			Ext.Ajax.request({
				url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
				params: {
					'id_orden_trabajo': data.id_orden_trabajo,
					'cat_estado_anterior': data.cat_estado,
					'cat_estado': 'Abierto'
				},
				success:this.successSave,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
		}
		
		function closeOT() {
			var rec=this.sm.getSelected();
			var data = rec.data;
			Ext.Ajax.request({
				url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
				params: {
					'id_orden_trabajo': data.id_orden_trabajo,
					'cat_estado_anterior': data.cat_estado,
					'cat_estado': 'Cerrado'
				},
				success:this.successSave,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
		}
	},
	preparaMenu:function(n) {
	  	var tb = Phx.vista.EjecutarOT.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	
	  	if(data.cat_estado == 'Pendiente') {
	  		this.getBoton('btnAbrir').setDisabled(false);
	  		this.getBoton('btnCerrar').setDisabled(true);
	  		
	  	} else if(data.cat_estado == 'Abierto') {
	  		this.getBoton('btnAbrir').setDisabled(true);
	  		this.getBoton('btnCerrar').setDisabled(false);
	  	}
  		return tb;
	},
	liberaMenu:function() {
		var tb = Phx.vista.EjecutarOT.superclass.liberaMenu.call(this);
		this.getBoton('btnAbrir').setDisabled(true);
	  	this.getBoton('btnCerrar').setDisabled(true);
		return tb;
	},
	handleForm: function() {
		var data = this.getSelectedData();
		if(data.cat_estado == 'Pendiente') {
	  		this.blockGroup(1);
	  	} else if(data.cat_estado == 'Abierto') {
	  		this.unblockGroup(1);
		}
	},
	onButtonEdit: function() {
		Phx.vista.RegistrarOT.superclass.onButtonEdit.call(this);
		this.handleForm();
	}
};
</script>
