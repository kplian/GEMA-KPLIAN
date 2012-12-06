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
	nombreVista:'EjecutarOT',
	title:'Registrar Orden Trabajo',
	constructor: function(config) {
		Phx.vista.EjecutarOT.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50, 'nombreVista': 'ejecutarOT'}});
		this.addButton('Abrir', 
			{
				text: 'Abrir',
				iconCls: 'blist',
				disabled: false,
				handler: openOT,
				tooltip: '<b>Abre la Orden de Trabajo para su ejecución</b>'
			}
		);
		this.addButton('Cerrar',
			{
				text: 'Cerrar',
				iconCls: 'blist',
				disabled: false,
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
	  	var data = this.getSelectedData();
		var tb =this.tbar;
  		return tb;
	},
	liberaMenu:function() {
		var tb = Phx.vista.EjecutarOT.superclass.liberaMenu.call(this);
		return tb;
	}
};
</script>
