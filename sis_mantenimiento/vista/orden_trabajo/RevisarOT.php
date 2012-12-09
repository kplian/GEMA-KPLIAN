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
	constructor: function(config) {
		Phx.vista.RevisarOT.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, 'nombreVista': this.nombreVista}});
		this.addButton('btnReabrir', 
			{
				text: 'Re Abrir',
				iconCls: 'blist',
				disabled: true,
				handler: openOT,
				tooltip: '<b>Abre la Orden de Trabajo nuevamente para su corrección</b>'
			}
		);
		this.addButton('btnFinalizar', 
			{
				text: 'Finalizar',
				iconCls: 'blist',
				disabled: true,
				handler: reviewOT,
				tooltip: '<b>Marca una Orden de Trabajo como revisada.</b>'
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
		function reviewOT() {
			var rec=this.sm.getSelected();
			var data = rec.data;
			Ext.Ajax.request({
				url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
				params: {
					'id_orden_trabajo': data.id_orden_trabajo,
					'cat_estado_anterior': data.cat_estado,
					'cat_estado': 'Revisado'
				},
				success:this.successSave,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
		}
	},
	preparaMenu:function(n) {
		var tb = Phx.vista.RevisarOT.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	this.getBoton('btnActividad').setDisabled(false);
	  	if(data.cat_estado == 'Cerrado') {
	  		this.getBoton('btnFinalizar').setDisabled(false);
	  		this.getBoton('btnReabrir').setDisabled(false);
	  	} else if(data.cat_estado == 'Revisado') {
	  		this.getBoton('btnFinalizar').setDisabled(true);
	  		this.getBoton('btnReabrir').setDisabled(true);
	  	}
  		return tb;
	},
	liberaMenu:function() {
		var tb = Phx.vista.RevisarOT.superclass.liberaMenu.call(this);
		this.getBoton('btnFinalizar').setDisabled(true);
	  	this.getBoton('btnReabrir').setDisabled(true);
	  	this.getBoton('btnActividad').setDisabled(true);
		return tb;
	}
};
</script>
