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
		this.addButton('btnCheck',
			{
				text: 'Check',
				iconCls: 'blist',
				disabled: true,
				handler: checkOT,
				tooltip: '<b>Establece una OT en modo Pendiente para su ejecución.</b>'
			}
		);
		this.addButton('btnUncheck',
			{
				text: 'Uncheck',
				iconCls: 'blist',
				disabled: true,
				handler: uncheckOT,
				tooltip: '<b>Establece una OT en modo Borrador para poder ser modificada nuevamente.</b>'
			}
		);
		
		function checkOT() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			Ext.Ajax.request({
				url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
				params: {
					'id_orden_trabajo': data.id_orden_trabajo, 
					'cat_estado_anterior': data.cat_estado,
					'cat_estado': 'Pendiente'
				},
				success:this.successSave,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
		}
		
		function uncheckOT() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			Ext.Ajax.request({
				url:'../../sis_mantenimiento/control/OrdenTrabajo/procesarOT',
				params: {
					'id_orden_trabajo': data.id_orden_trabajo,
					'cat_estado_anterior': data.cat_estado,
					'cat_estado': 'Borrador'
				},
				success:this.successSave,
				failure: this.conexionFailure,
				timeout:this.timeout,
				scope:this
			});
		}
	},
	preparaMenu: function(n) {
		var tb = Phx.vista.RegistrarOT.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	this.getBoton('btnActividad').setDisabled(false);
	  	if(data.cat_estado == 'Borrador') {
	  		this.getBoton('btnCheck').setDisabled(false);
	  		this.getBoton('btnUncheck').setDisabled(true);
	  		this.getBoton('edit').setDisabled(false);
	  		this.getBoton('del').setDisabled(false);
	  	} else if(data.cat_estado == 'Pendiente') {
	  		this.getBoton('btnCheck').setDisabled(true);
	  		this.getBoton('btnUncheck').setDisabled(false);
	  		this.getBoton('edit').setDisabled(true);
	  		this.getBoton('del').setDisabled(true);
	  	}
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.RegistrarOT.superclass.liberaMenu.call(this);
		this.getBoton('btnCheck').setDisabled(true);
	  	this.getBoton('btnUncheck').setDisabled(true);
	  	this.getBoton('btnActividad').setDisabled(true);
		return tb;
	}
};
</script>
